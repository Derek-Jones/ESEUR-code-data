#
# daneman1980.R, 12 Jul 18
# Data from:
# Individual Differences in Working Memory and Reading
# Meredyth Daneman and Patricia A. Carpenter
#
# Example from:
# Evidence-based Software Engineering using R
# Derek M. Jones
#
# TAG experiment reading prose comprehension


source("ESEUR_config.r")


library("plyr")

pal_col=rainbow(4)


plot_span=function(df)
{
lines(df$Distance, df$Correct, col=df$col_str, type="b")
}


dane=read.csv(paste0(ESEUR_dir, "sourcecode/daneman1980.csv.xz"), as.is=TRUE)

dane$col_str=mapvalues(dane$Read_span, 2:5, pal_col)

plot(0, type="n",
	xaxt="n",
	xlim=c(1, 3), ylim=range(dane$Correct),
	xlab="Sentences between information", ylab="Correct (percent)\n")
axis(1, at=1:3, labels=c("2-3", "4-5", "6-7"))

d_ply(dane, .(Read_span), plot_span)

# Align legend colors with plot order
legend(x="bottomleft", legend=paste0("reading span ", 5:2), bty="n", fill=rev(pal_col), cex=1.2)

