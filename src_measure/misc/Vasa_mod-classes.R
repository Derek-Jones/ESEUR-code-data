#
# Vasa_mod-classes.csv, 12 Jul 14
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


classes=read.csv(paste0(ESEUR_dir, "src_measure/Vasa_mod-classes.csv.xz"), as.is=TRUE)

pal_col=rainbow_hcl(3)

hibernate=subset(classes, name == "Hibernate")


