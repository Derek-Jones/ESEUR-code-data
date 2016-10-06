#
# patch-cph.R,  3 Oct 16
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

map_vendor=function(to_name, from_name)
{
ISR$vendor[ISR$vendor == from_name] <<- to_name
}


# vendor column close spellings
map_vendor("apple", "Apple Computer Inc.")
map_vendor("Apache", "Apache Software Foundation")
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
map_vendor("Washington University", "University of Washington")
map_vendor("yellow dog", "Yellow Dog Linux")

ISR$vendor=tolower(ISR$vendor)

# Date on which the NVD was sampled
end_date=as.Date("11-Aug-2003", format="%d-%b-%Y")

# patch is NA if no patch has been released yet
ISR$is_censored=is.na(ISR$patch)
ISR$patch[ISR$is_censored]=end_date

# Vendor may be notified, but before a patch is made available the
# vulnerability may be published
ISR$patch_days=as.numeric(ISR$patch-ISR$notify)
ISR$notify_days=as.numeric(ISR$publish-ISR$notify)
ISR$disc=as.numeric(ISR$patch > ISR$publish)

# ISR_0=subset(ISR, notify < publish)
ISR_np=subset(ISR, notify == publish)

# p_sfit_0=survfit(Surv(ISR_0$patch_days, !ISR_0$is_censored) ~ 1)
# plot(p_sfit_0, xlim=c(0, 600))
# p_sfit_1=survfit(Surv(ISR_1$patch_days, !ISR_1$is_censored) ~ 1)
# 
# lines(p_sfit_1, col="red")
# 
# mixed=as.numeric(ISR_np$patch > ISR_np$publish & ISR_np$notify < ISR_np$publish)

ISR_np$small_loge=(1-ISR_np$smallvendor)*ISR_np$logemployee

# plot(p_sfit_0, col="red", xlim=c(1, 600), ylim=c(-3, 2), fun="cloglog")
# lines(p_sfit_1, col="green")

# Based on the model described in the paper
p_mod=coxph(Surv(patch_days, !is_censored) ~ (log(cvss_score)+opensource+c_o+y2002+y2003+smallvendor+small_loge)^2, data=ISR_np)
t=stepAIC(p_mod)
summary(t)

# The model we end up with.
# High p-value variables commented out
min_p_mod=coxph(Surv(patch_days, !is_censored) ~ 
				log(cvss_score)
				+opensource
#				+c_o
#				+y2002
				+y2003
				+smallvendor
				+small_loge
#				+log(cvss_score):c_o
				+log(cvss_score):y2002
#				+c_o:y2002
				+y2002:smallvendor
				+y2003:smallvendor
				, data=ISR_np)
summary(min_p_mod)

t=cox.zph(min_p_mod)
summary(t)

# Code based on Introducing Survival and Event history analysis
# Melinda Mills
# page 150
# Check the Cox-Snell residuals
r=min_p_mod$residual
rr=(!ISR_np$is_censored)-r

fit=survfit(Surv(rr, !ISR_np$is_censored) ~ 1)
S=-log(fit$surv) # Mills omits -log()
T=fit$time

plot(T, S)
# Points should be on 45 degree line
lines(c(0, 3), c(0, 3), col="red")

# Use score residuals to look for outliers
# page 158
dfbeta=residuals(min_p_mod, type="dfbeta")

par(mfcol=c(4, 2))

d=sapply(1:ncol(dfbeta), function(X) 
			{
			plot(dfbeta[,X], type="n")
			text(dfbeta[,X])
			})

# Check functional form of residuals
# page 161
mgale=residuals(min_p_mod, type="martingale")

# One of the few variables that is continuous (sort of)
plot(log(ISR_np$cvss_score), mgale)
lines(loess.smooth(log(ISR_np$cvss_score), mgale, span=0.3), col="red")

min_fp_mod=coxph(Surv(patch_days, !is_censored) ~ 
				frailty(vendor)
				+log(cvss_score)
				+opensource
#				+c_o
#				+y2002
				+y2003
				+smallvendor
				+small_loge
#				+log(cvss_score):c_o
				+log(cvss_score):y2002
#				+c_o:y2002
				+y2002:smallvendor
				+y2003:smallvendor
				, data=ISR_np)
summary(min_fp_mod)

t=cox.zph(min_p_mod)
summary(t)


