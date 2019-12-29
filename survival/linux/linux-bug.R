#
# linux-bug.R, 25 Dec 19
#
# Data from:
# Faults in Linux: Ten Years Later
# Nicolas Palix and Suman Saha and Ga\"{e}l Thomas and Christophe Calv\'{e}s and Julia Lawall and Gilles Muller
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Linux_faults device-drivers_faults fault_survival

source("ESEUR_config.r")


library("survival")

pal_col=rainbow(2)

bug_life=read.csv(paste0(ESEUR_dir, "survival/linux/bug-survive.csv.xz"), as.is=TRUE)

# Get all Linux release dates
linux_days=read.csv(paste0(ESEUR_dir, "regression/Linux-days.csv.xz"), as.is=TRUE)
linux_days$Release_date=as.Date(linux_days$Release_date, format="%d-%b-%Y")
# Remove non 2.6 versions
t=subset(linux_days, grepl("^2\\.6\\.", linux_days$Version))
# Remove minor releases
linux_2_6=subset(t, !grepl("^2\\.6\\.[[:digit:]]+\\.[[:digit:]]+", t$Version))

first_day=min(linux_2_6$Release_date)

# Columns with version number mapped to day since 'first_day'
bug_life$start_day=as.numeric(linux_2_6$Release_date[bug_life$start+1]-first_day)
bug_life$end_day=as.numeric(linux_2_6$Release_date[bug_life$end+1]-first_day)

drivers=subset(bug_life, top_dir == "drivers")
others=subset(bug_life, top_dir != "drivers")

# By version

# d_mod=survfit(Surv(drivers$end-drivers$start+1, drivers$end == 33) ~ 1)
# plot(d_mod, col=pal_col[1],
# 	yaxs="i",
# 	xlab="Version", ylab="Fault survival rate\n")
# 
# o_mod=survfit(Surv(others$end-others$start+1, others$end == 33) ~ 1)
# lines(o_mod, col=pal_col[2])
# 
# legend(x="topright", legend=c("drivers", "others"),
# 		text.col=pal_col, bty="n", cex=1.3)

# By days

d_mod=survfit(Surv(drivers$end_day-drivers$start_day+1, drivers$end == 33) ~ 1)
plot(d_mod, col=pal_col[1],
	yaxs="i",
	xlab="Number of days", ylab="Survival\n")
# 
o_mod=survfit(Surv(others$end_day-others$start_day+1, others$end == 33) ~ 1)
lines(o_mod, col=pal_col[2])

legend(x="topright", legend=c("drivers", "others"),
		text.col=pal_col, bty="n", cex=1.3)


