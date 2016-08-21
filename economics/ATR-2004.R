#
# ATR-2004.R, 22 Feb 16
#
# Data from:
# Software Cost and Productivity Model
# Jonathan E. Gayek and Lutrell G. Long and Kim D. Bell and Rosemary M. Hsu and Ronald K. Larson
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")

pal_col=rainbow(4)


ATR=read.csv(paste0(ESEUR_dir, "economics/ATR-2004.csv.xz"), as.is=TRUE)

plot_effort_loc=function(df, col_num)
{
points(df$Labor.Effort, df$ESLOC, col=pal_col[col_num])
}


# plot(ATR$ESLOC, ATR$Develop.Schedule, xlim=c(0, 200000))
# plot(ATR$ESLOC, ATR$Estimated.ESLOC, log="xy")
# plot(ATR$Estimated.ESLOC, ATR$Develop.Schedule, xlim=c(0, 200000))

L_E=subset(ATR, !is.na(Labor.Effort))

x_range=range(L_E$Labor.Effort, na.rm=TRUE)
y_range=range(L_E$ESLOC, na.rm=TRUE)

plot(1, log="xy", type="n",
	xlim=x_range, ylim=y_range,
	xlab="Effort (months)", ylab="ESLOC\n")
plot_effort_loc(subset(ATR, Environment == "Military Ground"), 1)
plot_effort_loc(subset(ATR, Environment == "Military Mobile"), 2)
plot_effort_loc(subset(ATR, Environment == "Mil-Spec Av"), 3)
plot_effort_loc(subset(ATR, Environment == "Unmanned Sp"), 4)

legend(x="bottomright", legend=c("Military Ground", "Military Mobile", "Mil-Spec Avionics", "Unmanned Space"),
		bty="n", fill=pal_col, cex=1.2)



# ATR_mod=glm(ESLOC ~
# #			Functional.Description +
# #			Lang +
# 			Environment +
# #			Domain +
# 			Labor.Effort +
# 			Develop.Schedule
# #			+Estimated.ESLOC
# 			,
# 		data=ATR)

