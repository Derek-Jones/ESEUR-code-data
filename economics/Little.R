#
# Little.R,  9 Mar 16
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
lit=read.csv(paste0(ESEUR_dir, "economics/Little06.csv.xz"), as.is=TRUE)

lit$Week.End.Date=as.Date(lit$Week.End.Date, format="%m/%d/%y")
lit$Target.RelDate=as.Date(lit$Target.RelDate, format="%m/%d/%y")
lit$Adj.Week=as.Date(lit$Adj.Week, format="%m/%d/%y")
lit$Est.EndDate=as.Date(lit$Est.EndDate, format="%m/%d/%y")
lit$First.Est=as.Date(lit$First.Est, format="%m/%d/%y")
lit$Actual.Release=as.Date(lit$Actual.Release, format="%m/%d/%y")
lit$Start.Date=as.Date(lit$Start.Date, format="%m/%d/%y")
lit$p_duration=lit$Actual.Release-lit$Start.Date

mk_target_unique=function(df)
{
return(subset(df, !duplicated(df$Target.RelDate)))
}

target_summary=function(df)
{
data.frame(duration=df$p_duration[1], num_reest=nrow(df))
}

plot_each_est=function(df)
{
points(df$Target.RelDate-df$Week.End.Date)
}

plot_est_ratio=function(df)
{
ests=df$Target.RelDate-df$Week.End.Date
points(c(ests[-1], -10)/as.numeric(ests))
}


t=ddply(lit, .(Project.Code), mk_target_unique)
t_sum=ddply(t, .(Project.Code), target_summary)

plot(t_sum$duration,t_sum$num_reest, col=point_col,
	xlab="Project durations (days)", ylab="Reestimates")

lines(loess.smooth(t_sum$duration,t_sum$num_reest, span=0.5, family="gaussian"), col="green")

# plot(0, type="n",
# 	xlim=c(1, 20), ylim=c(1, 400),
# 	xlab="Estimate number", ylab="Estimated duration")
# d_ply(t, .(Project.Code), plot_each_est)

# plot(0, type="n",
# 	xlim=c(1, 20), ylim=c(0, 2.5),
# 	xlab="Estimate number", ylab="Estimated duration")
# d_ply(t, .(Project.Code), plot_est_ratio)

