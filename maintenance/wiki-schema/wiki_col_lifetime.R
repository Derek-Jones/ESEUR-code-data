#
# wiki_col_lifetime.R, 16 May 14
#
# Data from:
# Schema evolution in wikipedia toward a Web Information System Benchmark
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("survival")


col_life=read.csv(paste0(ESEUR_dir, "maintenance/wiki-schema/tabcol_life.csv.xz"), as.is=TRUE)
# cur_release,days_difference,days_since_start
ver_days=read.csv(paste0(ESEUR_dir, "maintenance/wiki-schema/ver-date-diff.csv.xz"), as.is=TRUE)

ver_surv=Surv(col_life$last_v-col_life$first_v, event=col_life$last_v != 280)
ver_mod=survfit(ver_surv ~ 1)
plot(ver_mod, col=point_col,
	xlab="Versions since first release", ylab="Survival")

# day_surv=Surv(ver_days$days_since_start[col_life$last_v]-ver_days$days_since_start[col_life$first_v], event=col_life$last_v != 280)
# day_mod=survfit(day_surv ~ 1)
# plot(day_mod,
# 	xlab="Days since first release", ylab="Survival")

