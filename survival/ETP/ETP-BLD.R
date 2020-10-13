#
# ETP-BLD.R, 22 Mar 20
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


pal_col=rainbow(2)

bld_API=read.csv(paste0(ESEUR_dir, "survival/ETP/ETP-all-bld.csv.xz"), as.is=TRUE)

bld_surv=Surv(bld_API$year_end-bld_API$year_start,
		 event=bld_API$survived == 0, type="right")
bld_mod=survfit(bld_surv ~ bld_API$API)

plot(bld_mod, col=pal_col, conf.int=TRUE,
	xaxs="i", yaxs="i",
	xlim=c(0,7),
	xlab="Years", ylab="Survival\n")


