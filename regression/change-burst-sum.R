#
# change-burst-sum.R, 17 Jan 14
#
# Data from:
# Change bursts as defect predictors
# Nachiappan Nagappan, Andreas Zellery, Thomas Zimmermann, Kim Herzig and Brendan Murphy
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

fp_threshold=0

# Read the data
#thedata = read.csv(paste0(ESEUR_dir, "faults/change-burst/Eclipse20_GAP2_BURST1_class_daily.csv.xz"), as.is=TRUE, sep=";")
# bugs is the name used in the daily data
# thedata$HasDefect = thedata$bugs > fp_threshold

thedata = read.csv(paste0(ESEUR_dir, "faults/change-burst/Eclipse20_GAP2_BURST1_class_weekly.csv.xz"), as.is=TRUE, sep=";")
# NumberOfFailures is the name used in the weekly data

thedata$HasDefect = thedata$NumberOfFailures > fp_threshold

# Build a logistic regression model.
# Have removed items specified in the paper for which no data is provided.
burst_mod= glm(HasDefect ~ NumberOfChanges
			+ NumberOfConsecutiveChanges
			+ TotalBurstSize
			+ NumberOfChangesEarly
			+ NumberOfConsecutiveChangesEarly
			+ TotalBurstSizeEarly
			+ NumberOfChangesLate
			+ NumberOfConsecutiveChangesLate
			+ TotalBurstSizeLate
			+ TimeFirstBurst + TimeLastBurst + TimeMaxBurst
			+ PeopleTotal + MaxPeopleInBurst + TotalPeopleInBurst
			+ log(ChurnTotal+1) + log(MaxChurnInBurst+1)
			+ log(TotalChurnInBurst +1),
	   data=thedata, family="binomial")

# Which items correlate with each other?
print(summary(burst_mod))


# library("sjPlot")
#
# sjp.glm(burst_mod)

