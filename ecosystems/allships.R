#
# allships.R,  7 Nov 16
# Data from:
# How Much Did The {Liberty} Shipbuilders Forget?
# Peter Thompson
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")

pal_col=rainbow(3)

ships=read.csv(paste0(ESEUR_dir, "ecosystems/allships.csv.xz"), as.is=TRUE)

ships$deldate=as.Date(ships$DELDATE, format="%d%b%Y")
ships$million_hours=as.numeric(ships$MANHOURS)/1e6


ship_kind=function(df)
{
points(df$deldate, df$million_hours, col=df$col)
}


# table(ships$DESCR)
# table(ships$NAME)


Delta_LA=subset(ships, NAME == "Delta - LA")
Delta_LA$col=pal_col[as.factor(Delta_LA$DESCR)]

plot(Delta_LA$deldate, Delta_LA$million_hours, type="n",
	xlab="Delivery date", ylab="Effort (million man hours)\n")

d_ply(Delta_LA, .(DESCR), ship_kind)

legend(x="top", legend=c("Liberty ships", "Colliers", "Tankers"), bty="n", fill=pal_col, cex=1.2)

