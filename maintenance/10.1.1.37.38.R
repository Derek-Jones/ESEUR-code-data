#
# 10.1.1.37.38.R, 11 May 15
#
# Data from:
#
# Learning from experience in a software maintenance environment
# Magne J{\o}rgensen and Dag I. K. Sj{\o}berg
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


maint=read.csv(paste0(ESEUR_dir, "maintenance/10.1.1.37.38.csv.xz"), as.is=TRUE)
maint$TASK.ID=NULL
maint$UNEXPEC=as.factor(maint$UNEXPEC)
maint$CONFIDENCE=as.factor(maint$CONFIDENCE)

pairs(~LOC+MEXPTOT+MEXPAPP, data=maint)

# table(maint$UNEXPEC)
unexpect_mod=glm(UNEXPEC ~ ., data=maint, family="binomial")
summary(unexpect_mod)

# The best performing prediction model is not worth the trouble...
unexpect_mod=glm(UNEXPEC ~ LOC, data=maint, family="binomial")
summary(unexpect_mod)

# table(maint$CONFIDENCE)
unexpect_mod=glm(CONFIDENCE ~ .-UNEXPEC, data=maint, family="binomial")

summary(unexpect_mod)

