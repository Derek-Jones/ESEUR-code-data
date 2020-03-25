#
# a174454-reg.R, 15 Mar 20
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


fit_line=function(df, lty_val=1)
{
# t=loess.smooth(log(df$KLOC), df$dev.cost, span=0.4)
# lines(exp(t$x), t$y, col=loess_col)

f_mod=glm(log(Mdev.cost) ~ log(KLOC), data=df)
fg_pred=predict(f_mod, type="response")
lines(df$KLOC, exp(fg_pred), col=pal_col[1], lty=lty_val)

fp_mod=glm(Mdev.cost ~ log(KLOC), data=df, family=gaussian(link=log))
fp_pred=predict(fp_mod, type="response")
lines(df$KLOC, fp_pred, col=pal_col[3], lty=lty_val)

# fp_rmod=glm(dev.cost ~ log(LOC), data=df, family=poisson)
# fp_pred=predict(fp_rmod, type="response")
# lines(df$KLOC, fp_pred/1e6, col="pink", lty=lty_val)

return(f_mod)
}


AF_code=read.csv(paste0(ESEUR_dir, "ecosystems/a174454.csv.xz"), as.is=TRUE)

All=subset(AF_code, language == "All")
Fortran=subset(AF_code, language == "Fortran")
Cobol=subset(AF_code, language == "Cobol")
Other=subset(AF_code, language == "Other")
Assembler=subset(AF_code, language == "Assembler")


Fortran$KLOC=Fortran$LOC/1e3
Fortran$Mdev.cost=Fortran$dev.cost/1e6

F_clean=subset(Fortran, LOC < 1e8)

plot(F_clean$KLOC, F_clean$Mdev.cost, col=pal_col[2], log="xy",
	xlab="KLOC", ylab="Development cost ($million)\n")

f_mod=fit_line(F_clean)

points(F_clean$KLOC[1], F_clean$Mdev.cost[1], cex=2, pch="O", col="red")

F_clean=F_clean[-1, ]
f_mod=fit_line(F_clean, 3)

# c_mod=fit_line(Cobol)
# o_mod=fit_line(Other)
# fit_line(Assembler)

# Models involving year
# fp_rmod=glmrob(dev.cost ~ year*log(LOC), data=F_clean, family=poisson)
# fg_mod=glm(log(dev.cost) ~ year+log(LOC), data=F_clean)

# fp_rmod=glmrob(dev.cost ~ year*log(LOC), data=Cobol, family=poisson)
# fg_mod=glm(log(dev.cost) ~ log(LOC), data=Cobol)


