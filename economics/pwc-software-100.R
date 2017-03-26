#
# pwc-software-100.R,  8 Mar 17
# Data from:
# PwC Global 100 Software Leaders 2011
# PwC Global 100 Software Leaders 2012
# PwC Global 100 Software Leaders 2014
# www.pwc.com/globalsoftware100
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("plyr")


pal_col=rainbow(3)

plot_year=function(df)
{
# plot(df$Software.revenue, df$SaaS.revenue, log="xy")
lines(df$Rank, df$Software.revenue, col=df$col_str[1])
lines(sort(df$SaaS.revenue, decreasing=TRUE), col=df$col_str[1])
}


pwc=read.csv(paste0(ESEUR_dir, "economics/pwc-software-100.csv.xz"), as.is=TRUE)

pwc$col_str=mapvalues(pwc$Year, c(2014, 2012, 2011), pal_col)

plot(pwc$Rank, pwc$Software.revenue, type="n", log="xy",
	xlab="Rank", ylab="Revenue (million $)\n")

d_ply(pwc, .(Year), plot_year)

legend(x="topright", legend=c("2014", "2012", "2011"), bty="n", fill=pal_col, cex=1.2)

text(16, 5000, "Total", cex=1.2)
text(1.6, 5000, "SaaS", cex=1.2)

