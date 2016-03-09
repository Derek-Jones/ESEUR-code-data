#
# ETP-API-KM.R, 21 Feb 16
#
# Data from:
# Survival of Eclipse Third-party Plug-ins
# John Businge and Alexander Serebrenik and Mark van den Brand
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")

library("survival")

pal_col=rainbow(2)

all_API=read.csv(paste0(ESEUR_dir, "survival/ETP/ETP-all-rel.csv.xz"), as.is=TRUE)

api_surv=Surv(all_API$year_end-all_API$year_start,
		 event=all_API$survived == 0, type="right")
api_mod=survfit(api_surv ~ all_API$API)
plot(api_mod, col=pal_col, conf.int=TRUE,
	xlim=c(0,7), xlab="Years")


