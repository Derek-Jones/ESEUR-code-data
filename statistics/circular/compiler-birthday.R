#
# compiler-birthday.R, 14 Oct 18
# Data from:
#
# Derek M. Jones
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG survey compiler-writer birthday

source("ESEUR_config.r")


library("circular")
library("plyr")


pal_col=rainbow(3)


bday=read.csv(paste0(ESEUR_dir, "statistics/circular/compiler-birthday.csv.xz"), as.is=TRUE)
births=read.csv(paste0(ESEUR_dir, "statistics/circular/births.csv.xz"), as.is=TRUE)
bp_month=daply(births, .(month), function(df) return(sum(df$births)))
bp_month=bp_month/sum(bp_month)

# table(bday$compiler, bday$month)

months=c( "January", "February", "March",
		"April", "May", "June",
		"July", "August", "September",
		"October", "November", "December")

bday$mval=as.numeric(mapvalues(bday$month, months, 1:12))

compiler=subset(bday, compiler == "Yes")
non_comp=subset(bday, compiler == "No")

# Weight by number of days in month
# days_mon=c(31, 28.25, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)
# mon_cnt=table(compiler$mval)
# weight_mon=rep(1:12, times=round(mon_cnt*310/days_mon))
# cir_comp=circular(weight_mon, units = "hours", template = "clock12")

# Weight by yearly fraction of people born in a given month
# mon_cnt=table(compiler$mval)
# weight_births=rep(1:12, times=round(mon_cnt/bp_month))
# cir_comp=circular(weight_births, units = "hours", template = "clock12")

cir_ncomp=circular(non_comp$mval, units = "hours", template = "clock12")
cir_comp=circular(compiler$mval, units = "hours", template = "clock12")

# comm_Yg=YgVal(c(cir_ncomp, cir_comp),
#               c(length(cir_ncomp), length(cir_comp)))

# watson.williams.test(cir_ncomp, cir_comp)

rose.diag(cir_comp, bins=12, shrink=1.1, prop=3, axes=FALSE, col="red")
axis.circular(at=circular((1:12)-0.5, units="hours", template="clock12"),
				col="blue", labels=months)

arrows.circular(mean(cir_comp), y=rho.circular(cir_comp), col=pal_col[2], lwd=3)

# feb=circular(2, units = "hours", template = "clock12")
# rayleigh.test(cir_comp, feb)

# The distribution does not look unimodal.  So need to
# run tests that perform better for multi-modal distributions.
# kuiper.test(cir_comp)
# watson.test(cir_comp)


