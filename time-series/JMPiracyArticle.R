#
# JMPiracyArticle.R, 21 Mar 20
# Data from:
# Software Piracy: {Estimation} of Lost Sales and the Impact on Software Diffusion
# Moshe Givon and Vijay Mahajan and Eitan Muller
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG PC_spreadsheet_sales wordprocessor_sales

source("ESEUR_config.r")


library("forecast")

par(mar=MAR_default+c(0.0, 2, 0, 0))


pal_col=rainbow(2)


sales=read.csv(paste0(ESEUR_dir, "economics/MPRA/Givon_et_al_Software_piracy_data.txt"), as.is=TRUE, sep="\t")

# diff_spread=diff(sales$Spreadsheets)
# acf(diff_spread)
# acf((diff_spread-mean(diff_spread)^2))

# plot(sales$PCs, type="l")
# plot(sales$PCs, sales$Spreadsheets)

# auto.arima(sales$Spreadsheets, max.order=7)
# 
# ar_mod=arima(sales$Spreadsheets, order=c(1, 0, 1))
# 
# t=predict(ar_mod, n.ahead=7)

# plot(sales$Spreadsheets, type="l", col=point_col,
#         xlim=c(0, nrow(sales)+7),
#         xlab="Month", ylab="Monthly sales\n")

# lines(t$pred, col=pal_col[1])
# lines(t$pred+t$se, col=pal_col[2])
# lines(t$pred-t$se, col=pal_col[2])


# auto.arima(sales$PCs, max.order=12)

Ar_mod=Arima(sales$Spreadsheets, order=c(1, 0, 1), include.drift=TRUE)

f_pred=forecast(Ar_mod, h=12)
plot(f_pred, col=pal_col[2], fcol=pal_col[1], main="",
	xaxs="i",
        xlab="Month", ylab="Units sold\n\n")

