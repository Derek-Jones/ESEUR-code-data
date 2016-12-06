#
# p223-RHEL6.4_HS_E5-2690.R, 18 Jul 16
#
# Data from:
# Analysis of the Influences on Server Power Consumption and Energy Efficiency for {CPU}-Intensive Workloads
# J{\'o}akim v. Kistowski and Hansfried Block and John Beckett and Klaus-Dieter Lange and Jeremy A. Arnold and Samuel Kounev
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


p223=read.csv(paste0(ESEUR_dir, "experiment/p223-RHEL6.4_HS_E5-2690.csv.xz"), as.is=TRUE)

# pal_col=rainbow(length(unique(p223$Worklet)))
pal_col=rainbow(3)

# plot(p223$Load.Level, p223$Watts_1, type="l")

LU=subset(p223, Worklet == "LU")
SHA256=subset(p223, Worklet == "SHA256")
SOR=subset(p223, Worklet == "SOR")

plot(LU$Load.Level, LU$Watts_1, type="p",
	col=pal_col[1],
	xlim=c(60, 100),
	xlab="Load level", ylab="Watts\n")
points(SHA256$Load.Level, SHA256$Watts_1, col=pal_col[2])
points(SOR$Load.Level, SOR$Watts_1, col=pal_col[3])

every_5th=seq(1, 50, by=5)
lines(LU$Load.Level[every_5th], LU$Watts_1[every_5th], col=pal_col[1])
lines(SHA256$Load.Level[every_5th], SHA256$Watts_1[every_5th], col=pal_col[2])
lines(SOR$Load.Level[every_5th], SOR$Watts_1[every_5th], col=pal_col[3])

legend(x="bottomleft", legend=c("lu", "sha256", "sort"), bty="n", fill=pal_col, cex=1.2)

