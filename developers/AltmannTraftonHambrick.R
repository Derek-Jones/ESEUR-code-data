#
# AltmannTraftonHambrick.R, 19 Feb 19
# Data from:
# Effects of Interruption Length on Procedural Errors
# Erik M. Altmann and J. Gregory Trafton and David Z. Hambrick
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available dat
# Derek M. Jones
#
# TAG experiment human error time interruption


source("ESEUR_config.r")


plot_layout(1, 4, max_width=2.2, default_height=2.0)
par(mar=c(3, 0.5, 3, 0))

pal_col=rainbow(3)

subjerr=read.csv(paste0(ESEUR_dir, "developers/AltmannTraftonHambrick.csv.xz"), as.is=TRUE)
errbar=read.csv(paste0(ESEUR_dir, "developers/AltmannTraftonHambrick-err.csv.xz"), as.is=TRUE)


plot_inter=function(Inter_str, y_str="", yaxt_str="n")
{
df=subset(subjerr, Int_len == Inter_str)
post_err=subset(df, PB == "Post" & DM == "Data")
base_err=subset(df, PB == "Base" & DM == "Data")
post_mod=subset(df, PB == "Post" & DM == "Model")
base_mod=subset(df, PB == "Base" & DM == "Model")

plot(post_err$offset, post_err$errors, cex.axis=1.8, cex.lab=1.6, col=pal_col[1],
	yaxs="i", yaxt=yaxt_str,
	ylim=c(1e-3, 6.3), # Just above zero, so this value is not displayed
	xlab="\nOffset", ylab=y_str)
points(base_err$offset, base_err$errors, col=pal_col[2])

lines(post_mod$offset[1:3], post_mod$errors[1:3], col=pal_col[1], lwd=1.5)
lines(post_mod$offset[4:6], post_mod$errors[4:6], col=pal_col[1], lwd=1.5)
lines(base_mod$offset[1:3], base_mod$errors[1:3], col=pal_col[2], lwd=1.5)
lines(base_mod$offset[4:6], base_mod$errors[4:6], col=pal_col[2], lwd=1.5)

text(0, 6, Inter_str, cex=2.0)

df=subset(errbar, Int_len == Inter_str)
post_bar=subset(df, PB == "Post")
base_bar=subset(df, PB == "Base")

arrows(post_bar$offset, post_err$error,
		post_bar$offset, post_err$errors-post_bar$down, col=point_col,
		length=0.1, angle=90, lwd=1.3)
arrows(post_bar$offset, post_err$errors,
		post_bar$offset, post_err$errors+post_bar$up, col=point_col,
		length=0.1, angle=90, lwd=1.3)
arrows(base_bar$offset, base_err$errors,
		base_bar$offset, base_err$errors-base_bar$down, col=point_col,
		length=0.1, angle=90, lwd=1.3)
arrows(base_bar$offset, base_err$errors,
		base_bar$offset, base_err$errors+base_bar$up, col=point_col,
		length=0.1, angle=90, lwd=1.3)
}

# par(mar=c(3, 2.5, 3, 0))
plot_inter("Very short", "Errors (percent)")

# par(mar=c(3, 0.5, 3, 0))
plot_inter("Short")
plot_inter("Medium", yaxt_str="s")
plot_inter("Long")



