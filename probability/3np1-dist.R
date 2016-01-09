#
# 3np1-dist.R, 15 Jul 15
#
# Data from:
# The Effectiveness of Software Diversity
# Meine Jochum Peter {van der Meulen}
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library(fitdistrplus)


n3=read.csv(paste0(ESEUR_dir, "probability/3np1.csv.xz"), as.is=TRUE)


# descdist(n3$lines, discrete=TRUE, boot=1000)

# Remove outliers
li=n3$lines
li=li[li <= 120]

# dummy=descdist(li, discrete=TRUE, boot=500)
dummy=descdist(li, boot=500)

