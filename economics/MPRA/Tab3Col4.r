#
# MPRA_paper_46036.R, 3 Mar 17
# Data from:
# Moshe Givon and Vijay Mahajan and Eitan Muller
# Software Piracy: {Estimation} of Lost Sales and the Impact on Software Diffusion
# via James Waters
# Code slightly modified version from:
# Variable marginal propensities to pirate and the diffusion of computer software
# James Waters
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library(MASS)
library(numDeriv)


pal_col=rainbow(3)

data=read.csv(paste0(ESEUR_dir,  "economics/Givon_et_al_Software_piracy_data.csv"),  as.is=TRUE)

# data=read.table(paste(currdir,  "Givon_et_al_Software_piracy_data.txt",  sep=""),   header=T)
# attach(data)
yrmth=data$Year+data$Month/12

#####################################################
#PC (one variable Bass model) sales generation
#####################################################
p<-0.00037
q<-0.0316
m<-15386100
stdev_generate<-0
stdev_observe<-0
timeperiods<-400
steps<-10
dt<-1/steps
N<-c(0,rep(NA,timeperiods*steps))
n<-rep(NA,timeperiods*steps+1)
for (i in 1:(timeperiods*steps)) {
n[i+1]<-((p+q*N[i]/m)*(m-N[i]))*dt
N[i+1]<-N[i]+n[i+1]
}

NObs<-N[seq(1,length(N),steps)]

NObs<-NObs[13:length(NObs)]
N<-N[(12*steps+1):length(N)]

#####################################################
#Simulating some piracy data
#####################################################
gen_pirate_diffusion<-function(xx) {

set.seed(1)

a<-xx[1]
b1<-xx[2]
b2<-xx[3]
alpha<-xx[4]
q11<-xx[5]
q22<-xx[6]
q12<-xx[7]
rr1<-xx[8]
epsilon<-xx[9]

X<-vector()
Y<-vector()
x<-vector()
y<-vector()

X[1]<-0
Y[1]<-0

#The X and Y up to time=120
for (i in 2:120) {

x[i]<-(a+alpha*(b1*X[i-1]+b2*Y[i-1])/NObs[i])*(NObs[i]-X[i-1]-Y[i-1])
y[i]<-(1-alpha)*(max(Y[i-1],1)^epsilon)*((b1*X[i-1]+b2*Y[i-1])/NObs[i])*(NObs[i]-X[i-1]-Y[i-1])

X[i]<-X[i-1]+x[i]
Y[i]<-Y[i-1]+y[i]

}

plot(2:120,c(max(y[2:120]),rep(0,length(y[2:120])-1)),col="White",type="l",xlab="Time",ylab="Sales")
lines(2:120,x[2:120],col="Black",type="l")
lines(2:120,y[2:120],col="Red",type="l")

x<<-x
y<<-y
X<<-X+rnorm(1,0,sqrt(r11))
Y<<-Y
x_stored_generated<<-x
y_stored_generated<<-y
x_sim<<-x[53:120]
y_sim<<-y[53:120]

}

a<-0.000200000
b1<-0.135310
b2<-0.1351100
alpha<-0.1438000
q11<-0
q22<-0
q12<-0
r11<-0
epsilon<-0

gen_pirate_diffusion(c(a,b1,b2,alpha,q11,q22,q12,r11,epsilon))

#Pre-January 1987 diffusion
X[52]
Y[52]

#Installing the word processor data
X<-X[52]+cumsum(WordProcessors) #So that X[1] is now January 1987
Y[1]<-Y[52]
Y[2:length(Y)]<-rep(NA,length(Y)-1)
NObs<-NObs[53:length(NObs)]
N<-N[(52*steps+1):length(N)]

#####################################################
#PC projection using a Kalman filter
#####################################################

projectkalman<-function(xx) {
#Parameters
#Provided parameters
a<-0.02*xx[1]^2/(1+xx[1]^2)
b1<-xx[2]^2/(1+xx[2]^2)
b2<-xx[3]^2/(1+xx[3]^2)
alpha<-xx[4]^2/(1+xx[4]^2)
q11<-10^9*xx[5]^2/(1+xx[5]^2)
epsilon<-0.2*xx[6]/(1+abs(xx[6]))

#Predefined parameters
q22<-q11
q12<-0*10^9
r11<-0

Q<-matrix(c(q11,q12,q12,q22),nrow=2)
R<-matrix(r11,nrow=1)

LL<-0 #The value of the log likelihood

timeperiods<-length(X)-1

#Initial values
#The state vector
Xtt<-array(,c(timeperiods+1,2))
Xtt[1,1]<-X[1]
Xtt[1,2]<-Y[1]

#The error's covariance matrix
Ptt<-array(,c(timeperiods+1,2,2))
Ptt[1,1,1]<-0
Ptt[1,1,2]<-0
Ptt[1,2,1]<-0
Ptt[1,2,2]<-0

#The log likelihood component vector for the output product
ll<-vector()
#The mean squared error components
mse_comp<-vector()

predict_observe<-vector()

for (j in 1:timeperiods) {
#Prediction
X_pred<-Xtt[j,]
P_pred<-Ptt[j,,]
for (i in 1:steps) {

X1<-X_pred[1]
X2<-X_pred[2]

X_pred[1]<-X1+((a+alpha*(b1*X1+b2*X2)/N[j*steps+i])*(N[j*steps+i]-X1-X2))*dt
X_pred[2]<-X2+((1-alpha)*(max(X2,1)^epsilon)*((b1*X1+b2*X2)/N[j*steps+i])*(N[j*steps+i]-X1-X2))*dt

F11<-alpha*b1-a-2*alpha*(b1/N[j*steps+i])*X1-alpha*((b1+b2)/N[j*steps+i])*X2
F12<-alpha*b2-a-alpha*((b1+b2)/N[j*steps+i])*X1-2*alpha*(b2/N[j*steps+i])*X2
F21<-(1-alpha)*(max(X2,1)^epsilon)*(b1/N[j*steps+i])*(N[j*steps+i]-X1-X2)-(1-alpha)*(max(X2,1)^epsilon)*((b1*X1+b2*X2)/N[j*steps+i])
F22<-(1-alpha)*epsilon*(max(X2,1)^(epsilon-1))*((b1*X1+b2*X2)/N[j*steps+i])*(N[j*steps+i]-X1-X2)+(1-alpha)*(max(X2,1)^epsilon)*(b2/N[j*steps+i])*(N[j*steps+i]-X1-X2)-(1-alpha)*(max(X2,1)^epsilon)*((b1*X1+b2*X2)/N[j*steps+i])
F<-matrix(c(F11,F12,F21,F22),nrow=2,byrow=TRUE)

P_pred<-P_pred+(F%*%P_pred+P_pred%*%t(F)+Q*N[j*steps+i]*10^(-6))*dt

}

Xttminus<-X_pred
Pttminus<-P_pred

Ht<-c(1,0)

predict_observe[j+1]<-t(Ht)%*%Xttminus

#Update
Kt<-Pttminus%*%Ht%*%(t(Ht)%*%Pttminus%*%Ht+R)^(-1)
Xtt[j+1,]<-Xttminus+Kt%*%(X[j+1]-t(Ht)%*%Xttminus)
Ptt[j+1,,]<-(diag(2)-Kt%*%t(Ht))%*%Pttminus

#Log likelihood updating
LL<-LL+log((2*pi)^(-1/2)) + log((t(Ht)%*%Pttminus%*%Ht+R)^(-1/2)) + (-1/2)*(X[j+1]-t(Ht)%*%Xttminus)*(t(Ht)%*%Pttminus%*%Ht+R)^(-1)*(X[j+1]-t(Ht)%*%Xttminus)

ll[j]<-log((2*pi)^(-1/2)) + log((t(Ht)%*%Pttminus%*%Ht+R)^(-1/2)) + (-1/2)*(X[j+1]-t(Ht)%*%Xttminus)*(t(Ht)%*%Pttminus%*%Ht+R)^(-1)*(X[j+1]-t(Ht)%*%Xttminus)

mse_comp[j]<-(X[j+1]-t(Ht)%*%Xttminus)^2

}

actual_sales<<-X[3:(timeperiods+1)]-X[2:(timeperiods)]
predicted_sales<<-predict_observe[3:(timeperiods+1)]-X[2:(timeperiods)]

plot(1:(timeperiods-1),actual_sales,col="Black",type="l",xlab="Time",ylab="Sales",main="Black=actual, red=predicted")
lines(1:(timeperiods-1),predicted_sales,col="Red",type="l")

ll<<-ll

mse<<-sum(mse_comp)/timeperiods

LL<<-LL

LL
}


projectkalman_original_params<-function(xx) {
#Parameters
#Provided parameters
a<-xx[1]
b1<-xx[2]
b2<-xx[3]
alpha<-xx[4]
q11<-xx[5]*10^9
epsilon<-xx[6]

#Predefined parameters
q22<-q11
q12<-0*10^9
r11<-0

Q<-matrix(c(q11,q12,q12,q22),nrow=2)
R<-matrix(r11,nrow=1)

LL<-0 #The value of the log likelihood

timeperiods<-length(X)-1

#Initial values
#The state vector
Xtt<-array(,c(timeperiods+1,2))
Xtt[1,1]<-X[1]
Xtt[1,2]<-Y[1]

#The error's covariance matrix
Ptt<-array(,c(timeperiods+1,2,2))
Ptt[1,1,1]<-0
Ptt[1,1,2]<-0
Ptt[1,2,1]<-0
Ptt[1,2,2]<-0

#The log likelihood component vector for the output product
ll<-vector()
#The mean squared error components
mse_comp<-vector()

predict_observe<-vector()

for (j in 1:timeperiods) {
#Prediction
X_pred<-Xtt[j,]
P_pred<-Ptt[j,,]
for (i in 1:steps) {

X1<-X_pred[1]
X2<-X_pred[2]

X_pred[1]<-X1+((a+alpha*(b1*X1+b2*X2)/N[j*steps+i])*(N[j*steps+i]-X1-X2))*dt
X_pred[2]<-X2+((1-alpha)*(max(X2,1)^epsilon)*((b1*X1+b2*X2)/N[j*steps+i])*(N[j*steps+i]-X1-X2))*dt

F11<-alpha*b1-a-2*alpha*(b1/N[j*steps+i])*X1-alpha*((b1+b2)/N[j*steps+i])*X2
F12<-alpha*b2-a-alpha*((b1+b2)/N[j*steps+i])*X1-2*alpha*(b2/N[j*steps+i])*X2
F21<-(1-alpha)*(max(X2,1)^epsilon)*(b1/N[j*steps+i])*(N[j*steps+i]-X1-X2)-(1-alpha)*(max(X2,1)^epsilon)*((b1*X1+b2*X2)/N[j*steps+i])
F22<-(1-alpha)*epsilon*(max(X2,1)^(epsilon-1))*((b1*X1+b2*X2)/N[j*steps+i])*(N[j*steps+i]-X1-X2)+(1-alpha)*(max(X2,1)^epsilon)*(b2/N[j*steps+i])*(N[j*steps+i]-X1-X2)-(1-alpha)*(max(X2,1)^epsilon)*((b1*X1+b2*X2)/N[j*steps+i])
F<-matrix(c(F11,F12,F21,F22),nrow=2,byrow=TRUE)

P_pred<-P_pred+(F%*%P_pred+P_pred%*%t(F)+Q*N[j*steps+i]*10^(-6))*dt

}

Xttminus<-X_pred
Pttminus<-P_pred

Ht<-c(1,0)

predict_observe[j+1]<-t(Ht)%*%Xttminus

#Update
Kt<-Pttminus%*%Ht%*%(t(Ht)%*%Pttminus%*%Ht+R)^(-1)
Xtt[j+1,]<-Xttminus+Kt%*%(X[j+1]-t(Ht)%*%Xttminus)
Ptt[j+1,,]<-(diag(2)-Kt%*%t(Ht))%*%Pttminus

#Log likelihood updating
LL<-LL+log((2*pi)^(-1/2)) + log((t(Ht)%*%Pttminus%*%Ht+R)^(-1/2)) + (-1/2)*(X[j+1]-t(Ht)%*%Xttminus)*(t(Ht)%*%Pttminus%*%Ht+R)^(-1)*(X[j+1]-t(Ht)%*%Xttminus)

ll[j]<-log((2*pi)^(-1/2)) + log((t(Ht)%*%Pttminus%*%Ht+R)^(-1/2)) + (-1/2)*(X[j+1]-t(Ht)%*%Xttminus)*(t(Ht)%*%Pttminus%*%Ht+R)^(-1)*(X[j+1]-t(Ht)%*%Xttminus)

mse_comp[j]<-(X[j+1]-t(Ht)%*%Xttminus)^2

}

actual_sales<<-X[3:(timeperiods+1)]-X[2:(timeperiods)]
predicted_sales<<-predict_observe[3:(timeperiods+1)]-X[2:(timeperiods)]

plot(1:(timeperiods-1),actual_sales,col="Black",type="l",xlab="Time",ylab="Sales",main="Black=actual, red=predicted")
lines(1:(timeperiods-1),predicted_sales,col="Red",type="l")

ll<<-ll

mse<<-sum(mse_comp)/timeperiods
predict_observe<<-predict_observe
mse_comp<<-mse_comp

LL<<-LL

LL
}


##############################################
#An optimisation starting from the Givon parameters
##############################################

a<-0.000200000
b1<-0.135310
b2<-0.1351100
alpha<-0.1438000
q11<-1000
epsilon<-0.00

start_params<-c(a,b1,b2,alpha,q11,epsilon)

trial_params<-c(((start_params[1]/0.02)/(1-(start_params[1]/0.02)))^0.5,(start_params[2]/(1-start_params[2]))^0.5,(start_params[3]/(1-start_params[3]))^0.5,(start_params[4]/(1-start_params[4]))^0.5,0.05,0)

estvals<-optim(trial_params,projectkalman,hessian=TRUE,control=list(trace=3,maxit=2000,fnscale=-1))

pr<-estvals$par

estpars<-c(0.02*pr[1]^2/(1+pr[1]^2),pr[2]^2/(1+pr[2]^2),pr[3]^2/(1+pr[3]^2),pr[4]^2/(1+pr[4]^2),pr[5]^2/(1+pr[5]^2),0.2*pr[6]/(1+abs(pr[6])))

esthess<-hessian(projectkalman_original_params,estpars)

#Alternative varcov estimates
##############################################
#A wrapper for returning the vector of ll
##############################################
ll_projectkalman_original_params<-function(xx) {
projectkalman_original_params(xx)
ll
}

##############################################
#The I_{OP} matrix
##############################################
Iop_projectkalman_original_params<-function(xx) {
jac<-jacobian(ll_projectkalman_original_params,xx)
Iop<-matrix(0,nrow=ncol(jac),ncol=ncol(jac))
for (iopi in 1:nrow(jac)) {
Iop<-Iop+jac[iopi,]%*%t(jac[iopi,])
}
Iop<-Iop/nrow(jac)
Iop
}

Iop<-Iop_projectkalman_original_params(estpars)
varop<-(1/length(X))*solve(Iop)

#Stdevs from the second derivative method
stdevs<-sqrt(diag(varop))
pvalues<-sapply(1:length(estpars),function(x) 2*(1-pnorm(abs(estpars[x]),0,stdevs[x])))
#The parameters and their standard deviations
print(rbind(estpars,stdevs,pvalues,mse,LL[1,1]))

