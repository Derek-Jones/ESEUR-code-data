#
# bug_pattern.R, 22 Jun 14
#
# Data from:
# Using evolution patterns to find duplicated bugs
# Kai Pan
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("ascii")

b_pat=read.csv(paste0(ESEUR_dir, "faults/pattern/bug_pattern.csv.xz"), as.is=TRUE)

t=cor(b_pat[,3:9], method="kendall")
print(ascii(t, include.rownames=TRUE, include.colnames=TRUE))


