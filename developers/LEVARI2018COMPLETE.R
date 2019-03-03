#
# LEVARI2018COMPLETE.R,  4 Feb 19
# Data from:
# Prevalence-induced concept change in human judgment
# David E. Levari and Daniel T. Gilbert and Timothy D. Wilson and Beau Sievers and David M. Amodio and Thalia Wheatley
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment human judgment

source("ESEUR_config.r")


library("plyr")

pal_col=rainbow(4)


# Extract responses, fit a binomial model and plot it
binomial_fit=function(cond, timebin, col_str)
{
df=subset(study1, (condition == cond) & (timebin5 == timebin))
df$color=df$color/100
b_mod=glm(response ~ color, data=df, family=binomial)
# summary(st1_mod)
pred=predict(b_mod, newdata=data.frame(color=(0:100)/100), type="response")
lines(0:100, pred, col=col_str)

return(b_mod)
}


plot_condition=function(cond)
{
stable=subset(s1_means, condition == cond)

st_time1=subset(stable, timebin5 == 1)
st_time5=subset(stable, timebin5 == 5)

points(st_time1$color, st_time1$meanr, col=pal_col[cond*2+1])
points(st_time5$color, st_time5$meanr, col=pal_col[cond*2+2])

st1_mod=binomial_fit(cond, 1, pal_col[cond*2+1])
st5_mod=binomial_fit(cond, 5, pal_col[cond*2+2])

legend(x="bottomright",
	legend=c("First 200 dots (constant blue)", "Last 200 dots (constant blue)",
		 "First 200 dots (decreased blue)", "Last 200 dots (decreased blue)"),
	bty="n", fill=pal_col, cex=1.2)

}


study1=read.csv(paste0(ESEUR_dir, "developers/LEVARI2018COMPLETE.csv.xz"), as.is=TRUE)


# Following based on R code accompanying data
# David Levari, david.levari at gmail dot com
# last updated: 17 April 2018
# Study 1: Decreasing prevalence of colors

study1 = subset(study1, participant != 116) # Exclude a participant
study1 = subset(study1, trial > 10) # Ignore practice trials
study1$color = (study1$blue-154) # Zero the color variable
study1$trial = (study1$trial-10) # Zero trial var now practice trials removed
study1$response = as.factor(study1$response-1) # zero response var
study1$responsenum = as.numeric(study1$response)-1 # save response var as numeric

# Recode variables as factors for glmm
study1$participant = as.factor(study1$participant) #treat subject as factor
study1$condition = as.factor(study1$condition) #treat condition as factor
# 0=Stable Prevalence Condition
# 1=Decreasing Prevalence Condition

# Binned time variable for plots, only interested in first/last bins
study1$timebin5 = as.factor(apply(as.matrix(study1$trial), 2, 
                                   cut, c(seq(0,1000,200)), labels=FALSE))

# create means table for plotting
s1_means = ddply(study1, .(condition, timebin5, color), summarise, 
                    meanr=mean(responsenum,na.rm=TRUE),.drop=FALSE) 

plot(-1, type="n",
	xaxs="i", yaxs="i",
	xlim=c(0, 100), ylim=c(0, 1),
	xaxt="n",
	xlab="Objective color", ylab="Mean response\n")
axis(1, at=c(5, 95), label=c("Purple", "Blue"))
plot_condition(0) # stable
plot_condition(1) # decreasing


# The following is a copy of a subset of the code accompanying data

# ### FIT A GENERALIZED LINEAR MIXED MODEL (GLMM)
# 
# library("lme4")
# 
# # Rescale predictors between 0 and 1 for GLMM
# study1zeroed <- study1
# study1zeroed$color <- study1zeroed$color/100
# study1zeroed$trial <- study1zeroed$trial/1000
# 
# # MODEL 1: full model with random intercepts for participant and random slopes for trial
# study1.model1 <- glmer(response ~ (condition + trial + color)^3 + (trial | participant),
#                        family = binomial,
#                        control=glmerControl(optimizer="bobyqa"),
#                        data = study1zeroed)
# summary(study1.model1)
# 
# # MODEL 1A: without 3-way interaction
# study1.model1a <- glmer(response ~ (condition + trial + color)^2+
#                           (trial | participant),
#                         family = binomial,
#                         control=glmerControl(optimizer="bobyqa"),
#                         data = study1zeroed)
# # LRT compared to model with 3-way interaction
# anova(study1.model1a,study1.model1) # maximal - 1
# 
# # MODEL 2: without random slopes
# study1.model2 <- glmer(response ~ (condition + trial + color)^3 + (1 | participant),
#                        family = binomial,
#                        control=glmerControl(optimizer="bobyqa"),
#                        data = study1zeroed)
# # LRT compared to model with random slopes
# anova(study1.model2, study1.model1)
# 
# # MODEL 3: without random intercepts
# study1.model3 <- glmer(response ~ (condition + trial + color)^3 + (trial - 1| participant),
#                        family = binomial,
#                        control=glmerControl(optimizer="bobyqa"),
#                        data = study1zeroed)
# # LRT compared to model with random intercepts
# anova(study1.model3, study1.model1) 
# 
