#
# pairs-ada-fortran.R, 10 Jun 16
#
# Data from:
# IMPACT OF ADA AND OBJECT-ORIENTED DESIGN IN THE FLIGHT DYNAMICS DIVISION AT GODDARD SPACE FLIGHT CENTER
# Sharon Waligora and John Bailey and Mike Stark
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")

pal_col=rainbow(2)


nasa=read.csv(paste0(ESEUR_dir, "projects/nasa-ada-fortran.csv.xz"), as.is=TRUE)

# FASTAGSS_partial design total is off by 1
nasa$all[5]=6114

# pairs( ~ design+coding+testing+other, data=nasa, subset=(language == "Ada"))

panel.language=function(x, y, language)
{
par(cex.axis=0.9)
Ada=(language == "Ada")
points(x[Ada], y[Ada], col=pal_col[2])
lines(loess.smooth(x[Ada], y[Ada], span=0.7), col=pal_col[2])

Fortran=(language != "Ada")
points(x[Fortran], y[Fortran], col=pal_col[1])
lines(loess.smooth(x[Fortran], y[Fortran], span=0.7), col=pal_col[1])
}

#pairs(log(nasa[ , 16:19]), panel = panel.language, language=nasa$language)

pairs(log(nasa[ , c("lines", "statements", "comments", "blanks", "NBNC_line", "decls", "executable")]),
	panel = panel.language, language=nasa$language)

