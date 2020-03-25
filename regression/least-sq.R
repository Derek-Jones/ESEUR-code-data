#
# least-sq.R, 14 Mar 20
#
# Data from:
# github.com/gregkh/kernel-history
# Last updated Jun 2016
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Linux_commits


source("ESEUR_config.r")


plot_layout(2, 1)

pal_col=rainbow(3)

# version,date released,days,commits,number files,number lines,lines added,lines removed,lines modified,number developers,number employers,changes per day,changes per hour,% growth files,% growth lines,lines added per day,lines removed per day,lines changed per day,lines added per hour
ks=read.csv(paste0(ESEUR_dir, "regression/kernel_stats.csv.xz"), as.is=TRUE)

# Only lines in previous release can be counted as modified
#ks$percent_mod=100*c(NA, ks$lines.modified[-1]/ks$number.lines[-nrow(ks)])

#ks$percent_mod=ks$lines.modified/ks$number.lines

#ks$date.released=as.Date(ks$date.released, format="%d/%m/%y")


ks_na=na.omit(ks)

x = ks_na$number.developers
y = ks_na$commits

yx_line = glm(y ~ x) # Assume x values do not contain any error
xy_line = glm(x ~ y) # Assume y values do not contain any error

plot(y ~ x, col=pal_col[2],
	xlab="", ylab="Commits\n")
yx_pred=predict(yx_line)
lines(x, yx_pred, col=pal_col[1])

# Draw error lines to fitted line
segments(x, y, x, fitted(yx_line), lty = 2, col =pal_col[1]) # vertical line

plot(y ~ x, col=pal_col[2],
	xlab="Developers", ylab="Commits\n")

yx_pred=predict(yx_line)
lines(x, yx_pred, col=pal_col[1])

# To plot the line fitted to x ~ y on the same axis as the y ~ x plot
# we need to map the intercept and slope from y = a + bx to x = -a/b + y/b
# xy_line.coef=xy_line$coefficients
# abline(coef=c(-xy_line.coef[1]/xy_line.coef[2], 1/xy_line.coef[2]), col=pal_col[3])

# Or use predict
xy_pred=predict(xy_line)
lines(xy_pred, y, col=pal_col[3])

segments(x, y, fitted(xy_line), y, lty = 2, col =pal_col[3]) # horizontal line

