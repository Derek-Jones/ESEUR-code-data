#
# e9f6828098808322e53.R,  9 Sep 17
# Data from:
# Sasa M. Dekleva
# The Influence of the Information Systems Development Approach on Maintenance
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(2)


# The Value for Time is hours, all other Values are percent
# Percents, for the same project, should add to 100.  But available
# project id is Age in years (extracted values don't have enough accuracy
# to enable ages to be matched).
maint=read.csv(paste0(ESEUR_dir, "ecosystems/e9f6828098808322e53.csv.xz"), as.is=TRUE)

mtime=subset(maint, Action == "Time")

mod=subset(mtime, Method == "Mod")
trad=subset(mtime, Method == "Trad")

# trad[order(trad$Age), ]

plot(mod$Age, mod$Value, log="y", col=pal_col[1],
	xlim=range(maint$Age), ylim=range(mtime$Value),
	xlab="Age (years)", ylab="Maintenance (hours)\n")
points(trad$Age, trad$Value, col=pal_col[2])

m=loess.smooth(mod$Age, log(mod$Value), span=0.5)
lines(m$x, exp(m$y), col=pal_col[1])
t=loess.smooth(trad$Age, log(trad$Value), span=0.5)
lines(t$x, exp(t$y), col=pal_col[2])

legend(x="bottomright", legend=c("Modern (1992)", "Traditional"), bty="n", fill=pal_col, cex=1.2)

