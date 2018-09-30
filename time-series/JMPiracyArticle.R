#
# JMPiracyArticle.R, 28 Sep 18
# Data from:
# Software Piracy: {Estimation} of Lost Sales and the Impact on Software Diffusion
# Moshe Givon and Vijay Mahajan and Eitan Muller
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG sales PC spreadsheet wordprocessor

source("ESEUR_config.r")


library("forecast")


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
plot(f_pred, col=point_col, main="",
	xaxs="i",
        xlab="Month", ylab="Monthly units sold\n")

