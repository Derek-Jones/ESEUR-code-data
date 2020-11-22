#
# err-code_mismatch.R, 21 Sep 20
# Data from:
# Expect the unexpected: {Error} code mismatches between documentation and the real world
# Cindy Rubio-Gonz{\'a}lez and Ben Libit
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Linux_filesystem error-code filesystem_error-code


source("ESEUR_config.r")


err_codes=read.csv(paste0(ESEUR_dir, "projects/err-code_mismatch.csv.xz"), as.is=TRUE)


