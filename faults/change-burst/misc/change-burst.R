#
# change-burst.R, 11 Jul 12
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

# Modified version from Appendix of "Change bursts as defect predictors"
# by Nachiappan Nagappan, Andreas Zellery, Thomas Zimmermann,
# Kim Herzig and Brendan Murphy

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

# Build a logistic regression model.
# Have removed items specified in the paper for which no data is provided.
burst.model = glm(HasDefect ~ NumberOfChanges
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
alias(burst.model)

# Remove multicolinear items
burst.model = glm(HasDefect ~ NumberOfChanges
			+ NumberOfConsecutiveChanges
			+ NumberOfChangesEarly
			+ NumberOfConsecutiveChangesEarly
			+ TotalBurstSizeEarly
			+ TimeFirstBurst + TimeLastBurst + TimeMaxBurst
			+ PeopleTotal + MaxPeopleInBurst
			+ log(ChurnTotal+1) + log(MaxChurnInBurst+1),
	   data=thedata, family="binomial")

# Remove items whose p-value exceeds 0.05
burst.model = glm(HasDefect ~
			+ NumberOfChangesEarly
			+ TimeFirstBurst
			+ MaxPeopleInBurst
			+ log(ChurnTotal+1) + log(MaxChurnInBurst+1),
	   data=thedata, family="binomial")

# Set a seed to make experiments deterministic.
set.seed(98052)

# The usual value is 100 (paper uses this), but that takes a while
N = 20

# Initialize result vectors with NA
precision = rep(NA, N)
recall = rep(NA, N)
accuracy = rep(NA, N)

# Run N random experiments
for (i in 1:N)
   {
# Split the data into training set (2/3) and testing set (1/3)
# based on random sample idxs
   idxs = sample(1:nrow(thedata), nrow(thedata)*2/3, F)
   train = thedata[ idxs, ]
   test = thedata[-idxs, ]

# Build a logistic regression model from the training data.
   burst.model = glm(HasDefect ~
			+ NumberOfConsecutiveChanges
			+ NumberOfConsecutiveChangesEarly
			+ TimeMaxBurst
			+ MaxPeopleInBurst
			+ log(ChurnTotal+1) + log(MaxChurnInBurst+1),
	   data=train, family="binomial")

# Apply the logistic regression model to the testing data
# ( cut off 0.50)
   test.prob = predict(burst.model, test, type="response")
   test.pred = test.prob>=0.50

# Count true negatives, false negatives,
# false positives and true positives.
   outcome = table(factor(test$HasDefect, levels=c(F,T)),
		   factor(test.pred, levels=c(F,T)))
   TN = outcome[1,1]
   FN = outcome[2,1]
   FP = outcome[1,2]
   TP = outcome[2,2]

# Compute precision, recall and accuracy for experiment i
   precision[i] = if (TP+FP == 0) { 1 } else { TP / (TP+FP) }
   recall[i] = TP / (TP+FN)
   accuracy[i] = (TP+TN) / (TN+FN+FP+TP)
   }

# Compute median precision, recall and accuracy of the N runs
median_precision = median(precision)
median_recall = median(recall)
median_accuracy = median(accuracy)

# Result values are not as good as those given in paper (which
# are not very good in themselves).
print(c(median_precision, median_recall, median_accuracy))

