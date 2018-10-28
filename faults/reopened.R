#
# reopened.R, 22 Oct 18
#
# Data and (modified) code from:
# Predicting Re-opened Bugs: A Case Study on the Eclipse Project
# Emad Shihab and Akinori Ihara and Yasutaka Kamei and Walid M. Ibrahim and Masao Ohira and Bram Adams and Ahmed E. Hassan and Ken-ichi Matsumoto
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG fault eclipse reopened


source("ESEUR_config.r")


library("rpart")
library("rpart.plot")

# plot_wide()
plot_layout(1, 1, default_width=ESEUR_default_width*2.0, default_height=ESEUR_default_height*1.6)


mk_decision_tree= function(raw_data, data_weight)
{
# Does not include input from words in text columns given in paper
# bug_id,remod,time,week_day,month_day,month,severity,priority,time_days,num_fix_files,num_cc,description_size,num_comments,comments_size,pri_chng,fixer_exp,reporter_exp,prev_state,component,platform,reporter_name,fixer_name,description,comments
dt=rpart(remod ~ time+week_day+month_day+month+time_days+
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
	model=TRUE,
        parms=list(split="information"))

return(dt)
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
precision = ifelse(TP+FP == 0, 1, TP/(TP + FP))
recall = TP/(TP + FN)
accuracy = (TP + TN)/(TN + FN + FP + TP)
defects = (TP + FN)/(TN + FN + FP + TP)

print (c(precision, recall, accuracy, defects))
}


reopened_data=read.csv(paste0(ESEUR_dir, "faults/reopened_fault.data.xz"), as.is=TRUE)

# predict gets upset if the data is not in 'level' format
# reopened_data=read.csv(paste0(ESEUR_dir, "faults/reopened_fault.data.xz"), as.is=TRUE)

# Weight reopened faults by a factor of 5.2 to balance out the
# relative number of occurrences
data_weight=1+reopened_data$remod*4.2
weighted_model=mk_decision_tree(reopened_data, data_weight)
# summary(weighted_model)

# printcp(weighted_model)

# prp(weighted_model, cex=1.2, box.palette=c("green", "red"), type=4)

rpart.plot(weighted_model, cex=1.2, split.font=1,
		 under=TRUE, under.col=point_col, under.cex=1.0,
		 box.palette=c("green", "red"), branch.col="grey",
                 type=4, extra=100, branch=0.3, faclen=2)


# test_predictor(weighted_model, reopened_data)

# plot(weighted_model, uniform=TRUE, compress=TRUE, col=point_col,
# 		margin=0.1)
# text(weighted_model, use.n=TRUE, cex=1.3)

# Sample the faults so there is an equal number of reopened/non-reopened faults
# The following numbers seems to work reasonably well
# prob_weights=0.05+reopened_data$remod*0.45
# sample_data=reopened_data[sample(nrow(reopened_data),
#                           size=nrow(reopened_data)/4, prob=prob_weights), ]
# sample_model=mk_decision_tree(sample_data, NULL)

# test_predictor(sample_model, sample_data)
# test_predictor(weighted_model, sample_data)

