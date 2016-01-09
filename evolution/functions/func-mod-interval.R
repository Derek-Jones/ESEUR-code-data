#
# func-mod-interval.R, 26 Dec 15
#
# Data from:
# Modification and developer metrics at the function level: Metrics for the study of the evolution of a software project
# Gregorio Robles and Israel Herraiz and Daniel M. Germ{\'a}n and Daniel Izquierdo-Cort{\'a}zar
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


funcs=read.csv(paste0(ESEUR_dir, "evolution/functions/ev_funcmod.tsv.xz"), as.is=TRUE, sep="\t")
# revid,date_time
# 1,2008-03-24 21:31:02
revdate=read.csv(paste0(ESEUR_dir, "evolution/functions/ev_rev_date.csv.xz"), as.is=TRUE)
#revdate=rbind(revdate, c(NA, NA))

revdate$date_time=as.POSIXct(revdate$date_time, format="%Y-%m-%d %H:%M:%S")

# Assign date-time for a given revid
funcs$revdate=revdate$date_time[funcs$revid]
funcs$prevdate=revdate$date_time[funcs$revprev]

time_between=funcs$revdate-funcs$prevdate

q=density(as.numeric(time_between)/(60*60), adjust=0.5, na.rm=TRUE)
plot(q, log="y",
	main="",
	xlab="Hours", ylab="Modification density\n",
	xlim=c(2, 20000), ylim=c(1e-8,1e-2))


