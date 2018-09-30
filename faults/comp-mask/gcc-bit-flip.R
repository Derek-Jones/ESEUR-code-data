#
# gcc-bit-flip.R, 11 Jul 15
#
# Data from:
# A Characterization of Instruction-level Error Derating and its Implications for Error Detection
# Jeffrey J. Cook and Craig Zilles
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones

source("ESEUR_config.r")


library("coin")


# names,opt_level,pass.masked,inconclusive,fail.control,fail.store.value,fail.store.address,fail.mem.alignment,fail.other.error.model,fail.mem.protection,fail.other.compulsory
res_m=read.csv(paste0(ESEUR_dir, "faults/comp-mask/resultmodes.csv.xz"), as.is=TRUE)


