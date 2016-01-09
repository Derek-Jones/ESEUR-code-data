#
# ETP-API-KM.R, 22 Dec 15
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

# Analyse data from:
# Survival of Eclipse Third-party Plug-ins
# John Businge and Alexander Serebrenik and Mark van den Brand

source("ESEUR_config.r")

library("survival")

all_API=read.csv(paste0(ESEUR_dir, "survival/ETP/ETP-all-rel.csv.xz"), as.is=TRUE)

app_API=subset(all_API, API == 1)
app_nonAPI=subset(all_API, API == 0)

api_surv=Surv(app_API$year_end-app_API$year_start,
		 event=app_API$survived == 0, type="right")
api_mod=survfit(api_surv ~ 1)

nonapi_surv=Surv(app_nonAPI$year_end-app_nonAPI$year_start,
		 event=app_nonAPI$survived == 0, type="right")
nonapi_mod=survfit(nonapi_surv ~ 1)

plot(api_mod, xlim=c(0,7), xlab="Years")

lines(nonapi_mod, col="red")

