#
# eurosys84.R, 12 Oct 16
# Data from:
# Cycles, Cells and Platters: {An} Empirical Analysis of Hardware Failures on a Million Consumer PCs
# Edmund B. Nightingale and John R. Douceur and Vince Orgovan
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


PC_crash=read.csv(paste0(ESEUR_dir, "group-compare/eurosys84.csv.xz"), as.is=TRUE)

crash_mod=glm(failures ~ CPU*DRAM, data=PC_crash, family=poisson)

print(summary(crash_mod))

# predict(crash_mod, type="response")

