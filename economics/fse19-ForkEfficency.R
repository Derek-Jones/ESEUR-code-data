#
# fse19-ForkEfficency.R, 22 Jan 20
# Data from:
# What the Fork: {A} Study of Inefficient and Efficient Forking Practices in Social Coding
# Shurui Zhou and Bogdan Vasilescu and Christian K{\"a}stner
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG project_fork

source("ESEUR_config.r")


pr_data=read.csv(paste0(ESEUR_dir, "economics/fse19-ForkEfficency.csv.xz"), as.is=TRUE)

# The following is a modified version of code included in replication package

# Filter data based on outlier analysis:
pr_data.filtered = subset(pr_data, 
                           num_forks < 25000
                           & size < 1500000
                           & hotness_mean_external_correct <= 50
                           & ratio_PR_withTest_external <= 0.7
                           & CentralizedMngmtIndex <= 0.5
                           & AdditiveContributionIndex <= 0.6
                           # & median_submitPR_exprience <= 20
                           # & num_closed_PR_external >= 43 # median across our data
                           # & num_closed_PR_external <= 12000
                           & RatioDuplicatePRs <= 0.1
                           )

###  Hypothesis: more modularity and centralized management -> higher PR merge ratio

MR_subset=subset(pr_data.filtered,
			repoURL != "caskroom/homebrew-cask" # high-leverage point
			& repoURL != "laravel/framework"
			& repoURL != "nightscout/cgm-remote-monitor"
			& repoURL != "rails/rails"
			& repoURL != "cms-sw/cmssw"
			& repoURL != "Homebrew/homebrew-core"
			)

plot(~ PRMergeRatio 
             + NumForks
             + Size
             + ProjectAge
             + SubmitterPriorExperience
             + SubmitterSocialConnections
             + sqrt(PRHotness)
             + sqrt(RatioPRsWithTests)
             + CentralizedMngmtIndex
             + ModularityIndex
             + log(AdditiveContributionIndex)
             ,
	pch=".",
             data = MR_subset)

# This is the way to handle percentage of pass/fails, along
# with weighting the number of cases.
MR_subset$M_acc=round(MR_subset$NumPRs*MR_subset$PRMergeRatio)
MR_subset$M_rej=round(MR_subset$NumPRs*(1-MR_subset$PRMergeRatio))

model1 = glm(cbind(M_acc, M_rej) ~ 
               NumForks
             + Size
             + ProjectAge
             + SubmitterPriorExperience
             + SubmitterSocialConnections
             + sqrt(PRHotness) # improves quality of fit
             + sqrt(RatioPRsWithTests) # improves quality of fit
             + CentralizedMngmtIndex
             + ModularityIndex
             + AdditiveContributionIndex
             ,
             data = MR_subset,
             family = "binomial")

summary(model1)

# effect size
anova(model1)

# diagnostics
plot(model1)


