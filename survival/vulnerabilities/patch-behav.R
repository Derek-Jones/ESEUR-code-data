#
# patch-behav.R, 26 Sep 13
#
# Data from:
# An empirical analysis of software vendors' patch release behavior: Impact of vulnerability disclosure
# Ashish Arora and Ramayya Krishnan and Rahul Telang and Yubao Yang
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

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

ISR$patch_days=as.numeric(ISR$patch-ISR$notify)
ISR$disc=as.numeric(ISR$patch <= ISR$publish)
ISR$small_loge=(1-ISR$smallvendor)*ISR$logemployee

ISR_0=subset(ISR, disc == 0)
ISR_1=subset(ISR, disc == 1)

p_sfit_0=survfit(Surv(ISR_0$patch_days, !is.na(ISR_0$patch)) ~ 1)
plot(p_sfit_0, xlim=c(0, 600))
p_sfit_1=survfit(Surv(ISR_1$patch_days, !is.na(ISR_1$patch)) ~ 1)

points(p_sfit_1, col="red")


plot(p_sfit_0, col="red", xlim=c(1, 600), ylim=c(-3, 2), fun="cloglog")
par(new=TRUE)
plot(p_sfit_1, col="green", xlim=c(1, 600), ylim=c(-3, 2), fun="cloglog")

p_mod=coxph(Surv(ISR$patch_days, !is.na(ISR$patch)) ~ disc+log(cvss_score)+opensource+c_o+y2002+y2003+smallvendor+small_loge, data=ISR)

p_mod=coxph(Surv(ISR$patch_days, !is.na(ISR$patch)) ~ disc+log(cvss_score)+opensource+dis_by_c+dis_by_s+dis_by_o+y2002+y2003+os+s_app, data=ISR)

p_mod=coxph(Surv(ISR$patch_days, !is.na(ISR$patch)) ~ disc+log(cvss_score)+opensource+dis_by_c+dis_by_s+dis_by_o+y2002+y2003++os+s_app+frailty(vendor), data=ISR)

p_mod=survreg(Surv(ISR$patch_days, !is.na(ISR$patch)) ~ disc+log(cvss_score)+opensource+dis_by_c+dis_by_s+dis_by_o+y2002+y2003+os+s_app, data=ISR, dist="weibull")

p_mod=survreg(Surv(ISR$patch_days, !is.na(ISR$patch)) ~ disc+log(cvss_score)+opensource+dis_by_c+dis_by_s+dis_by_o+y2002+y2003+os+s_app+frailty(vendor), data=ISR, dist="weibull")


library("rms")


p_mod=cph(Surv(ISR$patch_days, !is.na(ISR$patch)) ~ disc+log(cvss_score)+opensource+dis_by_c+dis_by_s+dis_by_o+y2002+y2003+os+s_app+frailty(vendor), data=ISR)

# summary generates the error:
#  adjustment values not defined here or with datadist for disc cvss_score opensource dis_by_c dis_by_s dis_by_o y2002 y2003 os s_app vendor

p_mod$coefficients

