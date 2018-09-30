#
# SPEC-MHz-DDR_visreg2.R, 22 Sep 18
#
# Data from:
# www.spec.org/cpu2006/results
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG SPEC benchmark


source("ESEUR_config.r")


library("visreg")


cpu2006=read.csv(paste0(ESEUR_dir, "benchmark/cpu2006-results-20140206.csv.xz"), as.is=TRUE)

# Memory numbers may be suffixed by:
# E unbuffered ecc memory
# F fully buffered ecc memory
# P parity, i.e., ecc memory
# R registered, i.e., ecc memory
mem2006=read.csv(paste0(ESEUR_dir, "benchmark/cpu2006-memory.csv.xz"), as.is=TRUE)
mem2006$ecc=substr(mem2006$mem_rate, nchar(mem2006$mem_rate), 100)
mem2006$mem_rate=as.numeric(sub("(E|F|P|R|U)$", "", x=mem2006$mem_rate))
# 8600 and 16000 are not supported rates, assume a typo
mem2006$mem_rate[mem2006$mem_rate == 8600]=8500
mem2006$mem_rate[mem2006$mem_rate == 16000]=17000

cpu2006=cbind(cpu2006, mem2006)
cpu2006$Test.Date=as.Date(paste0("01-", cpu2006$Test.Date), format="%d-%B-%Y")
start_date=as.Date("01-Jan-2006", format="%d-%B-%Y")
cpu2006=subset(cpu2006, Test.Date >= start_date)

cint=subset(cpu2006, Benchmark == "CINT2006")
cint$Benchmark=NULL
cint=subset(cint, Result > 0)
cint=subset(cint, mem_rate >= 3200)
# The POWER6 mem_freq is the same as the Processor.MHz!
cint=subset(cint, mem_freq < 2500)


PC2=subset(cint, mem_kind == "PC2")
PC3=subset(cint, mem_kind != "PC2")

# Fits a great model
# spec_mod=glm(Baseline ~ Processor, data=cint)
# summary(spec_mod)

# Remove detailed processor information
cint$Processor=sub("[0-9][0-9][0-9][0-9](K|L|M|S|T| EE| HE| SE| v2|V2| v3)*$", "", x=cint$Processor)

# Strip back to top level information
cint$main_proc=sub("([^ ]+ [^ ]+) .*$", "\\1", x=cint$Processor)

# Now nowhere near as good a fit
# spec_mod=glm(Baseline ~ Processor, data=cint)
# summary(spec_mod)


spec_mod=glm(Result ~ Processor.MHz + I(Processor.MHz^2)+mem_rate + I(mem_rate^2) + mem_freq
# spec_mod=glm(Result ~ Processor.MHz + mem_rate + mem_freq
    			, data=cint)

# visreg with plot.type="image" requires a full sized page.
# It calls filled.contour, which has this restriction.
par(ESEUR_orig_par_values)

par(oma=c(2, 2, 1, 1))
par(mar=c(4, 5, 1, 2)+0.1)


t=visreg2d(spec_mod, "Processor.MHz", "mem_rate", plot.type="persp",
			 plot=FALSE)
plot(t, color=c("red", "green", "blue"),
      ylab="mem_rate\n", zlab="")

