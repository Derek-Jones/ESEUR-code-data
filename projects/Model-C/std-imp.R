#
# std-imp.R, 16 Jun 20
# Data from:
# Model Implementation C Compiler project
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG

source("ESEUR_config.r")


refs=read.csv(paste0(ESEUR_dir, "projects/Model-C/std-imp-doc.csv"), as.is=TRUE)

str(refs)

length(unique(refs$file))
# [1] 52
nrow(refs)/length(unique(refs$file))
# [1] 59.88462

std_refs=subset(refs, grepl("^STD", std_ref))

length(unique(std_refs$file))
# [1] 40
nrow(std_refs)/length(unique(std_refs$file))
# [1] 46.65


