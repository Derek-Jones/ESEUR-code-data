#
# 0909.R,  2 Oct 13
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

# Code from:
# The Evolution of Overconfidence
# Dominic D. P. Johnson and James H. Fowler
#
## FUNCTION TO FIND SPECIFIC PAYOFFS WHEN EACH INDIVIDUAL
## PLAYS ONE OTHER INDIVIDUAL IN THE POPULATION
simkvec=function(k,error)
{
# randomly match each i with a j
pairs=matrix(sample(k),ncol=2) # generate random pairs
k_i=c(pairs[,1],pairs[,2]) # create vector of types for individual i
k_j=c(pairs[,2],pairs[,1]) # create vector of types for individual j
# errors and advantages
a=rnorm(n) # endowment advantage of i over j
if(error=="normal")
   {
   e_i=rnorm(n,0,e) # errors in i perception of j
   e_j=rnorm(n,0,e) # errors in j perception of i
} else {
   if(error=="binomial")
      {
      e_i=sample(c(e,-e),n,replace=T) # errors in i perception of j
      e_j=sample(c(e,-e),n,replace=T) # errors in j perception of i
   } else {
      return("need to specify binomial or normal error")
      }
   }

# probabilities of claiming and winning
i_claims = ( a + e_i + k_i) > 0 # determine if i makes a claim
j_claims = (-a + e_j + k_j) > 0 # determine if j makes a claim
i_wins = a > 0 # determine if i beats j
# payoffs
# r if i fights and j does not fight,
# r-c if j fights and i wins, and
# -c if j fights and i loses,
# 0 otherwise
payoffs_i = i_claims * ifelse(j_claims, i_wins*r - c, r)
# return payoffs
return(cbind(k_i, payoffs_i))
}

## FUNCTION TO APPROXIMATE E(PAYOFF) TO k_i AGAINST A SPECIFIC k_j
simkpair=function(k,error)
{
# advantage distribution
a = (-5*nn):(5*nn)/nn # advantage to i
pr_a = dnorm(a) # probability density for a
pr_a = pr_a / sum(pr_a) # normalize density to create probabilities
# probabilities of claiming and winning
if(error=="normal")
   {
   i_claims = pnorm( a + k[1], sd=e) # probability i makes a claim
   j_claims = pnorm(-a + k[2], sd=e) # probability j makes a claim
} else if(error=="binomial")
   {
   i_claims = 0.5*( a + k[1] + e > 0) + 0.5*( a + k[1] - e > 0) # probability i makes a claim
   j_claims = 0.5*(-a + k[2] + e > 0) + 0.5*(-a + k[2] - e > 0) # probability j makes a claim
} else
   {
   return("need to specify binomial or normal error")
   }
i_wins = a > 0 # determine if i beats j
i_ties = which(a == 0) # determine when i ties j
# payoffs
# r if i fights and j does not fight,
# r-c if j fights and i wins, and
# -c if j fights and i loses,
# 0 otherwise
payoffs_i = i_claims * (j_claims * (i_wins * r - c) + (1 - j_claims) * r)
# if i and j tie, there is a 0.5 chance i wins
payoffs_i[i_ties] = i_claims[i_ties] *
(j_claims[i_ties] * (0.5 * r - c) + (1 - j_claims[i_ties]) * r)
# return payoffs
return(sum(payoffs_i * pr_a ))
}


## FUNCTION TO GET PAYOFFS FOR AN INVADER AND 2 EXISTING TYPES IN A POPULATION
# get payoffs for an invader and 2 types in a population
simk3=function(x,y,error)
{
# if type 1 and 2 are the same, then do not calculate mixture
if(y[1] == y[2])
   {
   p_pop=simkpair(c(y[1],y[1]),error=error) # type 1 payoff vs. self
   mix=1 # arbitrarily assign type 1 to be the winning type
# otherwise, calculate mixture
} else {
   # calculate payoffs when each population type plays self and other
   p11=simkpair(c(y[1],y[1]),error=error) # type 1 payoff vs. type 1
   p12=simkpair(c(y[1],y[2]),error=error) # type 1 payoff vs. type 2
   p21=simkpair(c(y[2],y[1]),error=error) # type 2 payoff vs. type 1
   p22=simkpair(c(y[2],y[2]),error=error) # type 2 payoff vs. type 2
# calculate proportion of type 1 in equilibrium mixture
   if(p11>=p21&p12>=p22)
     {
     mix=1
   } else {
      if(p21>p11&p22>p12)
         {
         mix=0
      } else {
         mix=(p22-p12)/(p11-p12-p21+p22)
         }
      }
# payoff of population
   p_pop=mix*p11+(1-mix)*p12
   }

# payoff of each invader type vs. population
p_inv=rep(NA,length(x))
for(i in 1:length(x))
   {
   p_inv[i]= mix * simkpair(c(x[i],y[1]),error=error) +
   (1-mix) * simkpair(c(x[i],y[2]),error=error)
   }
# return mixture and invader and population payoffs
return(cbind(mix,p_inv,p_pop))
}

## FUNCTION USED BY BEST REPLY FUNCTION
simk3optimize = function(x,y,error=error) simk3(x,y,error=error)[2]

## FUNCTION TO IDENTIFY EQUILIBRIA BASED ON ITERATED BEST REPLY
bestreply=function(khats,error)
{
khatslist=paste(khats,collapse=" ") # initialize population list
continue=TRUE # initialize continuation variable
# start loop to search for best replies
while(continue)
   {
   print(khats)
# find maxima in various regions less than, greater than, and near 0
# we do this because the payoff curve is sometimes kinked for the binomial case
# at -2e, -e, 0, e, and 2e
   o1 = optimize(simk3optimize, c(-5,-3*e/2), y=khats, maximum = T, error=error)
   o2 = optimize(simk3optimize, c(-3*e/2,-e/2), y=khats, maximum = T, error=error)
   o3 = optimize(simk3optimize, c(-e/2,e/2), y=khats, maximum = T, error=error)
   o4 = optimize(simk3optimize, c(e/2,3*e/2), y=khats, maximum = T, error=error)
   o5 = optimize(simk3optimize, c(3*e/2,5), y=khats, maximum = T, error=error)
   objectives=c(o1$objective,o2$objective,o3$objective,o4$objective,o5$objective)
   maxima=c(o1$maximum,o2$maximum,o3$maximum,o4$maximum,o5$maximum)
# choose invader with highest maximum
   invader=maxima[which.max(objectives)]
# evaluate best invader vs. population
   s=simk3(invader,y=khats,error=error)
# if invader does better than population....
   if(s[2]>=s[3])
      {
# check current type against a mix of invader and other current type
      s1=simk3(khats[1],y=c(khats[2],invader),error=error)
      s2=simk3(khats[2],y=c(khats[1],invader),error=error)
# if invader dominates both populations, create whole pop from invaders
      if(s1[1]==0&s2[1]==0)
         {
         khats=c(invader,invader)
      } else {
# replace type that does worst against invader
         if(s1[2]>=s2[2]) khats=sort(c(khats[1],invader))
         if(s2[2]>s1[2]) khats=sort(c(khats[2],invader))
         }
      }
# add this population to the list (round to 3 digits)
   khatslist=c(khatslist,paste(round(khats,3),collapse=" "))
# if this population was already evaluated, stop searching
   if(khatslist[length(khatslist)]%in%khatslist[1:(length(khatslist)-1)]) continue=FALSE
   }
# print approximate solution
return(khats)
}

## STEP 1: SET PARAMETERS FOR SIMULATION
n=1000 # number of individuals in population
c=1 # cost of fighting
r=2 # reward to winning
e=1 # size of error perception
d=0.5 # approx. fraction of population that dies each time
g=5000 # number of generations
m=0.001 # mutation rate
gg=50 # how many generations to skip between plot points
error="binomial" # choose binomial or normal perception error
start="unbiased" # choose starting population
# initial distribution of possible k thresholds in population
# NOTE: IF THERE ARE TWO EQUILIBRIA, STARTING VALUES WILL DETERMINE
# WHICH ONE HAPPENS.
if(start=="unbiased")
   {
# start with unbiased population
   k=rep(0,n)
} else {
# otherwise start with extreme mixed population
   k=c(rep(-10,round(n/2)),rep(10,n-round(n/2)))
   }
# initialize plot
par(mai=c(1,1.2,0.1,0.1))
colors=rainbow(6001)[sample(6001)] # randomly assign color to each type
plot(c(-1000,g*2),c(0,0),xlim=c(0,g),ylim=c(-3,3),type="l",lty="dotted",
xlab="Generations",font.lab=2,cex.lab=1.5,cex.axis=1.5,lwd=3,
ylab="Type (k)\nUnderconfident Overconfident")
# loop through each generation
for(i in 1:g)
   {
# get payoffs
   kp=simkvec(k,error=error)
   k=kp[,1]
   p=kp[,2]
# plot payoffs compared to k, color fixed for each k
   if(i%%gg==0)
      {
      tab=table(k)
      points(rep(i,length(tab)),names(tab),pch=1,cex=5*sqrt(tab/n),
      col=colors[(as.numeric(names(tab))+3)*1000+1])
      }
# normalize payoffs to create probability of remaining in population
# proportional to payoff
   p=(p-min(p))/(max(p)-min(p))
   p=1-2*(1-p)*d
# decide which individuals to remove from population
   dead=which(p<runif(n,0,1))
# replace dead strategies with live strategies
   if(length(dead)>0) k[dead]=sample(k[-dead],length(dead),replace=T)
# create mutant types, sampling from whole space
   mutant=sample(n,round(n*m))
   k[mutant]=round(runif(1,-3,3),3)
   }
## STEP 2: ADD ITERATED BEST REPLY EQUILIBRIA
nn=1000 # number of samples of normal distribution (higher = slower, more accurate)
# search near unbiased populations
b1=bestreply(c(0,0),error=error)
# search again far from unbiased populations
b2=bestreply(c(-10,10),error=error)
# print approximate equilibria (note, sometimes they will be different,
# but if they are nearby they are probably technically the same one)
print(b1)
print(b2)
# add best reply equilibrium points to plot
points(c(g,g),b1,pch=4,cex=5,col="black")
points(c(g,g),b2,pch=4,cex=5,col="black")


