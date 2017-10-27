#
# est_embedded.R, 13 Aug 17
# Data from:
# A Practical Approach to Size Estimation of Embedded Software Components
# Kenneth Lind and Rogardt Heldal
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")


plot_series=function(df)
{
points(df$CFP, df$KBytes, col=pal_col[df$Series])

mod=glm(KBytes ~ CFP, data=df)
pred=predict(mod)
lines(df$CFP, pred, col=pal_col[df$Series])
}


cfp=read.csv(paste0(ESEUR_dir, "projects/est_embedded.csv.xz"), as.is=TRUE)
cfp$KBytes=cfp$Bytes/2^10

pal_col=rainbow(max(cfp$Series))

plot(cfp$CFP, cfp$KBytes, type="n",
	xlab="CFP", ylab="Size (Kbytes)")

d_ply(cfp, .(Series), plot_series)


