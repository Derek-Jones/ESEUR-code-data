#
# Centola-Becker.R,  5 May 19
# Data from:
# Experimental evidence for tipping points in social convention
# Damon Centola and Joshua Becker and Devon Brackbill and Andrea Baronchelli
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG social convention experiment human

source("ESEUR_config.r")


library("betareg")


cb=read.csv(paste0(ESEUR_dir, "economics/Centola-Becker.csv.xz"), as.is=TRUE)

cb$frac=cb$adoption_alternative/100
cb$adop_frac=cb$cm_count/cb$N

mt1=subset(cb, trial != 1)

# cb_mod=glm(frac ~ rounds_played+cm_count:rounds_played+N:rounds_played,
cb_mod=glm(frac ~ adop_frac:rounds_played+N:rounds_played,
			data=mt1, family=binomial)
summary(cb_mod)

# Shrink range to be within 0..1
mt1$frac=mt1$frac+1e-5
mt1$frac=mt1$frac/(max(mt1$frac)+1e-5)
cb_mod=betareg(frac ~ (rounds_played+adop_frac+N)^2,
                        data=mt1)
summary(cb_mod)


