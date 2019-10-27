#
# ASE2017.R, 11 Oct 19
# Data from:
# The Impact of Continuous Integration on Other Software Development Practices: {A} Large-Scale Empirical Study
# Yangyang Zhao and Alexander Serebrenik and Yuming Zhou and Vladimir Filkov and Bogdan Vasilescu
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Travis continuous-integration project_evolution project_commits

source("ESEUR_config.r")


library(lme4)


ASE=read.csv(paste0(ESEUR_dir, "projects/ASE2017.csv.xz"), as.is=TRUE)

# The following code is derived from the R script kindly
# provided by Alexander Serebrenik.

ASE$time = ASE$period + 12
ASE$intervention = ASE$time > 12
ASE$time_after_intervention = ifelse(ASE$time>12, ASE$time-12, 0)

# To keep the compressed book data below 1G, the data shipped 
# is the output of the following subsets.
# 
# t=subset(ASE, (num_non_merge_commits == 0) & (period != 0))
# pof_non_merge=unique(t$Repo)
# 
# t=subset(ASE, (num_merge_commits == 0) & (period != 0))
# pof_merge=unique(t$Repo)
# 
# data.commits = subset(ASE, !(Repo %in% pof_non_merge) &
# 				!(Repo %in% pof_merge))

data.commits=ASE

m1 = lmer(log(num_non_merge_commits) ~
            log(TotalCommits) +
            #log(num_merge_commits+1) +
            AgeAtTravis +
            log(NumAuthors) +
            time +
            intervention +
            time_after_intervention  +
            (1+intervention|Repo) + (1|Language),
          data= subset(data.commits, period!=0),
          REML=FALSE)
summary(m1)

m2 = lmer(log(num_merge_commits) ~
            # log(TotalCommits) +
            log(num_non_merge_commits) +
            AgeAtTravis +
            log(NumAuthors) +
            time + 
            # intervention + 
            time_after_intervention  + 
            (1+intervention|Repo) + (1|Language),
          data= subset(data.commits, period!=0), 
          REML=FALSE)
summary(m2)

m3 = lmer(log(total_churn_mean_non_merge) ~
            log(TotalCommits) +
            # log(num_non_merge_commits) +
            AgeAtTravis +
            log(NumAuthors) +
            time +
            intervention +
            time_after_intervention  +
            (1+intervention|Repo) + (1|Language),
          data= subset(data.commits, period!=0 & total_churn_mean_non_merge>=1 & total_churn_mean_non_merge<=10000),
          REML=FALSE)
summary(m3)

