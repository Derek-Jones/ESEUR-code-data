#
# ETP-API-log-rank.R, 19 Jun 13
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


api_diff=survdiff(Surv(year_end-year_start, event=(survived == 0),
					 type="right") ~ API, data=all_API)
api_diff
