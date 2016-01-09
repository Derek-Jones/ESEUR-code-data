#
# anchor-estimate.R, 11 Nov 15
#
# Data from:
#
# The Impact of Customer Expectation on Software Development Effort Estimates
# Magne J{\o}rgensen and Dag I. K. Sj{\o}berg
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

# Q1.1: Number of courses in software development
# Q1.2: "Students: Number of programmed LOC, Professionals: Years of experience"
# Q1.3: "Students: Self-assessed programming competence, Professionals: Number of projects where project leader"
# Q1.4: Students: Experience as software professional
# START: Time when task started
# NACT: Number of activitites
# MIN: Total minimum estimate
# ML: Total most likely estimate
# MAX: Total maximum estimate
# UNC1: Uncertainty- inherent
# UNC2: Uncertainty - knowledge
# UNC3: Uncertainty -control
# STOP: Time when task complete
# NB: UNC1 - UNC3 was measured in %-age importance for the students and on a scale 1-6 for the professionals.: ,

# Person.ID,Category,Group,QuestID,Answer,Time
estimate=read.csv(paste0(ESEUR_dir, "developers/anchor-estimate.csv.xz"), as.is=TRUE)

brew_col=rainbow(3)

min_est=subset(estimate, QuestID == "MIN")
ml_est=subset(estimate, QuestID == "ML")
max_est=subset(estimate, QuestID == "MAX")

ml_ord=order(ml_est$Answer)

# anc_mod=glm(Answer ~ (Category+Group)^2, data=ml_est)
anc_mod=glm(Answer ~ Group, data=ml_est)

summary(anc_mod)

plot(max_est$Answer[ml_ord], col=brew_col[1])
points(min_est$Answer[ml_ord], col=brew_col[3])
points(ml_est$Answer[ml_ord], col=brew_col[2])

