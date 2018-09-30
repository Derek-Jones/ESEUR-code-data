#
# SPEC-Mhz.R,  3 Jul 16
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


library("plyr")


plot_layout(3, 1)

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

# hist(cint$Test.Date, breaks=10)

# plot(cint$Test.Date, cint$Result,
# 	xlab="Measurement date", ylab="SPEC2006 int")
plot(cint$Processor.MHz, cint$Result, col=point_col,
	xlab="Processor speed MHz", ylab="SPEC2006 int")

PC2=subset(cint, mem_kind == "PC2")
PC3=subset(cint, mem_kind != "PC2")

# xbounds=range(cint$mem_rate)
# ybounds=range(cint$Result)
# 
# pal_col=rainbow(2)
# 
# plot(PC2$Processor.MHz, PC2$Result, col=pal_col[1],
# 	ylim=ybounds,
# 	xlab="Processor speed MHz", ylab="SPEC2006 int")
# points(PC3$Processor.MHz, PC3$Result, col=pal_col[2])
# 
# plot(PC2$mem_rate, PC2$Result, col=pal_col[1],
# 	xlim=c(0, 15000), ylim=ybounds,
# 	xlab="Memory rate", ylab="SPEC2006 int")
# points(PC3$mem_rate, PC3$Result, col=pal_col[2])


rates=unique(cint$mem_rate)
pal_col=rainbow(length(rates))
rate_map=mapvalues(cint$mem_rate, rates, 1:length(rates))
plot(cint$Processor.MHz, cint$Result, col=pal_col[rate_map],
	xlab="Processor speed MHz", ylab="SPEC2006 int")

cpu_freq=unique(cint$Processor.MHz)
pal_col=rainbow(length(cpu_freq))
cpu_freq_map=mapvalues(cint$Processor.MHz, cpu_freq, 1:length(cpu_freq))
plot(cint$mem_rate, cint$Result, col=pal_col[cpu_freq_map],
	xlab="Memory peak transfer rate (MB/sec)", ylab="SPEC2006 int")

# freqs=unique(cint$mem_freq)
# pal_col=rainbow(length(freqs))
# freq_map=mapvalues(cint$mem_freq, freqs, 1:length(freqs))
# plot(cint$Processor.MHz, cint$Result, col=pal_col[freq_map],
# 	xlab="Processor speed MHz", ylab="SPEC2006 int")


# Remove detailed processor information
# cint$Processor=sub("[0-9][0-9][0-9][0-9](K|L|M|S|T| EE| HE| SE| v2|V2| v3)*$", "", x=cint$Processor)

# cint$main_proc=sub("([^ ]+ [^ ]+) .+$", "\\1", x=cint$Processor)
# freqs=unique(cint$main_proc)
# pal_col=rainbow(length(freqs))
# freq_map=as.numeric(mapvalues(cint$main_proc, freqs, 1:length(freqs)))
# plot(cint$Processor.MHz, cint$Result, col=pal_col[freq_map],
#         xlab="Processor speed MHz", ylab="SPEC2006 int")

