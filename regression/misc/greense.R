#
# greense.R, 18 Jan 16
#
# Data from:
#
# How Does Code Obfuscation Impact Energy Usage?
# Cagri Sahin, Philip Tornquist, Ryan McKenna, Zachary Pearson, and James Clause
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library(MASS)

eud=read.csv(paste0(ESEUR_dir, "regression/energy-usage-data.csv"), as.is=TRUE)

pal_colGrainbow(3)

eud_mod=glm(energy ~ (obfuscator+configuration)^2, data=eud,
			subset=(eud$scenario == "AnkiDroid-Tutorial_Deck"))
min_eud=stepAIC(eud_mod)

eud_mod=glm(energy ~ obfuscator+obfuscator:configuration, data=eud,
			subset=(eud$scenario == "AnkiDroid-Tutorial_Deck"))

eud_mod=glm(energy ~ obfuscator, data=eud,
			subset=(eud$scenario == "AnkiDroid-Tutorial_Deck"))

summary(eud_mod)

