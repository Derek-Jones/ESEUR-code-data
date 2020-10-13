#
# rspb-2011-1172.R,  9 Oct 20
# Data from:
# The evolutionary basis of human social learning
# T. J. H. Morgan and L. E. Rendell and M. Ehn and W. Hoppitt and K. N. Laland
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_human learning_social decision_social-influence

source("ESEUR_config.r")


library("lme4")


pal_col=rainbow(4)


switch_prob=function(X)
{
pred=predict(sw_mod, newdata=data.frame(demo_dis=d_bounds,
					GuessConfidence=rep((X-1)*2, length(d_bounds)),
					PlayerID=rep(13, length(d_bounds))),
			type="response")
lines(d_bounds, 100*pred, col=pal_col[X])
}


# Experiment 2
# Email from Morgan
# player id - an id for each participant
# question id - either the number for each question (0:23) or perhaps the
# numeric id of the stimuli they saw
# guess - the ppts initial answer, 1=shapes match, 0=they dont
# guess confidence - ppts rating of their confidence in their initial answer, from 0 (low) to 6 (high)
# guess mark - was the ppt right? 1=yes, 0=no
# social treatment - an id of the social information they received, probably
# not meaningful
# total flashes - how many people they heard from
# match flashes - how many other people said the shapes match
# no match flashes - how many other people said the shapes dont match
# answer - the ppts final answer
# answer confidence - the ppts confidence in their final answer
# answer mark - was the ppts final answer right?
# right answer - the true answer
# payment score - not sure, something to do with each ppts bonus payment?
# switch - did the ppt change their mind between their initial and final answers
# soc answer - the majority opinion among the demonstrators (1=match)
# disagreement - did the majority of demonstrators disagree with the ppts initial answer
# agreement - what proportion of demonstrators formed the majority of demonstrators
# vector agree - same as above, but negative if they disagreed with the ppts initial answer.

e2=read.csv(paste0(ESEUR_dir, "developers/rspb-2011-1172.csv.xz"), as.is=TRUE)

# Fraction of demonstrators who disagree with subject's choice
e2$demo_dis=ifelse(e2$Guess == 1, e2$NoMatchFlashes/e2$TotalFlashes,
					e2$MatchFlashes/e2$TotalFlashes)
e2$demo_dis[!is.finite(e2$demo_dis)]=0

e2$guess_right=(e2$Guess == e2$Answer)

# table(e2$Guess, e2$guess_right)
#   
#    FALSE TRUE
#  0    76  552
#  1    68  528
#
# table(e2$switch)
#
#    0    1 
# 1080  144 
#
# sum(e2$switch)/51

sw_mod=glmer(switch ~ demo_dis+(demo_dis-1 | PlayerID)+
			# log(1e-1+TotalFlashes)+ # smallish impact
			# guess_right+ # not positive definite
			GuessConfidence,
		data=e2, family=binomial)
# summary(sw_mod)

plot(0, type="n",
	xaxs="i", yaxs="i",
	xlim=c(0, 1), ylim=c(0, 85),
	xlab="Demonstrators disagreeing", ylab="Switch answer (probability)\n")

legend(x="topleft", legend=paste0("Confidence = ", 2*(0:3)), bty="n", fill=pal_col, cex=1.2)


d_bounds=seq(0, 1, by=0.1)

d=sapply(1:4, switch_prob)

