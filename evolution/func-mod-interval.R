#
# func-mod-interval.R, 28 Jun 20
#
# Data from:
# Modification and developer metrics at the function level: Metrics for the study of the evolution of a software project
# Gregorio Robles and Israel Herraiz and Daniel M. Germ{\'a}n and Daniel Izquierdo-Cort{\'a}zar
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG evolution_function function_modification-time


source("ESEUR_config.r")


pal_col=rainbow(2)


par(mar=MAR_default+c(0.0, 0.7, 0, 0))


func_mod_density=function(func_file, rev_file)
{
funcs=read.csv(paste0(ESEUR_dir, "evolution/", func_file), as.is=TRUE, sep="\t")
# revid,date_time
# 1,2008-03-24 21:31:02
revdate=read.csv(paste0(ESEUR_dir, "evolution/", rev_file), as.is=TRUE)
#revdate=rbind(revdate, c(NA, NA))

revdate$date_time=as.POSIXct(revdate$date_time, format="%Y-%m-%d %H:%M:%S")

# Assign date-time for a given revid
funcs$revdate=revdate$date_time[funcs$revid]
funcs$prevdate=revdate$date_time[funcs$revprev]

time_between=funcs$revdate-funcs$prevdate

q=density(log(as.numeric(time_between)/(60*60)), adjust=0.5, na.rm=TRUE)
return(q)
}


ev_den=func_mod_density("ev_funcmod.tsv.xz", "ev_rev_date.csv.xz")
ap_den=func_mod_density("ap_funcmod.tsv.xz", "ap_rev_date.csv.xz")

plot(ev_den$x, ev_den$y*1e6, log="y", type="l", col=pal_col[1],
	main="",
	xaxt="n",
	xaxs="i", yaxs="i",
	xlim=c(0, 11.5), ylim=c(1e-0,4e+5),
	xlab="Hours", ylab="Function modifications (density * 10^6)\n\n")

axis(1, at=0:11, label=round(exp(0:11)))

lines(ap_den$x, ap_den$y*1e6, col=pal_col[2])

legend(x="bottomleft", legend=c("Evolution", "Apache"), bty="n", fill=pal_col, cex=1.2)

