#
# Exynos-7420.R, 22 Nov 18
# Data from:
# The {Samsung} {Exynos} 7420 Deep Dive - {Inside} A Modern 14nm {SoC}
# Andrei Frumusanu
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment cpu-power cpu-frequency cpu-voltage

source("ESEUR_config.r")


pal_col=rainbow(4)


plot_fit=function(c_power, col_str)
{
p_mod=glm(c_power ~ Frequency:I(Voltage^2)+Voltage-1, data=Exynos)
# print(summary(p_mod))
pred=predict(p_mod)

lines(freq, pred*1000, col=col_str)
}



Exynos=read.csv(paste0(ESEUR_dir, "experiment/Exynos-7420-A53.csv.xz"), as.is=TRUE)

# f_v2_1000=Frequency*Voltage^2/100
# Cx_Diff = Core_x/1000-Core_x[1]

plot(Exynos$Frequency, Exynos$C1_Diff*1000, col=pal_col[1],
	yaxs="i",
	ylim=c(0, 1050),
	xlab="Frequency (MHz)", ylab="Power consumed (mW)\n")
points(Exynos$Frequency, Exynos$C2_Diff*1000, col=pal_col[2])
points(Exynos$Frequency, Exynos$C3_Diff*1000, col=pal_col[3])
points(Exynos$Frequency, Exynos$C4_Diff*1000, col=pal_col[4])

legend(x="topleft", legend=c("1 core", paste0(2:4, " cores")), bty="n", fill=pal_col, cex=1.2)

freq=subset(Exynos, !is.na(Frequency))$Frequency

plot_fit(Exynos$C1_Diff, pal_col[1])
plot_fit(Exynos$C2_Diff, pal_col[2])
plot_fit(Exynos$C3_Diff, pal_col[3])
plot_fit(Exynos$C4_Diff, pal_col[4])



