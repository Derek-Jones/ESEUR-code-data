#
# reopened.R, 14 Jul 12
#
# Data and (modified) code from:
# Predicting Re-opened Bugs: A Case Study on the Eclipse Project
# Emad Shihab and Akinori Ihara and Yasutaka Kamei and Walid M. Ibrahim and
# Masao Ohira and Bram Adams and Ahmed E. Hassan and Ken-ichi Matsumoto
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library(rpart)

mk_decision_tree= function(raw_data, data_weight)
{
# Does not include input from words in text columns given in paper
# bug_id,remod,time,week_day,month_day,month,severity,priority,time_days,num_fix_files,num_cc,description_size,num_comments,comments_size,pri_chng,fixer_exp,reporter_exp,prev_state,component,platform,reporter_name,fixer_name,description,comments
rpart(remod ~ time+week_day+month_day+month+time_days+
              severity+priority+pri_chng+
              num_fix_files+num_cc+prev_state+
              description_size+
# Comment measurements might not have been after the first bug was closed.
# Paper says they were measured "before the first re-open" which could mean
# they were measured well after the first bug close.
# Emailed paper author who cannot recall the relative time when comment
# measurement occurred.
# I have not gone back to the original bugs reports to check.
#              num_comments+comments_size+
              fixer_exp+fixer_name+
              reporter_exp+reporter_name,
	data=raw_data,
        weight=data_weight,
        method="class",
        x=TRUE,
        parms=list(split="information"))
}

test_predictor = function(reopen_model, test_data)
{
# Test performance of model on test_data
reopen_predict = predict(reopen_model, newdata=test_data, type="prob")
# Take 0.5 as the dividing line for YES/NO
test_outcome = table(factor(test_data$remod > 0, levels=c(F, T)),
                     factor(reopen_predict[,2] >= 0.5, levels=c(F, T)))
TN = test_outcome[1, 1]
FN = test_outcome[2, 1]
FP = test_outcome[1, 2]
TP = test_outcome[2, 2]
precision = if (TP + FP ==0) { 1 } else { TP / (TP + FP) }
recall = TP / (TP + FN)
accuracy = (TP + TN) / (TN + FN + FP + TP)
defects = (TP + FN) / (TN + FN + FP + TP)

print (c(precision, recall, accuracy, defects))
}


reopened_data=read.csv(paste0(ESEUR_dir, "faults/reopened/reopened_fault.data"), as.is=TRUE)

# predict gets upset if the data is not in 'level' format
# reopened_data=read.csv(paste0(ESEUR_dir, "faults/reopened/reopened_fault.data"), as.is=TRUE)

# Weight reopened faults by a factor of 5.2 to balance out the
# relative number of occurrences
data_weight=1+reopened_data$remod*4.2
weighted_model=mk_decision_tree(reopened_data, data_weight)
# summary(weighted_model)

test_predictor(weighted_model, reopened_data)

# par(mfrow=c(1,1), xpd=NA)
# plot(weighted_model)
# text(weighted_model, use.n=TRUE, cex=0.6)

# Sample the faults so there is an equal number of reopened/non-reopened faults
# The following numbers seems to work reasonably well
prob_weights=0.05+reopened_data$remod*0.45
sample_data=reopened_data[sample(nrow(reopened_data),
                          size=nrow(reopened_data)/4, prob=prob_weights), ]
sample_model=mk_decision_tree(sample_data, NULL)

test_predictor(sample_model, sample_data)
test_predictor(weighted_model, sample_data)

