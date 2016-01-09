#
# pbr-experiment.R, 19 Nov 15
#
# Data from:
# The Empirical Investigation of Perspective-Based Reading
# Victor R. Basili and Scott Green and Oliver Laitenberger and Filippo Lanubile and Forrest Shull and Sivert S{\o}rumg{\aa}rd and Marvin V. Zelkowitz
# Data kindly supplied by Filippo Lanubile
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("car")
library("plyr")
library("lme4")


# Independent variables:
# SUBJ          subject identifier;
# RUN           experimental run (1994, 1995);
# RTECH         reading technique (USUAL, PBR);
# PRSP          perspective (NONE, DES, USER, TEST);
# YEXP          subject experience in the assigned perspective: number of years
# DOC           document read (ATM, PG);
# Dependent variables:
# TDPC          percentage of true defects found;
# TDNO          number of true defects found;
# TIME          time to finish (in minutes);
# FPNO          number of false positives;
# FPPC          percentage of false positives; (derived)
# TDPH          number of true defects found per hour; (derived)
preallgr=read.csv(paste0(ESEUR_dir, "faults/basili/preallgr.csv.xz"), as.is=TRUE)
preallgr$DKIND="generic"
preallgr$DFIRST=(preallgr$RTECH != "USUAL")
preallna=read.csv(paste0(ESEUR_dir, "faults/basili/preallna.csv.xz"), as.is=TRUE)
preallna$DKIND="NASA"
preallna$DFIRST=(preallna$RTECH == "USUAL")

preall=rbind(preallgr, preallna)

# ATM - 17 pages, 29 seeded defects
# PG - 16 pages, 27 seeded defects
# A - 27 pages, 15 seeded defects
# B - 27 pages, 15 seeded defects
preall$DSEEDED=as.numeric(mapvalues(preall$DOC, c("ATM", "PG", "A", "B"),
				                c(  29 ,  27 ,  15,  15)))
preall$PAGES=as.numeric(mapvalues(preall$DOC, c("ATM", "PG", "A", "B"),
				              c(  29 ,  16 ,  27,  27)))
preall$DNOTFOUND=preall$DSEEDED-preall$TDNO
preall$ORDER=preall$OBS %% 2

all_95=subset(preall, RUN == 1995)
all_LE5=subset(all_95, YEXP <= 5)
all_GT0=subset(all_95, YEXP > 0)

# table(all_95$SUBJ)
# One subject only completed 2 out of 4
complete_95=subset(all_95, SUBJ != "J14")

day_1=subset(preall, RTECH == "USUAL")
day_2=subset(preall, RTECH != "USUAL")

# Each subject had a unique PRSP+other variables
# The number of actual faults that can be found is known.
# Given this upper limit and the yes/no detected status, we have
# a binomial distribution.
# t_mod=glmer(cbind(TDNO, DNOTFOUND) ~ PRSP+DKIND+(1 | SUBJ),
# 		data=complete_95, family=binomial)
t_mod=glmer(cbind(TDNO, DNOTFOUND) ~ ORDER+DKIND+(1 | SUBJ),
		data=complete_95, family=binomial)
Anova(t_mod)
summary(t_mod)

# pairs(~FPNO+as.factor(PRSP)+as.factor(SUBJ), data=complete_95)

# The number of false positives has no upper bound (in theory).
f_mod=glmer(FPNO ~ PAGES+PRSP+PRSP:YEXP+DKIND+DFIRST+(1 | SUBJ),
		data=complete_95, family=poisson)
Anova(f_mod)
summary(f_mod)


