#
# 500K_inputs.R, 18 Nov 19
#
# Data from:
# An Experiment in Software Reliability
# Janet R. Dunham and John L. Pierce
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment fault-experience

source("ESEUR_config.r")


library("reshape2")

pal_col=rainbow(4)


fit_mod=function(df)
{
AT_mod=glm(failure ~ log(F), data=df)
# f_mod=glm(failure ~ log(F)+I(log(F)^2), data=all_fails)

pred=predict(AT_mod, newdata=data.frame(F=exp(0:14)))

lines(exp(0:14), pred, col="grey")

return(AT_mod)
}


tests=read.csv(paste0(ESEUR_dir, "reliability/19860020075-500.csv.xz"), as.is=TRUE)
tests$Code=NULL
tests$Rep=NULL

all_fails=reshape(tests, varying=colnames(tests), timevar="failure", dir="long", sep="")

plot(all_fails$F, all_fails$failure, log="x", col=pal_col[1+(all_fails$id %% 4)],
	xlab="Input cases", ylab="Fault experience")

# The two programs (Application tasks) containing mistakes
AT1=subset(all_fails, id <= 4)
AT3=subset(all_fails, id > 4)

AT1_mod=fit_mod(AT1)
AT3_mod=fit_mod(AT3)


