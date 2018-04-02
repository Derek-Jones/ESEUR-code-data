#
# Ranking-Based.R, 30 Mar 18
# Data from:
# Ranking-Based Approaches for Localizing Faults
# Lucia Lucia
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(3)

faults=read.csv(paste0(ESEUR_dir, "reliability/Ranking-Based.csv.xz"), as.is=TRUE)

aj=subset(faults, Program == "AspectJ")
total_faults=290 # From thesis
aj$F_perc=100*aj$F_Faults/total_faults
aj$M_perc=100*aj$M_Faults/total_faults
aj$L_perc=100*aj$L_Faults/total_faults

plot(aj$Occurrences, aj$F_perc, log="y", col=pal_col[1],
	ylim=c(1, 75),
	xlab="Lines/Modules/Files", ylab="Faults (percent)\n")
points(aj$Occurrences, aj$M_perc, col=pal_col[2])
points(aj$Occurrences, aj$L_perc, col=pal_col[3])

legend(x="topright", legend=c("Files", "Modules", "Lines"), bty="n", fill=pal_col, cex=1.2)

F_mod=nls(F_perc ~ a*Occurrences^b, data=aj, trace=FALSE,
              start=list(a=100, b=-2.0))

F_pred=predict(F_mod, newdata=data.frame(x=1:10), type="response")
lines(1:10, F_pred, col=pal_col[1])

M_mod=nls(M_perc ~ a*Occurrences^b, data=aj, trace=FALSE,
              start=list(a=100, b=-2.0))

M_pred=predict(M_mod, newdata=data.frame(x=1:10), type="response")
lines(1:10, M_pred, col=pal_col[2])

L_mod=nls(L_perc ~ a*Occurrences^b, data=aj, trace=FALSE,
              start=list(a=100, b=-2.0))

L_pred=predict(L_mod, newdata=data.frame(x=1:10), type="response")
lines(1:10, L_pred, col=pal_col[3])

