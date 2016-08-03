#
# opensignal-screen-size.R, 15 Jul 16
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


plot_layout(2, 1)

screen=read.csv(paste0(ESEUR_dir, "data-check/2015_08_screen_sizes.csv.xz"), as.is=TRUE)

pal_col=rainbow(2)


plot(screen$width, screen$height, col=point_col,
	xlab="Width (inches)", ylab="Height (inches)")

rot=(screen$width > screen$height)

screen$rot=rot

# scr_mod=glm(height ~ width, data=screen)
# summary(scr_mod)


clean_scr=screen

clean_scr$t=clean_scr$height
clean_scr$height[rot]=clean_scr$width[rot]
clean_scr$width[rot]=clean_scr$t[rot]

# Need to factor in totals
# smoothScatter(clean_scr$width, clean_scr$height, type="n")
# points(clean_scr$width, clean_scr$height, cex=log(clean_scr$total)-2, pch="*")

# plot(clean_scr$width, clean_scr$height, type="n",
# 	xlab="Width (inches)", ylab="Height (inches)")

# points(clean_scr$width, clean_scr$height, cex=log(clean_scr$total)-2, pch="*")

plot(clean_scr$width, clean_scr$height, type="n",
	xlab="Width (inches)", ylab="")

points(screen$height[rot], screen$width[rot], col=pal_col[1])
points(screen$width[!rot], screen$height[!rot], col=pal_col[2])

# scr_mod=glm(height ~ width, data=clean_scr)
# summary(scr_mod)

# wscr_mod=glm(height ~ width, data=clean_scr, weight=log(total))
# summary(wscr_mod)

