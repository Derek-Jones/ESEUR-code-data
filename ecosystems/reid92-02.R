#
# reid92-02.R, 29 Jul 19
# Data from:
# The {Reid} list of the First Course Language for Computer Science Majors
# Richard J. Reid
# via Wayback Machine
# Typos corrected, University names regularized.
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG undergraduate language_first teaching

source("ESEUR_config.r")


library("plyr")


uni_total=function(df)
{
tot_l=count(df$language)
tot_l$x=as.character(tot_l$x)
tot_l$perc=100*tot_l$freq/sum(tot_l$freq)

return(subset(tot_l, tot_l$perc > 3))
}


plot_uni=function(df)
{
lines(df$date, df$perc, col=df$col_str[1])
}


rd=read.csv(paste0(ESEUR_dir, "ecosystems/reid92-02.csv.xz"), as.is=TRUE, sep=";")

rd$date=as.Date(rd$date, format="%m-%d-%y")
rd$lang=sub("Modula$", "Modula-2", rd$lang) # More likely than Modula-3

plot(rd$date[1], 0.1, type="n",
	xlim=range(rd$date), ylim=c(5, 50),
	xlab="Date", ylab="Universities (percentage)\n")

sum_uni=ddply(rd, .(date), uni_total)

# Make sure the most popular language are listed first
u_lang=unique(c("Pascal", "C++", "Scheme", sum_uni$x))

pal_col=rainbow(length(u_lang))

sum_uni$col_str=as.character(mapvalues(sum_uni$x, u_lang, pal_col))

d_ply(sum_uni, .(x), plot_uni)

legend(x="topright", legend=u_lang, bty="n", fill=pal_col, cex=1.2)

