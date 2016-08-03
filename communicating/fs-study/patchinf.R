#
# patchinf.R, 15 Jul 16
#
# Data from:
# A Study of Linux File System Evolution
# Lanyue Lu and Andrea C. Arpaci-Dusseau and Remzi H. Arpaci-Dusseau and Shan Lu
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


plot_layout(2, 1)

ext3=read.csv(paste0(ESEUR_dir, "communicating/fs-study/ext3-added.csv.xz"), as.is=TRUE)

plot_density=function(df, col_num)
{
len_vec=rep(df$length, times=df$count)
lines(density(len_vec), col=pal_col[col_num])
}

plot_patch=function(df, col_num)
{
df=df[order(df$length), ]
#points(df$length, df$count, col=pal_col[col_num])
lines(df$length, df$count, col=pal_col[col_num])
}


pal_col=rainbow(5)

plot(0, log="xy", type="n",
	xlim=c(1, 100), ylim=c(1, 60),
	xlab="Lines of code", ylab="Occurrences")
plot_patch(subset(ext3, patch == "b"), 1)
plot_patch(subset(ext3, patch == "m"), 2)
plot_patch(subset(ext3, patch == "p"), 3)
plot_patch(subset(ext3, patch == "c"), 4)
plot_patch(subset(ext3, patch == "f"), 5)



plot(0, type="n", log="x",
	xlim=c(1, 100), ylim=c(0.001, 0.06),
	xlab="Lines of code", ylab="Occurrences (density)\n")

plot_density(subset(ext3, patch == "b"), 1)
plot_density(subset(ext3, patch == "m"), 2)
plot_density(subset(ext3, patch == "p"), 3)
plot_density(subset(ext3, patch == "c"), 4)
plot_density(subset(ext3, patch == "f"), 5)

legend(x="topright", legend=c("Bug", "Maintenance", "Performance", "Reliability", "Feature"), bty="n", fill=pal_col, cex=1.3)

