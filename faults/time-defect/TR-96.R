#
# TR-96.csv, 22 Dec 15
#
# Data from:
# Software Reliability Growth Models
# Alan Wood
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")

brew_col=rainbow(4)

#   Week R1.hrs R1.defects R2.hrs R2.defects R3.hrs R3.defects R4.hrs R4.defects
defects=read.csv(paste0(ESEUR_dir, "faults/time-defect/TR-96.csv.xz"), as.is=TRUE)

plot_defects=function(test_time, total_defects, col_ind)
{
lines(test_time, total_defects, col=brew_col[col_ind])
}

plot(1, type="n",
	xlim=c(0, 12000), ylim=c(0, 120),
	xlab="Hours of testing", ylab="Total defects\n")

plot_defects(defects$R1.hrs, defects$R1.defects, 1)
plot_defects(defects$R2.hrs, defects$R2.defects, 2)
plot_defects(defects$R3.hrs, defects$R3.defects, 3)
plot_defects(defects$R4.hrs, defects$R4.defects, 4)



