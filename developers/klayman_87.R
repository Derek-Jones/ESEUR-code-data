#
# klayman_87.R,  5 Jan 18
# Data from:
# Based on plot in:
# Joshua Klayman and Young-Won Ha
# Confirmation, Disconfirmation, and Information in Hypothesis Testing
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


plot_layout(3, 2)

pal_col=rainbow(3)


draw_circle=function(x, y=0.5, rad=0.4)
{
angles<-seq(0, 2*pi, by=0.01)
xt<-x+cos(angles)*rad
yt<-y+sin(angles)*rad
polygon(xt, yt, border="grey")
}

plot_universe=function(x_str)
{
plot(0, type="n", bty="o", cex.lab=1.6,
	xaxt="n", yaxt="n",
	xlim=c(0, 7/4), ylim=c(0, 1),
	xlab=x_str, ylab="")

text(1.6, 0.9, "A", cex=2, col=pal_col[1])
text(0.6, 0.5, "E", cex=2, col=pal_col[2])
text(1.0, 0.5, "S", cex=2, col=pal_col[3])
}

plot_universe("1")
draw_circle(0.8)

plot_universe("2")
draw_circle(0.8)
draw_circle(1.0, rad=0.15)

plot_universe("3")
draw_circle(0.8)
draw_circle(0.6, rad=0.15)

plot_universe("4")
draw_circle(0.5)
draw_circle(1.1)

plot_universe("5")
draw_circle(0.38)
draw_circle(1.22)

plot(0, type="n", bty="n",
        xaxt="n", yaxt="n",
        xlim=c(0, 7/4), ylim=c(0, 1),
        xlab="", ylab="")

text(0.2, 0.7, "A", cex=2, col=pal_col[1])
text(0.23, 0.68, "ll possible rules", cex=2, pos=4)

text(0.2, 0.5, "E", cex=2, col=pal_col[2])
text(0.23, 0.48, "xperimenter rule", cex=2, pos=4)

text(0.2, 0.3, "S", cex=2, col=pal_col[3])
text(0.23, 0.28, "ubject hypothesis", cex=2, pos=4)

