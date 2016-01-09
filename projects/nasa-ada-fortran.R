#
# nasa-ada-fortran.R,  5 Jan 16
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

# If this function was not passed to pairs, each plot would contain just crosses.
panel.language=function(x, y, language)
{
Ada=(language == "Ada")
points(x[Ada], y[Ada], col=pal_col[2])
lines(loess.smooth(x[Ada], y[Ada], span=0.7), col=pal_col[2])

Fortran=(language != "Ada")
points(x[Fortran], y[Fortran], col=pal_col[1])
lines(loess.smooth(x[Fortran], y[Fortran], span=0.7), col=pal_col[1])
}

# pairs( ~ duration+lines+design+coding+testing+other, data=nasa, subset=(language == "Ada"))
# rows 28 and 30 are zero
pairs(log(nasa[-c(28, 30) , 16:19]), panel = panel.language, language=nasa$language, cex.labels=1.3)



