#
# grumroad.R,  7 Mar 17
# Data from:
# A Penny Saved: Psychological Pricing
# Travis Nichols
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(2)

gum=read.csv(paste0(ESEUR_dir, "economics/gumroad.csv.xz"), as.is=TRUE)

plot(gum$price, gum$conversion.rate, col=pal_col[1],
	xlim=c(1, 6.2),
	xlab="Price ($)", ylab="Conversion rate (%)")

dummy=sapply(1:6, function(X) lines(c(gum$price[X*2], gum$price[X*2-1]),
				c(gum$conversion.rate[X*2], gum$conversion.rate[X*2-1]),
					col=pal_col[2]))

text(gum$price, gum$conversion.rate, gum$price, pos=4)

