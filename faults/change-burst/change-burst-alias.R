#
# change-burst-alias.R,  4 Apr 16
#
# Data from:
# Modified version from Appendix of "Change bursts as defect predictors"
# Nachiappan Nagappan and Andreas Zellery and Thomas Zimmermann and Kim Herzig and Brendan Murphy
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

# Classify items with at least one defect as defect􀀀prone
fp_threshold = 0

# Read the data
#thedata = read.csv(paste0(ESEUR_dir, "faults/change-burst/Eclipse20_GAP2_BURST1_class_daily.csv.xz"), as.is=TRUE, sep=";")
# bugs is the name used in the daily data
# thedata$HasDefect = thedata$bugs > fp_threshold

thedata = read.csv(paste0(ESEUR_dir, "faults/change-burst/Eclipse20_GAP2_BURST1_class_weekly.csv.xz"), as.is=TRUE, sep=";")
# NumberOfFailures is the name used in the weekly data
thedata$HasDefect = thedata$NumberOfFailures > fp_threshold

# Code used in paper
# thedata$HasDefect = thedata$NumberOfDefects > fp_threshold

# Paper did not test for colinearity or remove items having a high p-value.
p=hclust(as.dist(1-cor(thedata[, 2:27], use="all.obs", method="spe")^2))
plot(p) # y-axis labels need to be reversed...

# Build a logistic regression model.
# Including some pairwise interactions makes a hardly worth it difference.
# Have removed items specified in the paper for which no data is provided.
burst_model = glm(HasDefect ~ NumberOfChanges
			+ NumberOfConsecutiveChanges
#			+ TotalBurstSize
#			+ NumberOfChangesEarly
#			+ NumberOfConsecutiveChangesEarly
#			+ TotalBurstSizeEarly
#			+ NumberOfChangesLate
#			+ NumberOfConsecutiveChangesLate
#			+ TotalBurstSizeLate
			+ TimeFirstBurst
#			+ TimeLastBurst
			+ TimeMaxBurst
#			+ PeopleTotal
			+ MaxPeopleInBurst
#			+ TotalPeopleInBurst
			+ log(ChurnTotal+1) + log(MaxChurnInBurst+1)
#			+ log(TotalChurnInBurst)
			,
	   data=thedata, family="binomial")

summary(burst_model)

# Which items correlate with each other?
print(alias(burst_model, partial=TRUE))


# plot(thedata$NumberOfConsecutiveChanges, thedata$HasDefect)
# 
# sl_mod=glm(HasDefect ~ NumberOfConsecutiveChanges, data=thedata)
# summary(sl_mod)


