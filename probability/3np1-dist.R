#
# 3np1-dist.R, 22 Apr 20
#
# Data from:
# The Effectiveness of Software Diversity
# Meine Jochum Peter {van der Meulen}
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG implementation_multiple 3n+1


source("ESEUR_config.r")


library(fitdistrplus)


n3=read.csv(paste0(ESEUR_dir, "probability/3np1.csv.xz"), as.is=TRUE)


# descdist(n3$lines, discrete=TRUE, boot=1000)

# Remove outliers
li=subset(n3, lines <= 120)$lines

# dummy=descdist(li, discrete=TRUE, boot=500)
dummy=descdist(li, boot=500)

