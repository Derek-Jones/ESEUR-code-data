#
# pub-fs-fp.R, 24 Aug 18
#
# Data from:
# Formal Specifications Better Than Function Points for Code Sizing
# Mark Staples and Rafal Kolanski and Gerwin Klein and Corey Lewis and June Andronick and Toby Murray and Ross Jeffery and Len Bass
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG formal-specification function-point C Haskell size


source("ESEUR_config.r")


work=read.csv(paste0(ESEUR_dir, "communicating/pub-fs-fp.csv.xz"), as.is=TRUE)

plot(work[, -1], col=point_col, cex.labels=1.3)

plot( ~ CFP+Haskell+Abstract+C, data=work[, -1], col=point_col, cex.labels=1.3)

