#
# Little-change.R, 23 Oct 17
#
# Data from:
# Schedule Estimation and Uncertainty Surrounding the Cone of Uncertainty
# Todd Little
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")

# plot_layout(2, 1)

pal_col=rainbow(2)

# Project Code,Week End Date,Target RelDate,Env,Plan,Dev,Stab,Mob,Adj Week,Est EndDate,First Est,Actual Release,Start Date,X,Absolute Ratio,Relative Ratio,Update,Absolute ratio without factor 2,,Eind project,Oppervlakte,Counter,Som oppervlakte,EQF all,EQF end,Eind project factor 2,Oppervlakte factor 2,Counter factor 2,Som oppervlakte factor 2,EQF all factor 2,EQF end factor 2
# 1,12/01/00,03/01/01,C,C,I,,,12/01/00,03/01/01,03/01/01,08/22/01,12/01/00,0.00,0.6770156819,2.95,1,0.33851,,0,0.0085951791,1,0,4235.7284514877,0,0,0.0176034663,1,0,#DIV/0!,0
est=read.csv(paste0(ESEUR_dir, "projects/Little06.csv.xz"), as.is=TRUE)

est$Week.End.Date=as.Date(est$Week.End.Date, format="%m/%d/%y")
est$Target.RelDate=as.Date(est$Target.RelDate, format="%m/%d/%y")
est$Adj.Week=as.Date(est$Adj.Week, format="%m/%d/%y")
est$Est.EndDate=as.Date(est$Est.EndDate, format="%m/%d/%y")
est$First.Est=as.Date(est$First.Est, format="%m/%d/%y")
est$Actual.Release=as.Date(est$Actual.Release, format="%m/%d/%y")
est$Start.Date=as.Date(est$Start.Date, format="%m/%d/%y")
est$act_duration=est$Actual.Release-est$Start.Date

est$percent_comp=100*as.integer(est$Week.End.Date-est$Start.Date)/as.integer(est$Actual.Release-est$Start.Date)
est$AE_ratio=as.integer(est$Actual.Release-est$Start.Date)/as.integer(est$Target.RelDate-est$Start.Date)


mk_target_unique=function(df)
{
# The same Target release date might be estimated again after a change of date,
# so duplicated cannot be used.  rle only works with atomic types
t=cumsum(c(1, head(rle(as.integer(df$Target.RelDate))$lengths, n=-1)))
return(df[t, ])
}


# est_change=function(df)
# {
# points(df$Week.End.Date-df$Start.Date,
# 	c(NA, diff(df$Target.RelDate)),
# 	col=point_col)
# df$days_done=df$Week.End.Date-df$Start.Date
# df$change_diff=c(NA, diff(df$Target.RelDate))
# 
# return(df)
# }
# 
# 
# dur_change=function(df)
# {
# points(df$Target.RelDate-df$Start.Date,
# 	c(NA, diff(df$Target.RelDate)),
# 	col=point_col)
# df$dur_ch=df$Target.RelDate-df$Start.Date
# df$diff=c(NA, diff(df$Target.RelDate))
# 
# return(df)
# }
# 
# 
# change_number=function(df)
# {
# points(100*diff(df$Target.RelDate)/as.integer(tail(df$Target.RelDate-df$Start.Date, n=-1)),
# 	col=point_col)
# # Using NA as the last element generates the error:
# # Error in FUN(X[[i]], ...) : 'tim' is not character or numeric
# df$ratio=c(100*diff(df$Target.RelDate)/as.integer(tail(df$Target.RelDate-df$Start.Date, n=-1)), 0)
# 
# return(df)
# }


change_percent=function(df)
{
points(100*tail(as.integer(df$Week.End.Date-df$Start.Date)/as.integer(df$Target.RelDate-df$Start.Date), n=-1),
       100*diff(df$Target.RelDate)/as.integer(tail(df$Target.RelDate-df$Start.Date, n=-1)),
	col=point_col)
df$percent_done=100*as.integer(df$Week.End.Date-df$Start.Date)/as.integer(df$Target.RelDate-df$Start.Date)
# Using NA as the last element generates the error:
# Error in FUN(X[[i]], ...) : 'tim' is not character or numeric
df$ratio=c(100*diff(df$Target.RelDate)/as.integer(tail(df$Target.RelDate-df$Start.Date, n=-1)), 0)

return(df)
}


est=subset(est, Week.End.Date <= Actual.Release)
u_est=ddply(est, .(Project.Code), mk_target_unique)

# plot(0, type="n",
# 	xlim=range(u_est$Week.End.Date-u_est$Start.Date), ylim=c(-50, 50),
# 	xlab="Days into project", ylab="Change difference")
# 
# t=ddply(u_est, .(Project.Code), est_change)
# lines(loess.smooth(t$days_done, t$change_diff, span=0.3), col=loess_col)
# 
# plot(0, type="n",
# 	xlim=range(u_est$Target.RelDate-u_est$Start.Date), ylim=c(-250, 250),
# 	xlab="Estimated duration", ylab="Change diff")
# 
# t=ddply(u_est, .(Project.Code), dur_change)
# 
# plot(0, type="n",
# 	xlim=c(1, 28), ylim=c(-75, 75),
# 	xlab="Change number", ylab="Change ratio")
# 
# t=ddply(u_est, .(Project.Code), change_number)
# lines(loess.smooth(1:nrow(t), t$ratio, span=0.3), col=loess_col)
# 
# 
plot(0, type="n",
	xlim=c(0, 100), ylim=c(-75, 75),
	xlab="Estimated percentage complete", ylab="Change percentage")

t=ddply(u_est, .(Project.Code), change_percent)
lines(loess.smooth(t$percent_done, t$ratio, span=0.3), col=pal_col[1])

q=density(t$percent_done, from=0, to=100)
q$y=q$y*150/max(q$y)-75
lines(q, col=pal_col[2])

# plot(density(t$percent_done, from=0, to=100), col=point_col,
# 		main="",
# 		xlab="Estimated percentage complete", ylab="Announcement density\n")

# quantile(t$percent_done)
# t$percent_done[which(t$percent_done > 100)]

