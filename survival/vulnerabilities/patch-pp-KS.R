#
# patch-pp-KS.R,  4 Oct 16
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


pal_col=rainbow(3)

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
map_vendor("Apache", "Apache Software Foundation")
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
map_vendor("Washington University", "University of Washington")
map_vendor("yellow dog", "Yellow Dog Linux")

ISR$vendor=tolower(ISR$vendor)

# Date on which the NVD was sampled
end_date=as.Date("11-Aug-2003", format="%d-%b-%Y")

# patch is NA if no patch has been released yet
ISR$is_censored=is.na(ISR$patch)
ISR$patch[ISR$is_censored]=end_date

# Vendor may be privately notified, but before a patch is available the
# vulnerability may be disclosed.
ISR$patch_days=as.numeric(ISR$patch-ISR$notify)
ISR$notify_days=as.numeric(ISR$publish-ISR$notify)
ISR$disc=(ISR$patch > ISR$publish)

ISR_priv=subset(ISR, notify < publish)
ISR_priv_priv=subset(ISR_priv, !(patch > publish))
ISR_priv_disc=subset(ISR_priv, patch > publish)

ISR_disc=subset(ISR, notify == publish)

p_sfit_priv_priv=survfit(Surv(ISR_priv_priv$patch_days, !ISR_priv_priv$is_censored) ~ 1)
plot(p_sfit_priv_priv, xlim=c(0, 600), col=pal_col[1],
	xlab="Time to release patch", ylab="Survival rate\n")

p_sfit_priv_disc=survfit(Surv(ISR_priv_disc$patch_days, !ISR_priv_disc$is_censored) ~ 1)
lines(p_sfit_priv_disc, col=pal_col[2])

p_sfit_disc=survfit(Surv(ISR_disc$patch_days, !ISR_disc$is_censored) ~ 1)
lines(p_sfit_disc, col=pal_col[3])

legend(x="topright", legend=c("Private, patched and public", "Public then patched", "Private, public then patched"), bty="n", fill=pal_col, cex=1.2)

# mixed=as.numeric(ISR$patch > ISR$publish & ISR$notify < ISR$publish)

