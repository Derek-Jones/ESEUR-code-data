#
# MuellerHoefer2007.R, 24 Aug 18
#
# Data from:
# The Effect of Experience on the Test-Driven Development Process
# Matthias M. M{\"u}ller and Andreas H{\"o}fer
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment TDD testing experience coverage


source("ESEUR_config.r")


pal_col=rainbow(2)


tdd=read.csv(paste0(ESEUR_dir, "experiment/MuellerHoefer2007.csv.xz"), as.is=TRUE)

panel_user=function(x, y, user)
{
par(cex.axis=0.9)
expert=(user == "e")
points(x[expert], y[expert], col=pal_col[1])
#lines(loess.smooth(x[expert], y[expert], span=0.7), col=pal_col[1])

points(x[!expert], y[!expert], col=pal_col[2])
#lines(loess.smooth(x[!expert], y[!expert], span=0.7), col=pal_col[2])
}

panel_correlation=function(x, y, user)
{
usr=par("usr"); on.exit(par(usr))
par(usr = c(0, 1, 0, 1))
expert=(user == "e")
r_ex=cor(x[expert], y[expert])
r_nov=cor(x[!expert], y[!expert])

txt = paste0("e= ", round(r_ex, 2), "\n", "n= ", round(r_nov, 2))
text(0.1, 0.5, txt, pos=4, cex=1.6)
}

panel_boxplot = function(x, user)
{
usr = par("usr"); yaxt=par("yaxt")
on.exit(par(usr)); on.exit(par(yaxt), add=TRUE)
par(usr = c(0.5, 2.5, usr[3:4]) )
par(yaxt="n")
par(cex.axis=1.3)

t=data.frame(x, user)

boxplot(x ~ user, data=t, notch=TRUE, border=pal_col, add=TRUE)
par(yaxt="s") # the on.exit(yaxt) does not have the expected effect
}

pairs( ~ duration.min+changes+TDD+
	  log(development.cycle.length)+line.coverage+block.coverage,
        data=tdd, cex.labels=1.3,
	upper.panel=panel_user, lower.panel=panel_correlation,
	diag.panel=panel_boxplot, user=tdd$user)


