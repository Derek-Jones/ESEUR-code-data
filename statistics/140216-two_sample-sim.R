# Supporting code for the paper:
# An investigation of the false discovery rate and the misinterpretation of p-values
# David Colquhoun
# R. Soc. open sci. 1: 140216.
# http://dx.doi.org/10.1098/rsos.140216
# Downloaded from http://rsos.royalsocietypublishing.org/on February 1, 2015
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

#Two_mean_simulation
require(MASS)
#require(graphics)

#START INPUTS
mynsim=100000  #number of simulations to run

#set mean and SD for sample 1 and sample 2
#These values give 
#power=0.45 with n=8 and
#power=0.8 with n=16
mymu1=0
mysd1=1
mymu2=1
mysd2=1

myn=16    #number of obs per sample
outfile="run1.txt.xz" #name for output file

#set min and max P values for "significance"
myPmin=0.0
myPmax=0.05  #plot the distributions for control (sample 1) and treatment (sample2)

#END OF INPUTS

myxmin=mymu1-4*mysd1
myxmax=mymu1+4*mysd1
myinc=(myxmax-myxmin)/100
myx=seq(from = myxmin,to=myxmax,by=myinc)
myy1=dnorm(myx,mean=mymu1,sd=mysd1)
myy2=dnorm(myx,mean=mymu2,sd=mysd2)
X11()   #next plot in new window
plot(myx,myy1,type="l",col="blue",cex.axis=1.5,lwd=2,main="Distributions of observations")
lines(myx,myy2,col="red",lwd=2)

#plot distributions  of means for sample1 and 2
#myxmin=mymu1-1*mysd1
#myxmax=mymu1+1*mysd1
#myinc=(myxmax-myxmin)/100
myx=seq(from = myxmin,to=myxmax,by=myinc)
mysdm1=mysd1/sqrt(myn)
mysdm2=mysd2/sqrt(myn)
myy1=dnorm(myx,mean=mymu1,sd=mysdm1)
myy2=dnorm(myx,mean=mymu2,sd=mysdm2)
X11()   #next plot in new window
plot(myx,myy1,type="l",col="blue",cex.axis=1.5,lwd=2,main="Distributions of means")
lines(myx,myy2,col="red",lwd=2)

#end of distribution plottine

mycor=0.   #correlation = 0
#set covariance matrix
myvar1=mysd1^2
myvar2=mysd2^2
mysigma = matrix(c(myvar1,mycor,mycor,myvar2),2,2)

#initialisations
mymean=c(mymu1,mymu2)
mymean
mytruediff=mymean[2]-mymean[1]
mytruediff
mypval=vector(length=mynsim)
mypval[1:mynsim]=0
#mypval
myloCI=vector(length=mynsim)
myloCI[1:mynsim]=0
myhiCI=vector(length=mynsim)
myhiCI[1:mynsim]=0
mydiff=vector(length=mynsim)
mydiff[1:mynsim]=0
#myloCI
#myhiCI
#mydiff
mynsig=0  #counts number of pval between and myPmax =0.0

# set random number generator seed so sequence repeats
#set.seed(1941)
for (myr in c(1:mynsim))
{
  #simulate 2D data
  mydata=mvrnorm(n=myn, mymean,mysigma)
  mylabels=c('group1','group2') 
  colnames(mydata)=mylabels #Assign labels to columns of simulated data
  summary(mydata)
  mysampA=mydata[1:myn,1]
  mysampA
  mysampB=mydata[1:myn,2]
  mysampB
  
  #test ny using Cusney data each timw
  #mysampA=c(0.7,-1.6,-0.2,-1.2,-0.1,3.4,3.7,0.8,0.0,2)
  #mysampB=c(1.9,0.8,1.1,0.1,-0.1,4.4,5.5,1.6,4.6,3.4)
  #end of temp data reset
  myresult=t.test(mysampB,mysampA,alternative="two.sided", paired = FALSE, var.equal = TRUE,
                  conf.level = 0.95)
  mydiff[myr]=myresult$estimate[1]-myresult$estimate[2]
  myp=myresult$p.value
  mypval[myr]=myp 
  myloCI[myr]=myresult$conf.int[1]
  myhiCI[myr]=myresult$conf.int[2]
  if (myp > myPmin & myp <= myPmax) mynsig=mynsig+1
   }

#plot histogram of P values
X11()   #next plot in new window
mydat=hist(mypval,breaks=20,xlim=range(0:1),cex.axis=1.5,main="Distribution of P values")
#mydiff
summary(mypval)
str(mydat)

#plot histo of differences between means
mydat$counts
X11()   #next plot in new window
mydat1=hist(mydiff,breaks=20,cex.axis=1.5,main="Distribution of differences between means ")
mydat1$counts
#myloCI

#myhiCI
myCI=cbind(myloCI,myhiCI)
mynsig
#Check mynsig from final 
#mypval[4]=0.2  #test
mynsig=0
mysumdiff=0
#values to limit highly sig,...non-sig
my001=0  #counts number of P<0.001
my01=0  #counts number of 0.001<P<0.01
my05=0  #counts number of 0.01<P<0.05
myns=0  #counts number of P>0.05 "non sig"

for (myr in c(1:mynsim)) {
  myp=mypval[myr]
  myd=mydiff[myr]  
  if (myp > myPmin & myp <= myPmax) 
    {
    mynsig=mynsig+1
    mysumdiff=mysumdiff+myd
    }
    if (myp <= 0.001 ) my001=my001+1 
    if (myp > 0.001 & myp <= 0.01) my01=my01+1
    if (myp > 0.01 & myp <= 0.05) my05=my05+1
    if (myp > 0.05) myns=myns+1
   }
mynsig
mymeandiff=mysumdiff/mynsig
mymeandiff   #mean observed difference for expts with Pmin<P<=Pmax
mytruediff

#count also the fraction of "significant" results that are
#followed by a "non-sig' result 
# where "significant" means P<= 0.05 OR 0.01
myn05=0    #counts number of sig - non sig pairs for P=0.05
myn051=0   # counts number of sig-sig pairs
myn01=0    #counts number of sig-non sig pairs for P=0.05
myn011=0    #counts number of sig - sig pairs for P=0.05
mynsim1=mynsim-1
for (myr in c(1:mynsim1)) {
  myp=mypval[myr]
  myp1=mypval[myr+1]  
  if (myp <= 0.05 & myp1 > 0.05) myn05=myn05+1
  if (myp <= 0.05 & myp1 <= 0.05) myn051=myn051+1
  if (myp <= 0.01 & myp1 > 0.01) myn01=myn01+1
  if (myp <= 0.01 & myp1 <= 0.01) myn011=myn011+1
}
myn05
myn01
#power calculations
mysiglev=myPmax
mypower1=power.t.test(n=myn,sd=mysd1,delta=mytruediff,sig.level=mysiglev,type="two.sample",power=NULL)
mypower1
mypower=mypower1$power
mysig=mypower1$sig.level

#write results to a file (use 'cat' not 'write' to output list 

cat("INPUTS","\n",file=outfile,append=FALSE)
cat("number of simulation = ",mynsim,"\n",file=outfile,append=TRUE)
cat("number obs per sample = ",myn,"\n",file=outfile,append=TRUE)
cat("true mean for sample 1 = ",mymu1,"\n",file=outfile,append=TRUE)
cat("true mean for sample 2 = ",mymu2,"\n",file=outfile,append=TRUE)
cat("true SD (same for both samples) = ",mysd1,"\n",file=outfile,append=TRUE)
cat("Sig if P is between Pmin and Pmax = ",myPmin," to ",myPmax,"\n",file=outfile,append=TRUE)

cat("\n","OUTPUTS","\n",file=outfile,append=TRUE)
cat("power = ",mypower,"for P = ",mysig,"\n",file=outfile,append=TRUE)
cat("\n","Number of 'sig' differences (P between Pmin-Pmax) = ",mynsig," = ",100*mynsig/mynsim," percent","\n",file=outfile,append=TRUE)
cat("Number of P <= 0.001 = ",my001,"   = ",100*my001/mynsim," percent","\n",file=outfile,append=TRUE)
cat("Number of 0.001 < P <= 0.01 = ",my01,"   = ",100*my01/mynsim," percent","\n",file=outfile,append=TRUE)
cat("Number of 0.01 < P <= 0.05 = ",my05,"   = ",100*my05/mynsim," percent","\n",file=outfile,append=TRUE)
cat("Number of P > 0.05 = ",myns,"   = ",100*myns/mynsim," percent","\n",file=outfile,append=TRUE)
cat("Number of P <+ 0.05 = ",mynsim-myns,"   = ",100*(mynsim-myns)/mynsim," percent","\n",file=outfile,append=TRUE)
cat("\n","Obs diff bet means for 'sig' results = ",mymeandiff," True value = ",mytruediff,"\n",file=outfile,append=TRUE)

cat("\n","Number of times sig is followed by non-sig (P=0.05) = ",myn05," = ",100*myn05/(myn05+myn051)," percent","\n",file=outfile,append=TRUE)
cat("Number of times sig is followed by sig (P=0.05) = ",myn051," = ",100*myn051/(myn05+myn051)," percent","\n",file=outfile,append=TRUE)
cat("Number of times sig is followed by non-sig (P=0.01) = ",myn01," = ",100*myn01/(myn01+myn011)," percent","\n",file=outfile,append=TRUE)
cat("Number of times sig is followed by sig (P=0.01) = ",myn011," = ",100*myn011/(myn01+myn011)," percent","\n",file=outfile,append=TRUE)
