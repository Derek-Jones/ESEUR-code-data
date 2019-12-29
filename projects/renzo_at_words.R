#
# renzo_at_words.R, 20 Dec 19
# Data from:
# The {Renzo} {Pomodoro} dataset: a conversation
# Derek M. Jones and Renzo Borgatti
#
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG estimate Pomodoro personal

source("ESEUR_config.r")


library("plyr")


clean_at_1_names=function(vec)
{
vec=sub("^@ad$", "@ads", vec)
vec=sub("^@addintsr$", "@addinstr", vec)
vec=sub("^@apilesupport$", "@agilesupport", vec)
vec=sub("^@agilesuppport$", "@agilesupport", vec)
vec=sub("^@applenew$", "@applenews", vec)
vec=sub("^@asl$", "@ask", vec) # one occurrence
vec=sub("^@axis$", "@axes", vec)
vec=sub("^@bugs$", "@bug", vec)
vec=sub("^@charts$", "@chart", vec)
vec=sub("^@clj_fe$", "@clj-fe", vec)
vec=sub("^@cljfe$", "@clj-fe", vec)
vec=sub("^@clojutre$", "@clojure", vec)
vec=sub("^@clojure-ug$", "@clojureug", vec)
vec=sub("^@cotract$", "@contract", vec)
vec=sub("^@cointains$", "@contains", vec)
vec=sub("^@contracts$", "@contract", vec)
vec=sub("^@courses$", "@course", vec)
vec=sub("^@emails$", "@email", vec)
vec=sub("^@filters$", "@filter", vec)
vec=sub("^@fonts$", "@font", vec)
vec=sub("^@hardning$", "@hardening", vec)
vec=sub("^@invitation$", "@invitations", vec)
vec=sub("^@Invitations$", "@invitations", vec)
vec=sub("^@interviews$", "@interview", vec)
vec=sub("^@job$", "@jobs", vec)
vec=sub("^@leftover$", "@leftovers", vec)
vec=sub("^@likelt$", "@likely", vec)
vec=sub("^@logistics$", "@logistic", vec)
vec=sub("^@meeeting$", "@meeting", vec)
vec=sub("^@meetings$", "@meeting", vec)
vec=sub("^@merckmanual$", "@merkmanual", vec)
vec=sub("^@moneymorgages$", "@moneymortgages", vec)
vec=sub("^@mortgages-api$", "@mortgagesapi", vec)
vec=sub("^@mturk$", "@turk", vec)
vec=sub("^@paralell$", "@parallel", vec)
vec=sub("^@payments$", "@payment", vec)
vec=sub("^@persona$", "@personal", vec)
vec=sub("^@persistece$", "@persistence", vec)
vec=sub("^@plannin$", "@planning", vec)
vec=sub("^@planing$", "@planning", vec)
vec=sub("^@plannig$", "@planning", vec)
vec=sub("^@plannng$", "@planning", vec)
vec=sub("^@pomodoros$", "@pomodoro", vec)
vec=sub("^@pomodori$", "@pomodoro", vec)
vec=sub("^@presets$", "@preset", vec)
vec=sub("^@prjsats$", "@prjstats", vec)
vec=sub("^@puechase$", "@purchase", vec)
vec=sub("^@questions$", "@question", vec)
vec=sub("^@sortedmap$", "@sorted-map", vec)
vec=sub("^@spikes$", "@spike", vec)
vec=sub("^@talks$", "@talk", vec)
vec=sub("^@tickets$", "@ticket", vec)
vec=sub("^@unexpectd$", "@unexpected", vec)
vec=sub("^@uplanned$", "@unplanned", vec)
vec=sub("^@users$", "@user", vec)
vec=sub("^@uswtich$", "@uswitch", vec)
vec=sub("^@wewkly$", "@weekly", vec)

return(vec)
}


mk_day_at_list=function(df)
{
d_at=paste0(df$at_1, collapse=",")
return(data.frame(date=df$date[1], d_at,  stringsAsFactors=FALSE))
}


# Number each at word by number of previous occurrences (plus 1)
number_at=function(df)
{
df$at_order=1:nrow(df)
return(df)
}


rm_cut_paste=function(tasks)
{
# Remove same day tasks appearing outside and inside of DONE
t=ddply(tasks, .(date, description),
                        function(df)
                           if (nrow(df) == 1) df else subset(df, DONE == 1))
return(t)
}


rm_dup_DONE=function(tasks)
{
   rm_succ_DONE=function(df)
   {
   done=subset(df, DONE == 1)
   not_done=subset(df, DONE != 1)
   # Add an entry so length==nrow(df), and we want to remove the second DONE
   day_diff=c(10, diff(done$day_num))
   # Both tasks are DONE and seperated by 1-day
   return(rbind(not_done, subset(done, day_diff > 1)))
   }

# Remove same tasks appearing in two successive DONE sections
t=ddply(tasks, .(description),
                        function(df)
                           if (nrow(df) == 1) df
                             else if (sum(df$DONE) <= 1) df
                                else rm_succ_DONE(df))
return(t)
}


all_items=read.csv(paste0(ESEUR_dir, "projects/renzo-all-tasks.csv.xz"), as.is=TRUE)

all_items$date=as.Date(all_items$date, format="%Y-%m-%d")

items=subset(all_items, X.words != "")
items=subset(items, estimate < 20)

items=rm_cut_paste(items)
items=rm_dup_DONE(items)

items=items[order(items$date), ]

at=strsplit(items$X.words, ",")
# Need to convert the list returned by strsplit
at_1=clean_at_1_names(unlist(lapply(at, function(l) l[1])))
items$at_1=at_1

day_pomo=ddply(items, .(date), mk_day_at_list)
da=strsplit(day_pomo$d_at, ",")

u_at=unique(at_1)
pal_col=rainbow(length(u_at))

items$uat_1_num=as.integer(mapvalues(items$at_1, u_at, 1:length(u_at)))

plot(items$date, items$uat_1_num, col=pal_col[items$uat_1_num],
	xaxs="i", yaxs="i",
	xlab="Date", ylab="@word\n")

t=count(items$uat_1_num)
top5=subset(t, freq > 500)

legend(x="topleft", legend=rev(substring(u_at[top5$x], 2)), bty="n", fill=rev(pal_col[top5$x]), cex=1.3)

first_use=ddply(items, .(uat_1_num), function(df) min(df$date))
start_date=min(first_use$V1)
first_use$days=as.integer(first_use$V1-start_date)

# Pick changepoints by experimenting by eye
# points(start_date+1100, 100)
# points(start_date+2100, 140)

# # fu_mod=nls(days ~ a*uat_1_num^b, data=first_use)
# fu_mod=nls(uat_1_num ~ a*days^b, data=first_use)
# # summary(fu_mod)
# 
# pred=predict(fu_mod)
# lines(start_date+first_use$days, pred, col=point_col)

days_1=subset(first_use, (days < 1100))
fu_1_mod=nls(uat_1_num ~ a*(1-exp(b*days)), data=days_1,
		start=list(a=100, b=-0.05))
# summary(fu_1_mod)
pred=predict(fu_1_mod)
lines(start_date+days_1$days, pred, col="white")

days_2=subset(first_use, (days >= 1100) & (days <= 2100))
fu_2_mod=glm(uat_1_num ~ days, data=days_2)
# summary(fu_2_mod)
pred=predict(fu_2_mod)
lines(start_date+days_2$days[1:length(pred)], pred, col="white")

days_3=subset(first_use, (days > 2100))
fu_3_mod=nls(uat_1_num ~ c+a*(1-exp(b*(days-2100))), data=days_3,
		start=list(c=140, a=80, b=-0.05))
# summary(fu_3_mod)
pred=predict(fu_3_mod)
lines(start_date+days_3$days, pred, col="white")

