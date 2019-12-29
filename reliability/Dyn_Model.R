#
# Dyn_Model.R, 23 Nov 19
# Data from:
# Dynamic model for the system testing process
# Gábor Stikkel
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG testing_effort fault_testing

source("ESEUR_config.r")


# plot_layout(3, 2)

pal_col=rainbow(3)


work_fault_cor=function(df)
{
ccf(df$STE_Manhour[-1], diff(df$Normalized_count),
	ylab="Cross-correlation\n")
}


dyn=read.csv(paste0(ESEUR_dir, "reliability/Dyn_Model.csv.xz"), as.is=TRUE)

P1=subset(dyn, Project == "P1")
P2=subset(dyn, Project == "P2")
P3=subset(dyn, Project == "P3")
P3$Normalized_count[10]=P3$Normalized_count[10]+0.001 # Stops a zero appearing

# work_fault_cor(P1)
# work_fault_cor(P2)
# work_fault_cor(P3)

plot(diff(P1$Normalized_count)/P1$STE_Manhour[-1], type="l", log="y", col=pal_col[1],
	xlim=c(1, 35), ylim=c(0.003, 0.4),
	xaxs="i",
	xlab="Week", ylab="Normalised faults per man-hour\n")
lines(diff(P2$Normalized_count)/P2$STE_Manhour[-1], col=pal_col[2])
lines(diff(P3$Normalized_count)/P3$STE_Manhour[-1], col=pal_col[3])

legend(x="bottomright", legend=paste0("Project P", 1:3), bty="n", fill=pal_col, cex=1.2)

# plot(diff(P1$Normalized_count), P1$STE_Manhour[-1])
# plot(diff(P2$Normalized_count), P2$STE_Manhour[-1])
# plot(diff(P3$Normalized_count), P3$STE_Manhour[-1])

