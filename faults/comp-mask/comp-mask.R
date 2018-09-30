#
# comp-mask.R, 14 Sep 18
#
# Data from:
# A Characterization of Instruction-level Error Derating and its Implications for Error Detection
# Jeffrey J. Cook and Craig Zilles
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG hardware-error compiler optimization


source("ESEUR_config.r")


# names,opt_level,pass.masked,inconclusive,fail.control,fail.store.value,fail.store.address,fail.mem.alignment,fail.other.error.model,fail.mem.protection,fail.other.compulsory
bitflip=read.csv(paste0(ESEUR_dir, "faults/comp-mask/resultmodes.csv.xz"), as.is=TRUE)


# pairs(res_m[, c(-1, -2)])

bitflip_mod=glm(pass.masked ~ opt_level, data=bitflip)
#bitflip_mod=glm(pass.masked ~ opt_level+names, data=bitflip)

print(summary(bitflip_mod))

# summary-breakdown.csv  summary-breakdown.pdf

# library("betareg")
# 
# bitflip$pm_perc=bitflip$pass.masked/100
# 
# tflip_beta=betareg(pm_perc ~ opt_level, data=bitflip)


