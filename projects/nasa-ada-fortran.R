#
# nasa-ada-fortran.R, 23 Aug 18
#
# Data from:
# IMPACT OF ADA AND OBJECT-ORIENTED DESIGN IN THE FLIGHT DYNAMICS DIVISION AT GODDARD SPACE FLIGHT CENTER
# Sharon Waligora and John Bailey and Mike Stark
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Ada Fortran design coding testing


source("ESEUR_config.r")


pal_col=rainbow(2)


nasa=read.csv(paste0(ESEUR_dir, "projects/nasa-ada-fortran.csv.xz"), as.is=TRUE)

# FASTAGSS_partial design total is off by 1
nasa$all[5]=6114

# If this function was not passed to pairs, each plot would contain just crosses.
panel.language=function(x, y, language)
{
   fit_language=function(lang_index, col_str)
   {
   points(x[lang_index], y[lang_index], col=pal_col[col_str])
   lines(loess.smooth(x[lang_index], y[lang_index], span=0.7), col=pal_col[col_str])
   }

fit_language(language == "Ada", 2)
fit_language(language != "Ada", 1)
}

# pairs( ~ duration+lines+design+coding+testing+other, data=nasa, subset=(language == "Ada"))
# rows 28 and 30 are zero
pairs(log(nasa[-c(28, 30) , 16:19]), panel = panel.language, language=nasa$language, cex.labels=1.4)



