#
# brl.R,  9 May 16
# Data from:
# Martin H. Weik 
# A SURVEY OF DOMESTIC ELECTRONIC DIGITAL COMPUTING SYSTEMS
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


arith=read.csv(paste0(ESEUR_dir, "benchmark/brl/arith-time.csv"), as.is=TRUE)

cost=read.csv(paste0(ESEUR_dir, "benchmark/brl/cost.csv"), as.is=TRUE)
power=read.csv(paste0(ESEUR_dir, "benchmark/brl/power.csv"), as.is=TRUE)
word_len=read.csv(paste0(ESEUR_dir, "benchmark/brl/word-len.csv"), as.is=TRUE)
cust_accept=read.csv(paste0(ESEUR_dir, "benchmark/brl/cust-accept.csv"), as.is=TRUE)
crystal_diode=read.csv(paste0(ESEUR_dir, "benchmark/brl/crystal-diode.csv"), as.is=TRUE)
drum_storage=read.csv(paste0(ESEUR_dir, "benchmark/brl/drum-storage.csv"), as.is=TRUE)
vac_tubes=read.csv(paste0(ESEUR_dir, "benchmark/brl/vac-tubes.csv"), as.is=TRUE)

all=merge(arith, cost, all=TRUE)
all=merge(all, power, all=TRUE)
all=merge(all, word_len, all=TRUE)
all=merge(all, cust_accept, all=TRUE)
all=merge(all, crystal_diode, all=TRUE)
all=merge(all, drum_storage, all=TRUE)
all=merge(all, vac_tubes, all=TRUE)


plot( ~ ADD.MICROSEC+ MULTIPLY.MICROSEC+ DIVIDE.MICROSEC+
		DOLLARS+ KW+ WORD.LENGTH+
		CRYSTAL.DIODES+VAC.TUBES+
		DRUM.CAPACITY, data=all, log="xy")

