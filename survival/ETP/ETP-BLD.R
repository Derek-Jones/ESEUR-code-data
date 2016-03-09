#
# ETP-BLD.R, 21 Feb 16
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

bld_API=read.csv(paste0(ESEUR_dir, "survival/ETP/ETP-all-bld.csv.xz"), as.is=TRUE)

bld_surv=Surv(bld_API$year_end-bld_API$year_start,
		 event=bld_API$survived == 0, type="right")
bld_mod=survfit(bld_surv ~ bld_API$API)

plot(bld_mod, col=pal_col, conf.int=TRUE,
	xlim=c(0,7), xlab="Years")


