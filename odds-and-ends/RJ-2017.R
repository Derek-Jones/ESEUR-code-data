#
# RJ-2017.R, 21 Oct 18
# Data from:
#
# Code is a modified version of that in:
# Implementing a Metapopulation {Bass} Diffusion Model using the {{\sf R}} Package {deSolve}
# Jim Duggan
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG differential-equation Bass-model sales

source("ESEUR_config.r")


library(deSolve)
library(plyr)
library(reshape2)
library(scales)


NUM_REGIONS=10
pal_col=rainbow(NUM_REGIONS)


TotalPopulation=1e6
name_reg=paste0("R", 1:NUM_REGIONS)

# Row/column connections between regions
row_reg=c(1, 1, 1, 1, 1, 2, 2, 2, 2, 2)
col_reg=c(1, 2, 3, 4, 5, 1, 2, 3, 4, 5)
# Percentage population in each region
pop_reg=c(0.10, 0.01, 0.21, 0.08, 0.17, 0.04, 0.05, 0.25, 0.03, 0.06)
sp=data.frame(Regions=name_reg,
		Row=row_reg,
		Col=col_reg,
		Pop=pop_reg*TotalPopulation)

normal_contacts=runif(NUM_REGIONS, pop_reg*40, pop_reg*60)
infectivity=runif(NUM_REGIONS, 0.01, 0.025)
names(infectivity)=name_reg
ALPHA=1.00

# Distance between regions
dm=as.matrix(dist(sp[c("Col", "Row")]))

# Contact rate depends on a power law of distance
cr=t(normal_contacts*(dm+1)^-ALPHA)
# Effective contact rate depends on infectivity (random values here)
ec=t(t(cr)*infectivity)
beta=ec/sp$Pop

# Simulation time steps
START=0; FINISH=50; STEP=0.01;
simtime=seq(START, FINISH, by=STEP)

# Regional potential customers, and actual customers.
# Initial customer is assigned to region 8
NUM_STOCKS_PER_REGION=2
stocks=c(PA_R1=sp$Pop[1], PA_R2=sp$Pop[2], PA_R3=sp$Pop[3],
		PA_R4=sp$Pop[4], PA_R5=sp$Pop[5], PA_R6=sp$Pop[6],
		PA_R7=sp$Pop[7], PA_R8=sp$Pop[8]-1, PA_R9=sp$Pop[9],
		PA_R10=sp$Pop[10],
 		AD_R1=0, AD_R2=0, AD_R3=0,
 		AD_R4=0, AD_R5=0, AD_R6=0,
 		AD_R7=0, AD_R8=1, AD_R9=0,
 		AD_R10=0)

# A model of the Bass differential equation sales model
# Solved using the ode function from the deSolve package.
model=function(time, stocks, auxs)
{
with(as.list(stocks),
   {
   states=matrix(stocks,
			nrow=NUM_REGIONS,
			ncol=NUM_STOCKS_PER_REGION)
   PotentialAdopters=states[,1]
   Adopters=states[,2]
# See paper for equation details
   Rho=beta %*% Adopters		# Eqn (11)
   AR=Rho * PotentialAdopters		# Eqn (9)
   dPA_dt=-AR				# Based on Eqn(1)
   dAD_dt=AR				# Based on Eqn(2)
   TotalPopulation=sum(stocks)
   TotalPotentialAdopters=sum(PotentialAdopters)
   TotalAdopters=sum(Adopters)
   return (list(c(dPA_dt, dAD_dt),
			AR_R=AR,
			TP=TotalPopulation,
			TPA=TotalPotentialAdopters,
			TAD=TotalAdopters))
  })
}

# Call ode to run the simulation
o=data.frame(ode(y=stocks, times=simtime, func=model,
			parms=NULL, method="euler"))
o1=o[seq(from=1, to=length(simtime), by=1/STEP), ]
tidy=melt(o1, id.vars="time")
names(tidy)=c("Time", "Variable", "Value")

# Extract adoption rate and total numbe rof adopters
ar=subset(tidy, grepl("AR_", Variable))
ad=subset(tidy, grepl("AD_", Variable))

plot(ar$Time, ar$Value, type="n",
		xaxs="i", yaxs="i",
		xlab="Time", ylab="Adoption rate\n")
d_ply(ar, .(Variable), function(df) lines(df$Time, df$Value,
				 col=pal_col[as.numeric(df$Variable)-20]))

# plot(ad$Time, ad$Value)

