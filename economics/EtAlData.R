#
# EtAlData.R, 22 May 19
# Data from:
# Status, Quality and Attention: {What's} in a (Missing) Name?
# Timothy S. Simcoe and Dave M. Waguespack
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Standard_IETF discussion human social_status

source("ESEUR_config.r")


pal_col=rainbow(3)


fit_and_plot=function(df, col_str)
{
men=subset(df, freq < 150)
m_mod=glm(log(x) ~ log(freq), data=men)
pred=predict(m_mod, newdata=data.frame(freq=xbounds))
lines(xbounds, exp(pred), col=col_str)
}

# idfile,wgId,indId,date,date2,
# rfcDum,wglists,mentions,ttlVer,anyUnlist,
# etal_undoc,anyChair,treat_wgcd,rfcstock,authn,
# logpages,intl,multi,lndaysb4conf,threads,
# authemail,leadwgc,lwgcpos,ulwgcpos,lnameLength
#  1 "Filename = Unique ID"                         
#  2 "WG Submission dummy"                          
#  3 "Individual Submission dummy"                  
#  4 "Submission date"                              
#  5 "Next IETF Meeting date"                       
#  6 "Dummy: Published as RFC"                      
#  7 "Count of Listservs"                           
#  8 "Fractional count of messages mentioning ID"   
#  9 "Total nuber of ID revisions"                  
# 10 "Etal Dummy"                                   
# 11 "undocumented name truncation on announce"     
# 12 "WG Chair Author"                              
# 13 "Unlisted WG Chair"                            
# 14 "RFCs published by all ID authors"             
# 15 "Count of ID authors (header and footer)"      
# 16 "Log Pages"                                    
# 17 "Non-US authors"                               
# 18 "Dummy: Authors with > 1 affiliation"          
# 19 "Log Days-to-Meeting"                          
# 20 "total threads"                                
# 21 "Messages sent by ID authors"                  
# 22 "Dummy: First Author is WG Chair"              
# 23 "Position of LISTED WG Chair in author list"   
# 24 "Position of UNLISTED WG Chair in author list" 
# 25 "Digits in surname of author with longest name"

iet=read.csv(paste0(ESEUR_dir, "economics/EtAlData.csv.xz"), as.is=TRUE)
iet$sub_date=as.Date(iet$date, format="%d%b%Y")
iet$nmeet_date=as.Date(iet$date2, format="%d%b%Y")

iet_mod=glm(rfcDum ~ wgId+ttlVer+anyChair+log(1e-5+rfcstock)+lndaysb4conf+lwgcpos+ulwgcpos,
		data=iet, family=binomial)
summary(iet_mod)

# Select posts containing independent proposals (which have around
# 7% probability of being approved).
# Simple model with no interactions
ind_a_mod=glm(mentions ~ 
			anyChair+treat_wgcd+
			lndaysb4conf+threads+authemail,
				data=iet, subset=(indId == 1), family=gaussian)
summary(ind_a_mod)

# Fit a multiplicative model, the hard way.
# start values found by using family=poisson.
# It does not explain nearly as much deviance.
ind_m_mod=glm(mentions ~ 
			anyChair+treat_wgcd+
			             threads+authemail,
				data=iet, subset=(indId == 1),
				start=c("(Intercept)"=0.35,
					   "anyChair"=0.5, "treat_wgcd"=-0.8,
					   "threads"=0.06,
					   "authemail"=0.04),
				family=gaussian(link="log"))
summary(ind_m_mod)

# Something more complicated does not include treat_wgcs,
# but reduces deviance by 16%, and AIC by 3%
men_mod=glm(mentions ~ 
			threads+
			authemail+
			wglists:(threads+authemail)+
			ttlVer:(threads+authemail)+
			anyUnlist:(authn+threads)+
			rfcstock:authemail+
			intl:(threads+authemail)+
			multi:(threads+authemail)+
			lndaysb4conf:threads+
			threads:authemail,
				data=iet, subset=(indId == 1), family=gaussian)
summary(men_mod)

indId=subset(iet, indId == 1)
anon_wgc=subset(indId, treat_wgcd == 1)
wgc=subset(indId, (anyChair == 1) & (treat_wgcd == 0))
non_wgc=subset(indId, (anyChair == 0) & (treat_wgcd == 0))

xbounds=1:250

wgc_men=count(round(wgc$mentions))
plot(wgc_men$freq, wgc_men$x, log="xy", col=pal_col[1],
	ylim=c(1, 50),
	xlab="Proposals", ylab="Mentions\n")
fit_and_plot(wgc_men, pal_col[1])

non_men=count(round(non_wgc$mentions))
points(non_men$freq, non_men$x, col=pal_col[2])
fit_and_plot(non_men, pal_col[2])

anon_men=count(round(anon_wgc$mentions))
points(anon_men$freq, anon_men$x, col=pal_col[3])
fit_and_plot(anon_men[-1,], pal_col[3])

legend(x="topright", legend=c("With WG chair", "No WG chair", "As-is, with WG chair"), bty="n", fill=pal_col, cex=1.2)

