#
# ETP-API-log-rank.R, 28 Aug 20
#
# Data from:
# Co-evolution of the {Eclipse} Framework and its Third-party Plug-ins
# John Businge
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Eclipse_plugin plugin_survival API_survival


source("ESEUR_config.r")

library("survival")


all_API=read.csv(paste0(ESEUR_dir, "survival/ETP/ETP-all-rel.csv.xz"), as.is=TRUE)

api_diff=survdiff(Surv(year_end-year_start, event=(survived == 0),
					 type="right") ~ API, data=all_API)

print(api_diff)

