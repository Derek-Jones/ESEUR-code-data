#
# hyper-dis.R, 13 Nov 17
# Data from:
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(2)


plot_hype=function(V, delay, col_str)
{
lines(V/(1+k*(max(delay)-1:delay)), col=col_str)
lines(c(delay, delay), c(0, V), col=col_str)
text(delay, V, "amount", pos=2)
# text(delay, 2, "reward", pos=2)
}


k=0.02

plot(0, type="n",
	xaxs="i",
	xaxt="n", yaxt="n",
	xlim=c(1, 100), ylim=c(2, 10),
	xlab="Time", ylab="Perceived present value")
axis(1, at=c(1, 55, 100), label=c("Start", "reward", "reward"), cex.axis=1.0)
plot_hype(10, 100, pal_col[1])
plot_hype(6, 55, pal_col[2])


