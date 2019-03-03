#
# 31-249-1-PB.R, 19 Feb 19
# Data from:
# Simple and Complex Working Memory Tasks Allow Similar Benefits of Information Compression
# Fabien Mathy and Mustapha Chekaf and Nelson Cowan
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG example experiment human memory

source("ESEUR_config.r")


plot_layout(2, 1)

pal_col=rainbow(4)


# Based on Figure 1

plot(0, type="n", bty="n",
        xaxt="n", yaxt="n",
	xlim=c(0.3, 4.3), ylim=c(1, 4.1),
	xlab="", ylab="")


text(0.3, 4, 1)
text(0.3, 3, 2)
text(0.3, 2, 3)
text(0.3, 1, 4)

points(1, 1, pch=17, col=pal_col[1], cex=5)
points(2, 1, pch=17, col=pal_col[3], cex=3)
points(3, 1, pch=15, col=pal_col[1], cex=3)
points(4, 1, pch=15, col=pal_col[3], cex=5)

points(1, 2, pch="+", col=pal_col[2], cex=3)
points(2, 2, pch=19, col=pal_col[4], cex=5)
points(3, 2, pch="+", col=pal_col[4], cex=3)
points(4, 2, pch="+", col=pal_col[2], cex=5)

points(1, 3, pch=18, col=pal_col[1], cex=3)
points(2, 3, pch=18, col=pal_col[3], cex=3)
points(3, 3, pch=15, col=pal_col[1], cex=5)
points(4, 3, pch=15, col=pal_col[3], cex=5)


points(1, 4, pch=17, col=pal_col[4], cex=3)
points(2, 4, pch=17, col=pal_col[4], cex=5)
points(3, 4, pch=19, col=pal_col[4], cex=3)
points(4, 4, pch=19, col=pal_col[4], cex=5)

# points(1, 1, pch=17, col=pal_col[1], cex=4)
# points(2, 1, pch=18, col=pal_col[1], cex=4)
# points(3, 1, pch=19, col=pal_col[1], cex=4)
# points(4, 1, pch=15, col=pal_col[1], cex=4)
# points(5, 1, pch=8, col=pal_col[1], cex=4)
# points(3, 2, pch="+", col=pal_col[1], cex=5)



pal_col=rainbow(2)


plot_point=function(df, col_str, x_offset)
{
r_mean=mean(df$span)
r_sd=sd(df$span)

points(x_offset, r_mean, col=col_str)

arrows(x_offset, r_mean,
		x_offset, r_mean-r_sd, col=col_str,
		length=0.1, angle=90, lwd=1.3)
arrows(x_offset, r_mean,
		x_offset, r_mean+r_sd, col=col_str,
		length=0.1, angle=90, lwd=1.3)

return(r_mean)
}


stimuli_line=function(df, col_str)
{
i_mean=plot_point(subset(df, stimuliType == "irregular"), col_str, 1)
r_mean=plot_point(subset(df, stimuliType == "rule"), col_str, 2)

print(c(i_mean, r_mean))

lines(c(1, 2), c(i_mean, r_mean), col=col_str)
}


PB=read.csv(paste0(ESEUR_dir, "developers/31-249-1-PB.csv.xz"), as.is=TRUE)


simp=subset(PB, taskType == "simple")
comp=subset(PB, taskType == "complex")

plot(0, type="n",
	xaxt="n", yaxp=c(1, 4, 3),
	xlim=c(0.8, 2.2), ylim=c(1, 4.5),
	xlab="", ylab="Span")

axis(1, at=c(1, 2), labels=c("irregular", "rule"))

stimuli_line(simp, pal_col[1])
stimuli_line(comp, pal_col[2])

legend(x="topleft", legend=c("Simple", "Complex"), bty="n", fill=pal_col, cex=1.2)

# stimuli_line(simp, pal_col[1])
# [1] 2.579903 4.232120
# stimuli_line(comp, pal_col[2])
# [1] 1.603226 2.457675

