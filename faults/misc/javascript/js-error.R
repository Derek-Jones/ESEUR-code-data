#
# js-error.R,  2 Jan 15
#
# Data from:
# JavaScript Errors in the Wild: An Empirical Study
# Frolin S. Ocariza, Jr., Karthik Pattabiraman Benjamin Zorn
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


trans=read.csv(paste0(ESEUR_dir, "faults/misc/javascript/web2_0-trans-fast.csv.xz"), as.is=TRUE)
trans$speed="fast"
t=read.csv(paste0(ESEUR_dir, "faults/misc/javascript/web2_0-trans-med.csv.xz"), as.is=TRUE)
t$speed="medium"
trans=rbind(trans, t)

t=read.csv(paste0(ESEUR_dir, "faults/misc/javascript/web2_0-trans-slow.csv.xz"), as.is=TRUE)
t$speed="slow"
trans=rbind(trans, t)

#  Permission.Denied Null.Exception Undefined.Symbol Syntax.Errors Miscellaneous
trans$err_total=trans$Permission.Denied+
                trans$Null.Exception+
                trans$Undefined.Symbol+
                trans$Syntax.Errors+
                trans$Miscellaneous

t=glm(err_total ~ speed, family=poisson, data=trans)

speed_info=function(speed_str)
{
speed_info=subset(trans, speed == speed_str)
hist(speed_info$err_total)
return(c(mean(speed_info$err_total),
         sd(speed_info$err_total)))
}


speed_info("fast")
speed_info("medium")
speed_info("slow")

