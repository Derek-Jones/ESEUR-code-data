#
# Martin_Douglas.R,  7 Jan 20
# Data from:
# An Empirical Analysis of {GNU} {Make} Feature Use in Open Source Projects
# Douglas Martin
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Dependencies_make file_length

source("ESEUR_config.r")


library("plyr")


ca=read.csv(paste0(ESEUR_dir, "sourcecode/Martin_Douglas.csv.xz"), as.is=TRUE)

gen_str=unique(ca$generated)
pal_col=rainbow(length(gen_str))
ca$col_str=mapvalues(ca$generated, gen_str, pal_col)

plot(type="n", ca$lines, ca$rule.dependencies, log="xy",
	xlab="Lines", ylab="Rule dependencies\n")
d_ply(ca, .(generated), function(df) points(df$lines, df$rule.dependencies, col=df$col_str[1]))

legend(x="topleft", legend=gen_str, bty="n", fill=pal_col, cex=1.2)

