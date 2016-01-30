#
# ETP-API-log-rank.R, 17 Jan 16
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

all_API=read.csv(paste0(ESEUR_dir, "survival/ETP/ETP-all-rel.csv.xz"), as.is=TRUE)

api_diff=survdiff(Surv(year_end-year_start, event=(survived == 0),
					 type="right") ~ API, data=all_API)

print(api_diff)

