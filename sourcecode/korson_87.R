#
# korson_87.R, 28 Feb 19
# Data from:
# An empirical study of the effects of modularity on program modifiability
# Timothy D. Korson and Vijay K. Vaishnavi
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG

source("ESEUR_config.r")


library("lme4")


kor=read.csv(paste0(ESEUR_dir, "sourcecode/korson_87.csv.xz"), as.is=TRUE)

kor$total=kor$code+kor$syntax+kor$logic

# Throw everything in the pot
# k_mod=glm(total ~ (Experiment+Group+Subject)^2, data=kor)
# k_mod=glm(total ~ Experiment+Group+Subject, data=kor)
k_mod=glm(total ~ (Experiment+Group)^2, data=kor)
summary(k_mod)


# A more sensible mixed effect model approach
# m_mod=lmer(total ~ Experiment+Group+(Group | Subject), data=kor)

m_mod=lmer(total ~ Experiment+Group+(1 | Subject), data=kor)
summary(m_mod)

# Remove really poorly performing subjects
no_out=subset(kor, Subject != "P13" & Subject != "P16")
nom_mod=lmer(total ~ Experiment+Group+(1 | Subject), data=no_out)
summary(nom_mod)


