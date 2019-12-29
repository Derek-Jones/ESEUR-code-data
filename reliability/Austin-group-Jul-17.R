#
# Austin-group-Jul-17.R, 21 Nov 19
# Data from:
# austingroupbugs.net
# via Andrew Josey
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG POSIX_defect-report requirements_error

source("ESEUR_config.r")


pal_col=rainbow(4)


posix_dr=read.csv(paste0(ESEUR_dir, "reliability/Austin-group-Jul-17.csv.xz"), as.is=TRUE)
posix_dr$Date.Submitted=as.Date(posix_dr$Date.Submitted)
posix_dr$Updated=as.Date(posix_dr$Updated)

clarif=subset(posix_dr, Type == "Clarification Requested")
enhance=subset(posix_dr, Type == "Enhancement Request")
error=subset(posix_dr, Type == "Error")
omission=subset(posix_dr, Type == "Omission")


plot(sort(error$Date.Submitted), 1:nrow(error), type="l", col=pal_col[1],
	xaxs="i", yaxs="i",
	xlab="Date", ylab="Reported problems\n")
lines(sort(clarif$Date.Submitted), 1:nrow(clarif), col=pal_col[2])
lines(sort(enhance$Date.Submitted), 1:nrow(enhance), col=pal_col[3])
lines(sort(omission$Date.Submitted), 1:nrow(omission), col=pal_col[4])

legend(x="topleft", legend=c("Error", "Clarification Requested",
 	"Enhancement Request", "Omission"), bty="n", fill=pal_col, cex=1.2)

