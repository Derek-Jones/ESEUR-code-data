#
# bug-find.R,  2 Jun 14
#
# Data from:
# A Human Study of Fault Localization Accuracy
# http:???
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("plyr")


plot_layout(1, 2)

subj_resp=read.csv(paste0(ESEUR_dir, "developers/misc/bug-find.csv.xz"),
                   as.is=TRUE, na.strings=c(""))

# Mapping of file numbers to line containing fault, 0 is no fault
line_map=read.csv(paste0(ESEUR_dir, "developers/misc/num_file_line.csv.xz"),
                   as.is=TRUE)

# Remove responses where no TRUE/FALSE given
subj_resp=subset(subj_resp, !is.na(is_bug))

# Removes TRUE responses that did not include a fault line number
subj_resp$line_of_bug=as.numeric(subj_resp$line_of_bug)
subj_resp=subset(subj_resp, !((is_bug == TRUE) & is.na(line_of_bug)))


# Remove subjects who answered less than 5 questions
username=unique(subj_resp$username)
num_answers=daply(subj_resp, .(username), function(df) nrow(df))
hist(num_answers, breaks=15,
     xlab="Number of answers", ylab="Number of subjects")
username=username[num_answers >= 5]
num_answers=num_answers[num_answers >= 5]

# Separate into TRUE and FALSE to simplify
true_resp=subset(subj_resp, is_bug == TRUE)
true_resp=subset(true_resp, !is.na(line_of_bug))
false_resp=subset(subj_resp, is_bug == FALSE)

# Which answers were correct?
correct_t_resp=subset(true_resp, line_of_bug == line_map[true_resp$code_file_number,]$line_num)
correct_f_resp=subset(false_resp, 0 == line_map[false_resp$code_file_number,]$line_num)

# Ought to include off by one responses in count...

# Remove subjects who did not get at least 10% of is_bug == TRUE responses correct
# is_bug == FALSE requires very little effort to make,
# so didn't exclude on this basis.
num_t_correct=daply(correct_t_resp, .(username), function(df) nrow(df))
hist((num_t_correct+0.0)/num_answers, breaks=15,
     xlab="Percentage TRUE correct", ylab="Number of subjects")
username=username[(num_t_correct+0.0)/num_answers > 0.1]

#num_t_correct=num_t_correct+sapply(username, function(x){length(which(correct_f_resp$username == x))})

# List of what are considered to be 'good' subjects
good_index=daply(subj_resp, .(username), function(df) nrow(df))
good_resp=subset(subj_resp, good_index == 1)

# Separate into TRUE and FALSE to simplify
true_resp=subset(good_resp, is_bug)
false_resp=subset(good_resp, !is_bug)

# Which answers were correct?
correct_t_resp=true_resp[true_resp$line_of_bug == line_map[true_resp$code_file_number,]$line_num,]
correct_f_resp=false_resp[0                    == line_map[false_resp$code_file_number,]$line_num,]

paste("Response true ", length(true_resp$is_bug),
      ", actual true ", length(correct_t_resp$is_bug),
      ", actual false ", length(true_resp[0== line_map[false_resp$code_file_number,]$line_num,]$is_bug))
paste("Response false ", length(false_resp$is_bug),
      ", actual false ", length(correct_f_resp$is_bug))

print("Contingency matrix")
print("      Response correct  Response incorrect Total")
paste("true  ", length(correct_t_resp$is_bug), ", ",
               length(true_resp$is_bug)-length(correct_t_resp$is_bug), ", ",
               length(true_resp$is_bug))
paste("false ", length(correct_f_resp$is_bug), ", ",
               length(false_resp$is_bug)-length(correct_f_resp$is_bug), ", ",
               length(false_resp$is_bug))
paste("Total  ", length(correct_t_resp$is_bug)+length(correct_f_resp$is_bug), ", ",
               length(true_resp$is_bug)-length(correct_t_resp$is_bug)+
               length(false_resp$is_bug)-length(correct_f_resp$is_bug), ", ",
               length(true_resp$is_bug)+length(false_resp$is_bug))

# Calculate off by one responses
plus_1=true_resp[true_resp$line_of_bug+1 == line_map[true_resp$code_file_number,]$line_num,]
minus_1=true_resp[true_resp$line_of_bug-1 == line_map[true_resp$code_file_number,]$line_num,]

paste("Off by +1 correct ", length(plus_1$is_bug),
      ", off by -1 correct ", length(minus_1$is_bug))

# Compare histogram of off by one responses
plot_layout(1, 1)
hist(plus_1$code_file_number, breaks=20, xlim=c(0, 50), ylim=c(0, 80), col="red")
par(new=TRUE)
hist(correct_t_resp$code_file_number, breaks=20, xlim=c(0, 50), ylim=c(0, 80))
par(new=TRUE)
hist(minus_1$code_file_number, breaks=20, xlim=c(0, 50), ylim=c(0, 80), col="green")


# Remove any out of bounds responses
good_resp$answer_confidence=as.numeric(good_resp$answer_confidence)
good_resp$perceived_difficulty=as.numeric(good_resp$perceived_difficulty)
good_bound=good_resp[(good_resp$answer_confidence <= 5) &
                     (good_resp$perceived_difficulty <= 5), ]

true_bound=good_bound[good_bound$is_bug == TRUE, ]
false_bound=good_bound[good_bound$is_bug == FALSE, ]

cor.test(true_bound$answer_confidence, true_bound$perceived_difficulty, method="kendal")
cor.test(false_bound$answer_confidence, false_bound$perceived_difficulty, method="kendal")

correct_t_bound=true_bound[true_bound$line_of_bug == line_map[true_bound$code_file_number,]$line_num,]
cor.test(correct_t_bound$answer_confidence, correct_t_bound$perceived_difficulty, method="kendal")

correct_f_bound=false_bound[0                    == line_map[false_bound$code_file_number,]$line_num,]
cor.test(correct_f_bound$answer_confidence, correct_f_bound$perceived_difficulty, method="kendal")

# Compare subject performance
plot_layout(1, 1)
num_t_answers=sapply(username, function(x){length(which(true_bound$username == x))})
num_all_answers=num_t_answers

# Plot percentage of TRUE correct for each subject
num_t_correct=sapply(username, function(x){length(which(correct_t_bound$username == x))})
num_all_correct=num_t_correct

x=1:length(username)
y=sort(num_t_correct/num_t_answers)
plot(x, y, col="blue",
     ylim=c(0,1), xlim=c(0, length(username)),
     ylab="Subjects", xlab="Percentage correct")
true_fit=lm(y ~ x)
abline(reg=true_fit)
text(x=60, y=0.2, pos=4,
     paste("True correct  ", round(mean(y), digits=3), round(sd(y), digits=3)))
text(x=60, y=0.24, pos=4,
     paste("                       mean    sd"))

# Plot percentage of FALSE correct for each subject
num_f_answers=sapply(username, function(x){length(which(false_bound$username == x))})
num_all_answers=num_all_answers+num_f_answers
num_f_correct=sapply(username, function(x){length(which(correct_f_bound$username == x))})
num_all_correct=num_all_correct+num_f_correct
num_f_correct=num_f_correct[num_f_answers != 0]
num_f_answers=num_f_answers[num_f_answers != 0]

par(new=TRUE)
x=1:length(num_f_correct)
y=sort(num_f_correct/num_f_answers)
plot(x, y, col="red",
     ylim=c(0,1), xlim=c(0, length(username)))
false_fit=lm(y ~ x)
abline(reg=false_fit, col="red")
text(x=60, y=0.15, pos=4,
     paste("False correct ", round(mean(y), digits=3), round(sd(y), digits=3)))

# Plot percentage of both correct for each subject
par(new=TRUE)
x=1:length(username)
y=sort(num_all_correct/num_all_answers)
plot(x, y,
     ylim=c(0,1), xlim=c(0, length(username)))
all_fit=lm(y ~ x)
abline(reg=all_fit)
text(x=60, y=0.1, pos=4,
     paste("Both correct   ", round(mean(y), digits=3), round(sd(y), digits=3)))


