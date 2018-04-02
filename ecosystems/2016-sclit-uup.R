#
# 2016-sclit-uup.R, 23 Aug 17
# Data from:
# Do Students' Programming Skills Depend on Programming Language?
# Milo\u{s} Savi{\'c} and Mirjana Ivanovi{\'c} and Zoran Budimac and Milo\u{s} Radovanovi{\'c}
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("boot")
library("lme4")
library("plyr")
library("reshape2")


fit_mod=function(Y)
{
y_score=subset(m_marks, Year == Y)

# 'best' simple integer polynomial fit
score_mod=lmer(P_score ~ PT_p + (1 | subj), data=y_score)

return(score_mod)
}


mean_f=function(marks, ind)
{
mean(marks[ind], na.rm=TRUE)
}


# bootstrap mean
mean_marks=function(Y)
{
# marks_boot=boot(subset(m_marks, Year == Y)$PT1, mean_f, R = 4999)
marks_boot=boot(subset(m_marks, Year == Y)$PT4, mean_f, R = 4999)
}

# PT practical, TT theory
marks=read.csv(paste0(ESEUR_dir, "ecosystems/2016-sclit-uup.csv.xz"), as.is=TRUE)

# Percentage of marks available for each practical
marks$PT1_p=marks$PT1/10.0
marks$PT2_p=marks$PT2/10.0
marks$PT3_p=marks$PT3/20.0
marks$PT4_p=marks$PT4/20.0

# So student practical marks improve with practice?
m_marks=melt(marks, measure.vars=c("PT1_p", "PT2_p", "PT3_p", "PT4_p"),
		variable.name="PT", value.name="P_score")

m_marks=melt(m_marks, measure.vars=c("TT1", "TT2"),
		variable.name="TT", value.name="T_score")

m_marks$PT_p=as.integer(mapvalues(m_marks$PT, c("PT1_p", "PT2_p", "PT3_p", "PT4_p"), 1:4))
m_marks$TT=as.integer(mapvalues(m_marks$TT, c("TT1", "TT2"), 1:2))

plot(m_marks$PT_p, m_marks$P_score)


s_2012=fit_mod(2012)
summary(s_2012)
# confint(s_2012)

s_2013=fit_mod(2013)
summary(s_2013)
# confint(s_2013)

s_2014=fit_mod(2014)
summary(s_2014)
# confint(s_2014)

# bootstrap mean and get confidence interval
boot.ci(mean_marks(2012))
boot.ci(mean_marks(2013))
boot.ci(mean_marks(2014))

