#
# a174454.R, 19 Jun 17
#
# Data from:
# A Study of Software Maintenance Costs of {Air Force} Large Scale Computer Systems
# Robert E. NeSmith II
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


# library("robustbase")

plot_layout(2, 1)

pal_col=rainbow(4)


fit_line=function(df, col_str)
{
# t=loess.smooth(log(df$LOC), df$dev.cost, span=0.4)
# lines(exp(t$x), t$y, col=loess_col)

points(df$LOC, df$dev.cost, col=col_str)

f_mod=glm(log(dev.cost) ~ log(LOC), data=df)
fg_pred=predict(f_mod, type="response")
lines(df$LOC, exp(fg_pred), col=col_str)

# fp_mod=glm(dev.cost ~ log(LOC), data=df, family=poisson)
# fp_pred=predict(fp_mod, type="response")
# lines(df$LOC, fp_pred, col="green")

# fp_rmod=glmrob(dev.cost ~ log(LOC), data=df, family=poisson)
# fp_pred=predict(fp_rmod, type="response")
# lines(df$LOC, fp_pred, col=col_str)

return(f_mod)
}


AF_code=read.csv(paste0(ESEUR_dir, "ecosystems/a174454.csv.xz"), as.is=TRUE)

All=subset(AF_code, language == "All")
Fortran=subset(AF_code, language == "Fortran")
Cobol=subset(AF_code, language == "Cobol")
Other=subset(AF_code, language == "Other")
Assembler=subset(AF_code, language == "Assembler")

plot(Cobol$year, Cobol$LOC/1e6, col=pal_col[1], log="y", type="l",
	ylim=range(All$LOC/1e6),
	xlab="Year", ylab="LOC (million)\n")

lines(Fortran$year, Fortran$LOC/1e6, col=pal_col[2])
lines(Other$year, Other$LOC/1e6, col=pal_col[3])
lines(Assembler$year, Assembler$LOC/1e6, col=pal_col[4])

legend(x="topleft", legend=c("Cobol", "Fortran", "Other", "Assembler"), bty="n", fill=pal_col, cex=1.2)

plot(Cobol$year, Cobol$dev.cost/1e6, col=pal_col[1], log="y", type="l",
	xlab="Year", ylab="Development cost (million dollars)\n")

lines(Fortran$year, Fortran$dev.cost/1e6, col=pal_col[2])
lines(Other$year, Other$dev.cost/1e6, col=pal_col[3])

legend(x="topleft", legend=c("Cobol", "Fortran", "Other"), bty="n", fill=pal_col, cex=1.2)

# plot(Fortran$LOC, Fortran$dev.cost, col=pal_col[1], log="xy",
# 	xlab="LOC", ylab="Development cost\n")
# 
# t=loess.smooth(log(Fortran$LOC), Fortran$dev.cost, span=0.4)
# lines(exp(t$x), t$y, col=loess_col)
# 
# points(Other$LOC, Other$dev.cost, col=pal_col[2])
# points(Cobol$LOC, Cobol$dev.cost, col=pal_col[3])
# points(Assembler$LOC, Assembler$dev.cost, col=pal_col[4])
# 
# legend(x="bottomright", legend=c("Fortran", "Other", "Cobol", "Assembler"), bty="n", fill=pal_col, cex=1.2)
# 
# 
# plot(Fortran$LOC, Fortran$dev.cost, col=pal_col[2], log="xy",
# 	xlab="LOC", ylab="Development cost\n")
# 
# F_clean=subset(Fortran, LOC < 1e8)
# # F_clean=F_clean[-1, ]
# 
# f_mod=fit_line(F_clean, pal_col[2])
# c_mod=fit_line(Cobol, pal_col[1])
# o_mod=fit_line(Other, pal_col[3])
# # fit_line(Assembler, pal_col[4])
# legend(x="topleft", legend=c("Cobol", "Fortran", "Other"), bty="n", fill=pal_col, cex=1.2)
# 
# # Models involving year
# # fp_rmod=glmrob(dev.cost ~ year*log(LOC), data=F_clean, family=poisson)
# # fg_mod=glm(log(dev.cost) ~ year+log(LOC), data=F_clean)
# 
# # fp_rmod=glmrob(dev.cost ~ year*log(LOC), data=Cobol, family=poisson)
# # fg_mod=glm(log(dev.cost) ~ log(LOC), data=Cobol)
# 
# legend(x="bottomright", legend=c("Fortran", "Cobol", "other"), bty="n", fill=pal_col, cex=1.2)
# 
# 
# plot(Fortran$LOC, Fortran$maint.cost, col=pal_col[1], log="xy",
# 	xlab="LOC", ylab="Development cost\n")
# 
# points(Other$LOC, Other$maint.cost, col=pal_col[2])
# points(Cobol$LOC, Cobol$maint.cost, col=pal_col[3])
# points(Assembler$LOC, Assembler$maint.cost, col=pal_col[4])
# 
# legend(x="bottomright", legend=c("Fortran", "Other", "Cobol", "Assembler"), bty="n", fill=pal_col, cex=1.2)
# 
# 
