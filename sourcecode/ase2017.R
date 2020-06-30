#
# ase2017.R, 14 Jun 20
# Data from:
# Exploring Regular Expression Comprehension
# Carl Chapman and Peipei Wang and Kathryn T. Stolee
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_human regex_matching


source("ESEUR_config.r")


library("ltm")
library("plyr")


qm=read.csv(paste0(ESEUR_dir, "sourcecode/ase2017.csv.xz"), as.is=TRUE)

qm=subset(qm, !is.na(Accur))

u_regex=unique(qm$Regex)

qm$regex_t=as.integer(mapvalues(qm$Regex, u_regex, 1:length(u_regex)))
qm$subj_t=qm$HIT_ID+1

corr_ans=matrix(data=NA, nrow=180, ncol=length(u_regex))
corr_ans[cbind(qm$subj_t, qm$regex_t)]=as.integer(qm$Accur >= 0.8)

corr_mod1=ltm(corr_ans ~ z1)

plot(corr_mod1,
	xaxs="i", yaxs="i",
	main="",
	xlab="Subject ability", ylab="Probability correct\n")

# corr_mod2=ltm(corr_ans ~ z1+z2)
# 
# zrange = c(-3.8, 3.8)
# plot(corr_mod2, col=point_col,
#	items=8,
#	zrange = zrange, z = seq(zrange[1], zrange[2], length = 10),
#	main="", sub="", labels="",
#	xlab="Alpha", ylab="Beta\n", zlab="Probability correct")

# t=tpm(corr_df) # fails to fit


