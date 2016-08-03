#
# depvar_not_log.R, 13 Jul 16
#
# Data from:
# On the variation and specialisation of workload - A case study of the Gnome ecosystem community
# Bogdan Vasilescu and Alexander Serebrenik and Mathieu Goeminne and Tom Mens
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

plot_layout(2, 1)
pal_col=rainbow(3)

aw_path = paste0(ESEUR_dir, "regression/AW.csv.xz")
nta_path = paste0(ESEUR_dir, "regression/NTA.csv.xz")

AW = read.csv(file=aw_path, head=TRUE, sep=";")
NTA = read.csv(file=nta_path, head=TRUE, sep=";")

mdf = merge(AW, NTA)

# Ignore 'unknown' activities
# Authors with 14 activities become authors with 13 activities
mdf1 = mdf
mdf1[which(mdf1$NTA == 14),]$NTA = 13

plot(mdf1$NTA, mdf1$AW, log="y", col=point_col,
	xlab="Activity types per author", ylab="Author workload\n")


plot(0, type="n", log="y",
	xlim=c(0, 12), ylim=c(1e-3, 1e4),
	xlab="Activity types per author", ylab="Ratio\n")

points(mdf1$NTA, mdf1$AW/mdf1$NTA, col=pal_col[1])
points(mdf1$NTA, mdf1$AW/mdf1$NTA^2, col=pal_col[2])
points(mdf1$NTA, mdf1$AW/exp(mdf1$NTA), col=pal_col[3])

legend(x="bottomleft", legend=c("Linear", "Quadratic", "Exponential"), bty="n", fill=pal_col, cex=1.3)

