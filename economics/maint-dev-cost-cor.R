#
# maint-dev-cost-cor.R,  3 Jun 14
# Data from:
# An Investigation of the Factors Affecting the Lifecycle Costs of COTS-Based Systems
# Laurence Michael Dunn
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


dme=read.csv(paste0(ESEUR_dir,"economics/dev-maint-effort.csv.xz"), as.is=TRUE)


t=cor.test(dme$dev.effort/dme$maint.effort, dme$dev.effort,
            method="spearman")

print(t$estimate)

