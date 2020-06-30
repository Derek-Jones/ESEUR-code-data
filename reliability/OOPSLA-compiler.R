#
# OOPSLA-compiler.R,  3 Jun 20
# Data from:
# Compiler Fuzzing: How Much Does It Matter?
# MICHAËL MARCOZZI, QIYI TANG, ALASTAIR F. DONALDSON, and CRISTIAN CADAR
# Analysis of data from Table 2 and 4
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_human experiment_software fuzzing fault-experiences LLVM

source("ESEUR_config.r")


rt=read.csv(paste0(ESEUR_dir, "reliability/code-rt.csv"), as.is=TRUE)

# Sample 10 entries without replacement, and compare their
# sum against the sum of the measured Human Triggers
#
# We are assuming that the detection of a particular coding mistake
# is exchangeable between Human and automatic tools.
# Faults are assumed not to be exchangeable, so we cannot sample
# with replacement.

compare_all=function(cases)
{
samp_ind=sample(3*10, size=10, replace=FALSE)
t=(Tsum_hum < sum(cases[samp_ind]))
return(t)
}


compare_two=function(cases)
{
samp_ind=sample(2*10, size=10, replace=FALSE)
t=(Tsum_hum < sum(cases[samp_ind]))
return(t)
}


human=subset(rt, Detector == "Human")
Tsum_hum=sum(human$Triggered)

Csmith=subset(rt, (Detector == "Human") | (Detector == "Csmith"))
EMI=subset(rt, (Detector == "Human") | (Detector == "EMI"))

# Compare human against both Csmith and EMI
Trig3_boot=replicate(14999, compare_all(rt$Triggered))

mean(Trig3_boot)
#sd(Trig3_boot)

# Compare Human against individual tools

TrigC_boot=replicate(14999, compare_two(Csmith$Triggered))

mean(TrigC_boot)
#sd(TrigC_boot)

TrigE_boot=replicate(14999, compare_two(EMI$Triggered))

mean(TrigE_boot)
#sd(TrigE_boot)



