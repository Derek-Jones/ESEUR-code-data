#
# koomeycomputertrendsreleaseversion-v36.R, 15 Apr 20
# Data from:
# Implications of Historical Trends in the Electrical Efficiency of Computing
# Jonathan G. Koomey and Stephen Berard and Marla Sanchez and Henry Wong
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG


source("ESEUR_config.r")


par(mar=MAR_default+c(0.0, 0.7, 0, 0))


pal_col=rainbow(3)

koomey=read.csv(paste0(ESEUR_dir, "introduction/koomeycomputertrendsreleaseversion-v36.csv.xz"), as.is=TRUE)

# MCPS - Millions of computations per second
# Convert watts to kilowatts

koomey$Watt_comp=koomey$Active.Power.watts/(1e6*koomey$MCPS)

plot(1, type="n", log="y",
	xlim=range(koomey$Year), ylim=range(koomey$Watt_comp),
	xlab="Year", ylab="Watts per computation\n\n")

tubes=subset(koomey, grepl("tubes", Notes.on.transistors.tubes))
points(tubes$Year, tubes$Watt_comp, col=pal_col[1])

transistors=subset(koomey, grepl("transistors", Notes.on.transistors.tubes))
points(transistors$Year, transistors$Watt_comp, col=pal_col[2])

micro=subset(koomey, is.na(How.many.))
points(micro$Year, micro$Watt_comp, col=pal_col[3])

legend(x="topright", legend=c("Vacuum tubes", "Transistors", "Microprocessor"), bty="n", fill=pal_col, cex=1.2)


a_mod=glm(log(Watt_comp) ~ Year, data=koomey)
# summary(a_mod)
d_bounds=seq(min(koomey$Year), max(koomey$Year))
pred=predict(a_mod, newdata=data.frame(Year=d_bounds))

lines(d_bounds, exp(pred), col="yellow")

