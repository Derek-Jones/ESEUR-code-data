#
# CumminsModifiedNumeral.R, 15 Mar 18
# Data from:
# The interpretation and use of numerically-quantified expressions
# Christopher Raymond Cummins
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("lme4")


cummins=read.csv(paste0(ESEUR_dir, "reliability/CumminsModifiedNumeral.csv.xz"), as.is=TRUE)
quest=read.csv(paste0(ESEUR_dir, "reliability/CumminsQuest.csv.xz"), as.is=TRUE)

ans=merge(cummins, quest)

ans$s_num=as.integer(substring(ans$Subject, 3))
ans$s_num=ans$s_num-min(ans$s_num)+1

ans_few=subset(ans, Quantifier == "Fewer")
ans_few$Estimate=ans_few$Prime-ans_few$Best

ans_more=subset(ans, Quantifier == "More")
ans_more$Estimate=ans_more$Prime+ans_more$Best

few_more=rbind(ans_few, ans_more)

c_mod=glm(Best ~ sqrt(Prime)+Quantifier+Priming+Granularity, data=few_more)
summary(c_mod)

c_mod=glm(Best ~ sqrt(Prime)*Quantifier+Priming+Granularity, data=few_more)
summary(c_mod)

c_lmod=lmer(Best ~ sqrt(Prime)*Quantifier+Priming+Granularity+(Granularity | Subject),
		 data=few_more)
summary(c_lmod)


