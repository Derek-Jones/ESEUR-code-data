#
# rahman2018.R, 27 Jan 20
# Data from:
# The modular and feature toggle architectures of {Google} {Chrome}
# Md Tajmilur Rahman and Emad Shihab and Peter C. Rigby
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG user-option Chrome_Google file_user-option

source("ESEUR_config.r")


library("plyr")


file_density=function(df)
{
lines(density(log(df$Files), from=0), col=df$col)

}


tf=read.csv(paste0(ESEUR_dir, "sourcecode/rahman2018.csv.xz"), as.is=TRUE)

u_Ver=sort(unique(tf$Version))

pal_col=rainbow(length(u_Ver))
tf$col=mapvalues(tf$Version, u_Ver, pal_col)

plot(0, type="n",
	xaxs="i", yaxs="i",
	xaxt="n",
	xlim=c(0, 7), ylim=c(0, 0.4),
	xlab="Files per option", ylab="Density\n")
axis(1, at=0:7, labels=round(exp(0:7)))

d_ply(tf, .(Version), file_density)

legend(x="topright", legend=paste0("Version ", u_Ver), bty="n", fill=pal_col, cex=1.2)

