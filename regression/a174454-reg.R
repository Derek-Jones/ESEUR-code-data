#
# a174454-reg.R, 19 Sep 18
#
# Data from:
# A Study of Software Maintenance Costs of {Air Force} Large Scale Computer Systems
# Robert E. NeSmith II
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Fortran Cobol assembler maintenance-cost


source("ESEUR_config.r")


# library("robustbase")

pal_col=rainbow(3)


fit_line=function(df)
{
# t=loess.smooth(log(df$LOC), df$dev.cost, span=0.4)
# lines(exp(t$x), t$y, col=loess_col)

f_mod=glm(log(dev.cost) ~ log(LOC), data=df)
fg_pred=predict(f_mod, type="response")
lines(df$LOC, exp(fg_pred), col=pal_col[1])

fp_mod=glm(dev.cost ~ log(LOC), data=df, family=gaussian(link=log))
fp_pred=predict(fp_mod, type="response")
lines(df$LOC, fp_pred, col=pal_col[2])

# fp_rmod=glmrob(dev.cost ~ log(LOC), data=df, family=poisson)
# fp_pred=predict(fp_rmod, type="response")
# lines(df$LOC, fp_pred, col=pal_col[3])

return(f_mod)
}


AF_code=read.csv(paste0(ESEUR_dir, "ecosystems/a174454.csv.xz"), as.is=TRUE)

All=subset(AF_code, language == "All")
Fortran=subset(AF_code, language == "Fortran")
Cobol=subset(AF_code, language == "Cobol")
Other=subset(AF_code, language == "Other")
Assembler=subset(AF_code, language == "Assembler")


F_clean=subset(Fortran, LOC < 1e8)

plot(F_clean$LOC, F_clean$dev.cost, col=pal_col[3], log="xy",
	xlab="LOC", ylab="Development cost\n")

f_mod=fit_line(F_clean)

F_clean=F_clean[-1, ]
f_mod=fit_line(F_clean)

# c_mod=fit_line(Cobol)
# o_mod=fit_line(Other)
# fit_line(Assembler)

# Models involving year
# fp_rmod=glmrob(dev.cost ~ year*log(LOC), data=F_clean, family=poisson)
# fg_mod=glm(log(dev.cost) ~ year+log(LOC), data=F_clean)

# fp_rmod=glmrob(dev.cost ~ year*log(LOC), data=Cobol, family=poisson)
# fg_mod=glm(log(dev.cost) ~ log(LOC), data=Cobol)


