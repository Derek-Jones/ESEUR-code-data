#
# TR-96.csv, 18 Nov 19
#
# Data from:
# Software Reliability Growth Models
# Alan Wood
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG testing_fault-experience


source("ESEUR_config.r")

pal_col=rainbow(4)

#   Week R1.hrs R1.defects R2.hrs R2.defects R3.hrs R3.defects R4.hrs R4.defects
defects=read.csv(paste0(ESEUR_dir, "faults/TR-96.csv.xz"), as.is=TRUE)

plot_defects=function(test_time, total_defects, col_ind)
{
lines(test_time, total_defects, col=pal_col[col_ind])
}

plot(1, type="n",
	xaxs="i", yaxs="i",
	xlim=c(0, 12000), ylim=c(0, 120),
	xlab="Hours of testing", ylab="Faults experienced\n")

plot_defects(defects$R1.hrs, defects$R1.defects, 1)
plot_defects(defects$R2.hrs, defects$R2.defects, 2)
plot_defects(defects$R3.hrs, defects$R3.defects, 3)
plot_defects(defects$R4.hrs, defects$R4.defects, 4)

legend(x="topleft", legend=paste0("Release ", 1:4), bty="n", fill=pal_col, cex=1.2)


