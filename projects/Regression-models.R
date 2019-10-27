#
# Regression-models.R,  3 Oct 19
#
# Data from:
# Regression Models of Software Development Effort Estimation Accuracy and Bias
# Magne J{\o}rgensen
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG estimate_effort estimate_actual


source("ESEUR_config.r")


pal_col=rainbow(4)

est_info=read.csv(paste0(ESEUR_dir, "projects/Regression-models.csv.xz"), as.is=TRUE)

plot(est_info$Estimated.effort, est_info$Actual.effort, log="xy", col=point_col,
	xlim=c(5, max(est_info$Estimated.effort)),
	ylim=c(5, max(est_info$Actual.effort)),
	xlab="Estimated effort (hours)", ylab="Actual effort\n")

est_range=5:500
log_x=log(est_range)

lines(loess.smooth(est_info$Estimated.effort, est_info$Actual.effort, span=0.5, family="gaussian"),
	 col="yellow")

est_info$log_estimated=log(est_info$Estimated.effort)
est_mod=glm(Actual.effort ~ log_estimated, family=quasipoisson, data=est_info)

log_x=log(est_range)

pred=predict(est_mod, newdata=data.frame(log_estimated=log_x), type="link", se.fit=TRUE)

lines(est_range, exp(pred$fit), col=pal_col[1])
lines(est_range, exp(pred$fit+1.96*pred$se.fit), col=pal_col[2])
lines(est_range, exp(pred$fit-1.96*pred$se.fit), col=pal_col[2])


# The customer changed his opinion regarding design and functionality.
# The developer worked much faster than expected.
# Much more than expected of the previously developed software could be reused.
# The test of the program was combined with other tests. This reduced the effort spent on test preparation.
# The customer provided all necessary information.
# Easy task.
# Change of self-developed software.
# Before estimating the task, ‘‘test-development’’ of some of the functionality was conducted.
# Good knowledge and flexibility concerning how to implement the requirements.
# The estimate was the most likely effort + 25% additional effort.
# Much time spent on the analysis phase, risk budget added, and good knowledge of how to solve the task.
# Much experience with similar tasks.
# The accuracy was good in spite of change requests, because a risk budget was added.
# Knowledge of the task was very good. The same update is conducted three times a year.
# Task similar to other tasks recently completed.
# <no reason provided>
# <no reason provided>
# <no reason provided>
# Similar task completed, for the same customer, recently.
# <no reason provided>
# Very similar task for another customer recently completed.
# Everything went as planned.
# Easy task.
# Easy to understand the implications of the task.
# Flexible task. Used the estimated effort and then stopped.
# Long experience with this type of task.
# More testing and meeting with the customer than expected.
# Problems with software performance.
# Too low a fixed price, not reflecting the risks, was contracted with the customer.
# The installation took more time because an important feature had not been developed.
# No important problems, but many small changes in the requirement specification.
# Experience from estimating similar projects. More effort than expected on understanding a feature of the software development tool.
# Additional effort was added to the most likely effort because of high risk and vague specification.
# Estimate did not include requirement changes and training.
# Error in requirement specification assumptions (assumed that a feature that had to be developed was already part of the application).
# Poor quality of data and data models.
# Task larger than expected.
# Changes in requirement specification.
# More time to understand the existing system than expected.
# Lower quality than expected from other software applications.
# Problems with sub-contractor.
# Good relationship was important to this important customer. A too low estimate, not reflecting the risk of the task, was developed.
# More discussion than expected with the customer.
# Increase in functionality.
# Frequent change requests from the customer.
# Unexpected technical and data formatting problems.
# There were no new tasks available to start on when this was finished. Therefore, time was spent on improving the quality beyond the minimum and adding a few non-specified features.
# Problems with installation due to software license changes.
# Forgot to estimate effort on assisting the customer in acceptance testing.
# Problems with sub-contractor.
# Poor quality of input to estimation process. Lack of proper error correction and test processes.

