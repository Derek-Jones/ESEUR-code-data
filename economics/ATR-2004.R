#
# ATR-2004.R,  2 Oct 20
#
# Data from:
# Software Cost and Productivity Model
# Jonathan E. Gayek and Lutrell G. Long and Kim D. Bell and Rosemary M. Hsu and Ronald K. Larson
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG effort_cost project_cost project_effort project_military


source("ESEUR_config.r")


library("quantreg")


pal_col=rainbow(4)


ATR=read.csv(paste0(ESEUR_dir, "economics/ATR-2004.csv.xz"), as.is=TRUE)

plot_effort_loc=function(df, col_num)
{
points(df$Labor.Effort, df$ESLOC/1e3, col=pal_col[col_num])
}


# plot(ATR$ESLOC, ATR$Develop.Schedule, xlim=c(0, 200000))
# plot(ATR$ESLOC, ATR$Estimated.ESLOC, log="xy")
# plot(ATR$Estimated.ESLOC, ATR$Develop.Schedule, xlim=c(0, 200000))

L_E=subset(ATR, !is.na(Labor.Effort))

x_range=range(L_E$Labor.Effort, na.rm=TRUE)
y_range=range(L_E$ESLOC, na.rm=TRUE)/1e3

plot(1, log="xy", type="n",
	xlim=x_range, ylim=y_range,
	xlab="Effort (months)", ylab="ESLOC (thousand)\n")
plot_effort_loc(subset(ATR, Environment == "Military Ground"), 1)
plot_effort_loc(subset(ATR, Environment == "Military Mobile"), 2)
plot_effort_loc(subset(ATR, Environment == "Mil-Spec Av"), 3)
plot_effort_loc(subset(ATR, Environment == "Unmanned Sp"), 4)

legend(x="bottomright", legend=c("Military Ground", "Military Mobile", "Mil-Spec Avionics", "Unmanned Space"),
		bty="n", fill=pal_col, cex=1.2)


mg=subset(ATR, Environment == "Military Ground")
mg10_mod=rq(log(ESLOC) ~ log(Labor.Effort), data=mg, tau=0.10)
# summary(mg10_mod)
mg90_mod=rq(log(ESLOC) ~ log(Labor.Effort), data=mg, tau=0.90)
# summary(mg90_mod)

x_vals=seq(20, 2000, 10)
pred10=predict(mg10_mod, newdata=data.frame(Labor.Effort=x_vals))
lines(x_vals, exp(pred10)/1e3, col=pal_col[1])
pred90=predict(mg90_mod, newdata=data.frame(Labor.Effort=x_vals))
lines(x_vals, exp(pred90)/1e3, col=pal_col[1])

# # Ratio of intercepts
# exp(coef(mg90_mod)[1])/exp(coef(mg10_mod)[1])

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

