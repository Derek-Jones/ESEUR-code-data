#
# Nuerk_Wood.R, 20 Mar 17
# Data from:
# The Universal SNARC Effect: {The} Association between Number Magnitude and Space is Amodal
# Hans-Christoph Nuerk and Guilherme Wood and Klaus Willmes
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(2)

resp=read.csv(paste0(ESEUR_dir, "developers/Nuerk_Wood.csv.xz"), as.is=TRUE)

std_err=function(x, mn, se)
{
arrows(x, mn+se, x, mn-se, angle=90, code=3, length=0.02)
}


plot_hand=function(df, col_str)
{
digits=subset(df, Modality == "Arabic")
mn=subset(digits, Stat == "Mean")
se=subset(digits, Stat == "SE")

points(t(mn[1, 5:12]), type="b", col=col_str)
dummy=sapply(5:12, function(X) std_err(X-4, mn[1, X], se[1, X]))
}


err_rate=subset(resp, Response == "Error")
r_hand=subset(err_rate, Hand == "Right")
l_hand=subset(err_rate, Hand == "Left")

plot(0, type="n",
	xlim=c(1, 8), ylim=c(1, 13),
	xlab="Arabic digit", ylab="Error rate (%)")

plot_hand(l_hand, pal_col[1])
plot_hand(r_hand, pal_col[2])

legend(x="topright", legend=c("Left hand", "Right hand"), bty="n", fill=pal_col, cex=1.2)

