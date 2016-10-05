#
# patch-timedep.R,  3 Oct 16
#
# Data from:
# An empirical analysis of software vendors' patch release behavior: Impact of vulnerability disclosure
# Ashish Arora and Ramayya Krishnan and Rahul Telang and Yubao Yang
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("MASS")
library("survival")


ISR=read.csv(paste0(ESEUR_dir, "survival/vulnerabilities/patching_published-ISR.csv.xz"), as.is=TRUE)

ISR$cert_pub=as.Date(ISR$cert_pub, format="%Y-%m-%d")
ISR$other_pub=as.Date(ISR$other_pub, format="%Y-%m-%d")
ISR$notify=as.Date(ISR$notify, format="%Y-%m-%d")
ISR$patch=as.Date(ISR$patch, format="%Y-%m-%d")
ISR$publish=as.Date(ISR$publish, format="%Y-%m-%d")

# These reports are mixed private+disclosed
split_report=function(df)
{
# Start as private notification
priv_line=df
priv_line$is_censored=0
priv_line$priv_di=1
# End when published before patch available
priv_line$end=priv_line$publish

disc_line=df
disc_line$priv_di=0
# Start as public notification, End when it ends
disc_line$start=priv_line$publish

return(rbind(priv_line, disc_line))
}


map_vendor=function(to_name, from_name)
{
ISR$vendor[ISR$vendor == from_name] <<- to_name
}


# vendor column close spellings
map_vendor("apple", "Apple Computer Inc.")
map_vendor("BEA", "BEA Systems Inc.")
map_vendor("BSCW", "BSCW.gmd")
map_vendor("Cisco", "Cisco Systems Inc.")
map_vendor("Conectiva", "Conectiva Linux")
# debian Debian
map_vendor("EFTP", "EFTP Development Team")
map_vendor("gentoo", "Gentoo Linux")
map_vendor("GNU glibc", "GNU Libgcrypt")
map_vendor("Hitachi", "Hitachi Data Systems")
# hp HP
map_vendor("HP", "Hewlett-Packard Company")
# ibm IBM
# immunix Immunix
# iPlanet IPlanet
map_vendor("Ipswitch", "Ipswitch Inc.")
map_vendor("Lotus", "Lotus Software")
map_vendor("Macromedia", "Macromedia Inc.")
map_vendor("mandrakesoft", "MandrakeSoft")
map_vendor("Microsoft", "Microsoft Corporation")
# mod_ssl Mod_ssl
map_vendor("Nbase", "Nbase-Xyplex")
map_vendor("Nbase", "NBase-Xyplex")
# netbsd NetBSD NETBSD
# netscreen NetScreen
# openbsd OpenBSD
map_vendor("openpkg", "Openpgk")
map_vendor("openpkg", "The OpenPKG Project")
map_vendor("Oracle", "Oracle Corporation")
map_vendor("Redhat", "Red Hat Inc.")
map_vendor("SCO", "The SCO Group")
map_vendor("sco", "The SCO Group (SCO Linux)")
map_vendor("sco", "The SCO Group (SCO UnixWare)")
map_vendor("sendmail", "Sendmail Inc.")
map_vendor("sendmail", "The Sendmail Consortium")
# sgi SGI
# slackware Slackware
map_vendor("Sun", "Sun Microsystems Inc.")
map_vendor("suse", "SuSE Inc.")
map_vendor("Symantec", "Symantec Corporation")
map_vendor("trustix", "Trusix")
map_vendor("trustix", "Trustix Secure Linux")
# turbolinux Turbolinux TurboLinux")
map_vendor("yellow dog", "Yellow Dog Linux")

ISR$vendor=tolower(ISR$vendor)

# Date on which the NVD was sampled
end_date=as.Date("11-Aug-2003", format="%d-%b-%Y")

# patch is NA if no patch has been released yet
ISR$is_censored=is.na(ISR$patch)
ISR$patch[ISR$is_censored]=end_date

ISR$small_loge=(1-ISR$smallvendor)*ISR$logemployee

# Vendor may be notified, but before a patch is made available the
# vulnerability may be published
ISR$priv_di=0
ISR$ID=1:nrow(ISR)
ISR$start=ISR$notify
ISR$end=ISR$patch

ISR_priv=subset(ISR, notify < publish)
all_priv=subset(ISR_priv, patch <= publish) # <= as a catch all
all_priv$priv_di=1
priv_disc=split_report(subset(ISR_priv, patch > publish))

ISR_disc=subset(ISR, notify == publish)

ISR_split=rbind(all_priv, priv_disc, ISR_disc)

ISR_split$patch_days=as.numeric(ISR_split$end-ISR_split$start)
# 
# p_sfit_priv=survfit(Surv(ISR_priv$patch_days, !ISR_priv$is_censored) ~ 1)
# plot(p_sfit_priv, xlim=c(0, 600))
# p_sfit_1=survfit(Surv(ISR_1$patch_days, !ISR_1$is_censored) ~ 1)
# 


# plot(p_sfit_priv, col="red", xlim=c(1, 600), ylim=c(-3, 2), fun="cloglog")
# lines(p_sfit_1, col="green")

# # Based on the model described in the paper
# p_mod=coxph(Surv(patch_days, !is_censored) ~
# 				(log(cvss_score)+opensource+c_o
# 				+y2002+y2003
# 				+smallvendor+small_loge)^2
# 				, data=ISR_split)
# t=stepAIC(p_mod)
# summary(t)

# # Time dependent model
# pt_mod=coxph(Surv(patch_days, !is_censored) ~
# 				cluster(ID)
# 				+(priv_di
# 				+log(cvss_score)+opensource+c_o
# 				+y2002+y2003
# 				+smallvendor+small_loge)^2
# 				, data=ISR_split)
# t=stepAIC(pt_mod)
# summary(t)

# The model we end up with.
# The model we end up with.
# High p-value variables removed
min_p_mod=coxph(Surv(patch_days, !is_censored) ~ 
				cluster(ID)
				+priv_di*(
				  log(cvss_score)
				  +y2003
				  +log(cvss_score):y2002)
				+opensource
				+y2003
				+smallvendor
				+log(cvss_score):y2002
				, data=ISR_split)
print(summary(min_p_mod))

# exp(0.912-(0.34*c(0.8, 1.8,2.3)))

# # Test the assumptions made by Cox modeling
# t=cox.zph(min_p_mod)
# print(t)

# # Code based on Introducing Survival and Event history analysis
# # Melinda Mills
# page 150
# Check the Cox-Snell residuals
# r=min_p_mod$residual
# rr=(!ISR_split$is_censored)-r
# 
# fit=survfit(Surv(rr, !ISR_split$is_censored) ~ 1)
# S=-log(fit$surv) # Mills omits -log()
# T=fit$time

# plot(T, S)
# # Points should be on 45 degree line
# lines(c(0, 3), c(0, 3), col="red")

# # Use score residuals to look for outliers
# # page 158
# dfbeta=residuals(min_p_mod, type="dfbeta")

# par(mfcol=c(4, 2))

# d=sapply(1:ncol(dfbeta), function(X) 
# 			{
# 			plot(dfbeta[,X], type="n")
# 			text(dfbeta[,X])
# 			})

# # Check functional form of residuals
# # page 161
# mgale=residuals(min_p_mod, type="martingale")

# # One of the few variables that is continuous (sort of)
# plot(log(ISR_split$cvss_score), mgale)
# lines(loess.smooth(log(ISR_split$cvss_score), mgale, span=0.3), col="red")


