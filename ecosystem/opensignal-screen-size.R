#
# opensignal-screen-size.R, 11 Nov 15
#
# Data from:
#
# ANDROID FRAGMENTATION VISUALIZED (AUGUST 2015)
# This data is provided by OpenSignal.com and is licensed according to Creative Commons Attribution and ShareAlike License (BY-SA).
# If you have any questions on OpenSignal data licensing or anything else please email sam@opensignal.com
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


screen=read.csv(paste0(ESEUR_dir, "ecosystem/2015_08_screen_sizes.csv.xz"), as.is=TRUE)

pal_col=rainbow_hcl(3)


plot(screen$width, screen$height,
	xlab="Width (inches)", ylab="Height (inches)")

rot=(screen$width > screen$height)

screen$rot=rot

scr_mod=glm(height ~ width, data=screen)
summary(scr_mod)


clean_scr=screen

clean_scr$t=clean_scr$height
clean_scr$height[rot]=clean_scr$width[rot]
clean_scr$width[rot]=clean_scr$t[rot]

# Need to factor in totals
# smoothScatter(clean_scr$width, clean_scr$height, type="n")
# points(clean_scr$width, clean_scr$height, cex=log(clean_scr$total)-2, pch="*")

plot(clean_scr$width, clean_scr$height, type="n",
	xlab="Width (inches)", ylab="Height (inches)")

points(clean_scr$width, clean_scr$height, cex=log(clean_scr$total)-2, pch="*")

