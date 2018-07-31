#
# Kolers76.R, 13 Jul 18
# Data from:
# Reading {A} Year Later
# Paul A. Kolers
#
# Example from:
# Evidence-based Software Engineering using R
# Derek M. Jones
#
# TAG experiment human reading learning


source("ESEUR_config.r")


fit_mod=function(df, col_str)
{
i_mod=glm(Time ~ Page, data=df)
# summary(i_mod)
pred=predict(i_mod, newdata=data.frame(Page=xbounds))
lines(10^xbounds, 10^pred, col=col_str)
}


pal_col=rainbow(4)


Kolers=read.csv(paste0(ESEUR_dir, "sourcecode/Kolers76.csv.xz"), as.is=TRUE)

inv=subset(Kolers, Text == "inverted")
inv_y=subset(Kolers, Text == "inverted_y")
norm=subset(Kolers, Text == "normal")
norm_y=subset(Kolers, Text == "normal_y")

xbounds=seq(0, 2.5, by=0.1)


plot(10^inv$Page, 10^inv$Time, log="xy", col=pal_col[1],
	ylim=c(1.3, 16),
	xlab="Pages", ylab="Time (minutes)")
fit_mod(inv, pal_col[1])

points(10^inv_y$Page, 10^inv_y$Time, col=pal_col[2])
fit_mod(inv_y, pal_col[2])

points(10^norm$Page, 10^norm$Time, col=pal_col[3])
fit_mod(norm, pal_col[3])

points(10^norm_y$Page, 10^norm_y$Time, col=pal_col[4])
fit_mod(norm_y, pal_col[4])

legend(x="topright", legend=c("Inverted", "Inverted after year", "Normal", "Normal after year"), bty="n", fill=pal_col, cex=1.2)

