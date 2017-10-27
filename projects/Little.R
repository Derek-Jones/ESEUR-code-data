#
# Little.R, 22 Sep 17
#
# Data from:
# Schedule Estimation and Uncertainty Surrounding the Cone of Uncertainty
# Todd Little
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")


# Project Code,Week End Date,Target RelDate,Env,Plan,Dev,Stab,Mob,Adj Week,Est EndDate,First Est,Actual Release,Start Date,X,Absolute Ratio,Relative Ratio,Update,Absolute ratio without factor 2,,Eind project,Oppervlakte,Counter,Som oppervlakte,EQF all,EQF end,Eind project factor 2,Oppervlakte factor 2,Counter factor 2,Som oppervlakte factor 2,EQF all factor 2,EQF end factor 2
# 1,12/01/00,03/01/01,C,C,I,,,12/01/00,03/01/01,03/01/01,08/22/01,12/01/00,0.00,0.6770156819,2.95,1,0.33851,,0,0.0085951791,1,0,4235.7284514877,0,0,0.0176034663,1,0,#DIV/0!,0
est=read.csv(paste0(ESEUR_dir, "projects/Little06.csv.xz"), as.is=TRUE)

est$Week.End.Date=as.Date(est$Week.End.Date, format="%m/%d/%y")
est$Target.RelDate=as.Date(est$Target.RelDate, format="%m/%d/%y")
est$Adj.Week=as.Date(est$Adj.Week, format="%m/%d/%y")
est$Est.EndDate=as.Date(est$Est.EndDate, format="%m/%d/%y")
est$First.Est=as.Date(est$First.Est, format="%m/%d/%y")
est$Actual.Release=as.Date(est$Actual.Release, format="%m/%d/%y")
est$Start.Date=as.Date(est$Start.Date, format="%m/%d/%y")
est$est_duration=est$First.Est-est$Start.Date


mk_target_unique=function(df)
{
# The same Target release date might be estimated again after a change of date,
# so duplicated cannot be used.  rle only works with atomic types
t=cumsum(c(1, head(rle(as.integer(df$Target.RelDate))$lengths, n=-1)))
return(df[t, ])
}

target_summary=function(df)
{
return(data.frame(est_duration=df$est_duration[1], num_reest=nrow(df)))
}


u_est=ddply(est, .(Project.Code), mk_target_unique)
t_sum=ddply(u_est, .(Project.Code), target_summary)

plot(t_sum$est_duration,t_sum$num_reest, col=point_col,
	xlab="Initial estimated duration (days)", ylab="Number of estimates")

lines(loess.smooth(t_sum$est_duration, t_sum$num_reest, span=0.5, family="gaussian"), col="green")

