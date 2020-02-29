#
# patch-len.R,  1 Feb 20
#
# Data from:
# A Study of Linux File System Evolution
# Lanyue Lu and Andrea C. Arpaci-Dusseau and Remzi H. Arpaci-Dusseau and Shan Lu
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Linux_file-system commit


source("ESEUR_config.r")


library("plyr")

pal_col=rainbow(2)

p_inf=read.csv(paste0(ESEUR_dir, "maintenance/fs-patch/p-all.csv.xz"), as.is=TRUE)
y_bounds=c(1, 400)
x_bounds=c(0.9, 100)

plot_kind=function(kind_str)
{
kind=subset(p_inf, kind == kind_str)

k_added=kind$added[kind$added < 100]
# print(c(length(k_added), mean(k_added), sd(k_added)))

plot(count(k_added), type="p", log="xy", col=pal_col[1],
	xaxs="i",
	xlim=x_bounds, ylim=y_bounds,
	xlab="Commit length (lines)", ylab="Commits\n")

k_del=kind$deleted[kind$deleted < 100]
# print(c(length(k_del), mean(k_del), sd(k_del)))

points(table(k_del), col=pal_col[2], type="p")

legend(x="topright", legend=c("Added", "Deleted"), bty="n", fill=pal_col, cex=1.2)
}

plot_kind("bug")
# plot_kind("performance")
# plot_kind("reliability")
# plot_kind("maintenance")
# plot_kind("feature")


