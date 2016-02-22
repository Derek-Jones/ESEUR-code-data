#
# feat-done-day-7dig.R, 14 Feb 16
#
# Various analysis of http://www.7digital.com feature data
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")

source(paste0(ESEUR_dir, "projects/agile-work/feat-common-7dig.R"))

Done_day=as.integer(p$Done)-base_day

table(Done_day[(Done_day <= 650)] %% 7)
table(Done_day[(Done_day > 650)] %% 7)

