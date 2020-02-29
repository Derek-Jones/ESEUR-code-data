#
# 2506-gcj.R,  8 Jan 20
# Data from:
# Comparing Programming Languages in {Google} Code Jam
# Alexandra Back and Emma Westman
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Google_competition competition_code

source("ESEUR_config.r")


library("plyr")


pal_col=rainbow(5)


line_freq=function(df)
{
cl=count(df$lines)
lines(cl$x, cl$freq, col=df$col_str[1])
return(cl)
}

# Counts from running wc on solution source.
# 399 entries with the same SHA1 hash have been removed.
# lines,characters,problem,language,author
gcj=read.csv(paste0(ESEUR_dir, "sourcecode/2506-gcj.csv.xz"), as.is=TRUE)

# gcj=subset(gcj, lines < 5000)
# plot(gcj$lines, gcj$characters, log="xy")
# 
prob_ent=ddply(gcj, .(problem), function(df) return(nrow(df)))

max_sol=subset(prob_ent, V1 == max(V1))

most_sol=subset(gcj, problem == max_sol$problem)

u_lang=unique(c("Python", "C++", "Java", most_sol$language))
most_sol$col_str=mapvalues(most_sol$language, u_lang, pal_col)

plot(1, type="n", log="x",
	yaxs="i",
	xlim=c(8, 110), ylim=c(0, 60),
	xlab="Lines", ylab="Solutions\n")

sol_len=ddply(most_sol, .(language), line_freq)

legend(x="topleft", legend=u_lang, bty="n", fill=pal_col, cex=1.2)


