#
# 1997-jese-guid.R,  9 Dec 17
# Data from:
# A Controlled Experiment to Evaluate On-Line Process Guidance
# Christopher M. Lott
# 
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("lme4")


guid=read.csv(paste0(ESEUR_dir, "faults/1997-jese-guid.csv"), as.is=TRUE)

# Normalise by number of faults available to be found
FT=subset(guid, EX == "FT_cmd")
FT$R=FT$R/10
FT$D=FT$D/10

ST=subset(guid, EX == "ST_tok")
ST$R=ST$R/5
ST$D=ST$D/5

normalised=rbind(FT, ST)

t_mod=lmer(T ~ L+Order+G+R+D+EX+(1 | ID), data=normalised)
summary(t_mod)

