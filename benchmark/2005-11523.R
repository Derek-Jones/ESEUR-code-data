#
# 2005-11523.R, 22 Jul 20
# Data from:
# A Comprehensive Study on Software Aging across {Android} Versions and Vendors
# Domenico Cotroneo and Antonio Ken Iannillo and Roberto Natella and Roberto Pietrantuono
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_software aging_memory aging_OS


source("ESEUR_config.r")


# Storage high/low
# Order order in which App runs
# Events events performed
ml=read.csv(paste0(ESEUR_dir, "benchmark/2005-11523.csv.xz"), as.is=TRUE)

ms=subset(ml, Process == "mediaserver")

ms_mod=glm(Memory ~ (Phone+Android+App+Events+Storage)*Order, data=ms)
summary(ms_mod)


