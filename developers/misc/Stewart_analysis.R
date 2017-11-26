#
# Stewart_analysis.R,  2 Nov 17
# Data from:
# Neil Stewart and Stian Reimers and Adam J. L. Harris
# On the Origin of Utility, Weighting, and Discounting Functions: {How} They Get Their Shapes and How to Change Their Shapes
# Following code is a modified version of Stewart, Reimers and Harris code
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


###############################################################################
#
# Example R code for the model fitting for Experiment 1A of Stewart, Reimers, and Harris
#
###############################################################################

# rm(list=ls())
library(lme4) # using version lme4_1.1-1 from github
library(lattice)
library(latticeExtra)


pal_col=rainbow(2)


map=read.csv(paste0(ESEUR_dir, "developers/amount_map.csv"), as.is=TRUE)
map$name=paste("w", map$x, ".", map$cond, sep="")
# map

data=read.csv(paste0(ESEUR_dir, "developers/experiment_1A_data.csv"), as.is=TRUE)
catch.violations=aggregate(choice ~ order, data=subset(data, id>150), FUN=sum)
outliers=catch.violations$order[catch.violations$choice>=3] # participants who have violated dominance on 10% or more of catch trials
data=subset(data, !order%in%outliers) # Remove outlier participants
data=subset(data, id<=150) # Take only non-catch trials
data$order=as.factor(data$order) # order is a unique identifier for each participant

data=merge(data, map, by.x=c("x","cond"), by.y=c("x","cond"))
data=merge(data, map, by.x=c("y","cond"), by.y=c("x","cond"), suffixes=c("x", "y"))

# Order by subject (order) and question id (not trial number)
data=data[order(data$order, data$id),]
# head(data)

# Add dummy variables coding for the amounts
X.width=max(map$i)
X=matrix(0,nrow=nrow(data), ncol=X.width)
X[matrix(c(1:length(data$ix),data$ix),ncol=2)]=-1
X[matrix(c(1:length(data$iy),data$iy),ncol=2)]=1
colnames(X)=map$name[order(map$i)]
data=cbind(data,X)
# head(data)



###############################################################################
#
# Fit mixed effects logistic model with free utility for each value as in Appendix A
#
###############################################################################

mm1=glmer(choice ~ cond + w10.0 + w20.0 + w50.0 + w100.0 + w200.0 + w10.1 + w310.1 + w410.1 + w460.1 + w490.1 + log(q/p) + log(q/p):cond + (1|order) + (0+w10.0|order) + (0+w20.0|order) + (0+w50.0|order) + (0+w100.0|order) + (0+w200.0|order) + (0+w10.1|order) + (0+w310.1|order) + (0+w410.1|order) + (0+w460.1|order) + (0+w490.1|order) + (0+log(q/p)|order), data=data, family=binomial)
summary(mm1)

# Extract parameters and utilities 
gamma.0=fixef(mm1)["log(q/p)"]
gamma.1=fixef(mm1)["log(q/p)"] + fixef(mm1)["cond:log(q/p)"]
coef.table=as.data.frame(summary(mm1)$coefficients)
coef.table$name=rownames(coef.table)
values=merge(map, coef.table, all.x=T)
values$v=exp(values$Estimate)
values$v[values$cond==0]=values$v[values$cond==0] ^ (1/gamma.0)
values$v[values$cond==1]=values$v[values$cond==1] ^ (1/gamma.1)
values$v[is.na(values$v)]=1
values$cond=factor(values$cond, levels=c(0,1), labels=c("Positive", "Negative"))
values=values[order(values$cond, values$x),]
# values

pos_sk=subset(values, cond=="Positive")
neg_sk=subset(values, cond=="Negative")

plot(pos_sk$x, pos_sk$v, type="b", col=pal_col[1],
		yaxs="i",
		ylim=c(0, 1.02),
		xlab="Amount", ylab="Value\n")
lines(neg_sk$x, neg_sk$v, type="b", col=pal_col[2])

legend(x="bottomright", legend=c("Positive Skew", "Negative Skew"), bty="n", fill=pal_col, cex=1.2)

# xyplot(v ~ x, groups=cond, data=values, type=c("b"), scales=list(alternating=FALSE), ylim=c(-0.05,1.05), xlab="Amount", ylab="Value") + layer(panel.text(c(150,425),c(.8,.5),c("Positive Skew", "Negative Skew")))
# 
# 
# ###############################################################################
# #
# # Fit mixed effects logistic model with power law utility function as in Appendix B
# #
# ###############################################################################
# 
# mm2=glmer(choice ~ cond + log(q/p) + log(y/x) + log(q/p):cond + log(y/x):cond + (1|order) + (0+log(q/p)|order) + (0+log(y/x)|order), data=data, family=binomial) 
# summary(mm2)
# 
# (  bias.0=exp(fixef(mm2)["(Intercept)"])  )
# (  bias.1=exp(fixef(mm2)["(Intercept)"] + fixef(mm2)["cond"])  )
# (  gamma.0=fixef(mm2)["log(q/p)"]  )
# (  gamma.1=fixef(mm2)["log(q/p)"] + fixef(mm2)["cond:log(q/p)"]  )
# (  gamma.alpha.0=fixef(mm2)["log(y/x)"]  )
# (  gamma.alpha.1=fixef(mm2)["log(y/x)"] + fixef(mm2)["cond:log(y/x)"]  )
# (  alpha.0=gamma.alpha.0 / gamma.0  )
# (  alpha.1=gamma.alpha.1 / gamma.1  )
# 
# 
# 
# ###############################################################################
# #
# # Fit a simple logistic regression instead of mixed effects model (with power law utility function as in Appendix B)
# #
# ###############################################################################
# 
# m3=glm(choice ~ cond + log(q/p) + log(y/x) + log(q/p):cond + log(y/x):cond, data=data, family=binomial) 
# summary(m3)
# 
# (  bias.0=exp(coef(m3)["(Intercept)"])  )
# (  bias.1=exp(coef(m3)["(Intercept)"] + coef(m3)["cond"])  )
# (  gamma.0=coef(m3)["log(q/p)"]  )
# (  gamma.1=coef(m3)["log(q/p)"] + coef(m3)["cond:log(q/p)"]  )
# (  gamma.alpha.0=coef(m3)["log(y/x)"]  )
# (  gamma.alpha.1=coef(m3)["log(y/x)"] + coef(m3)["cond:log(y/x)"]  )
# (  alpha.0=gamma.alpha.0 / gamma.0  )
# (  alpha.1=gamma.alpha.1 / gamma.1  )
# 
# 
# 
# ###############################################################################
# #
# # More common is just to fit EU with power law utility function, which is mathematically exactly equivalent
# #
# ###############################################################################
# 
# U=function(x, alpha) {
# 	x^alpha
# }
# 
# V=function(p, x, alpha) {
# 	p * U(x, alpha)
# }
# 
# choice.prob=function(p, x, q, y, alpha, gamma, bias) {
# 	V.qy=V(q, y, alpha)
# 	V.px=V(p, x, alpha)
# 	bias*V.qy^gamma / (bias*V.qy^gamma + V.px^gamma)
# }
# 
# neg.lnL=function(data, model){
# 	-sum(data*log(model)+(1-data)*log(1-model))
# }
# 
# wrapper=function(par, data) {
# 	model=with(data, choice.prob(p, x, q, y, alpha=par[1], gamma=par[2], bias=par[3]))
# 	neg.lnL(data$choice, model) 
# }
# 
# fit.model=function(data) {
# 	fit=optim(par=c(1, 1, 1), fn=wrapper, data=data)
# 	data.frame(order=data$order[1], cond=data$cond[1], alpha=fit$par[1], gamma=fit$par[2], bias=fit$par[3], neg.lnL=fit$value, convergence=fit$convergence)
# }
# 
# # Fitting data at the level of each condition recovers estimates from m3 logistic regression exactly
# (  fit.0=optim(par=c(1, 1, 1), fn=wrapper, data=subset(data, cond==0))  )
# (  fit.1=optim(par=c(1, 1, 1), fn=wrapper, data=subset(data, cond==1))  )
# 
# # Fitting for each individual participant and taking medians gives similar results to mm2 mixed effects model, but correspondence won't be exact because mixed effects modelling reigns extreme participants
# fits=by(data=data, data$order, fit.model)
# fits=do.call(rbind, fits)
# fits
# aggregate(alpha ~ cond, data=fits, FUN=median)
# 
