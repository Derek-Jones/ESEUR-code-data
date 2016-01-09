#
# anchor-estimate.R,  2 Apr 15
#
# Data from:
# The impact of customer expectation on software development effort estimates
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


#ID,PS,CATEGORY,YEARS,PROJ_LEAD,num_course,LOC,self_opin,prof_exp,START,TECH,NACT,MIN,ML,MAX,UNC1,UNC2,UNC3,STOP
estimate=read.csv(paste0(ESEUR_dir, "group-compare/anchor/anchor-estimate.csv.xz"), as.is=TRUE)

prof=subset(estimate, PS == "P")

# est=glm(ML ~ CATEGORY+UNC1+UNC2+UNC3+YEARS, data=prof)

est=glm(ML ~ CATEGORY, data=prof)

# pairs(~ ML + as.factor(CATEGORY)+UNC1+UNC2+UNC3+YEARS, data=prof)

