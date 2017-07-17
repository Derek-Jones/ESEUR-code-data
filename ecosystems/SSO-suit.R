#
# SSO-suit.R, 16 Jul 17
# Data from:
# Standard Setting Committees: {Consensus} Governance for Shared Technology Platforms
# Timothy Simcoe
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(2)
hcl_col=rainbow_hcl(2)


obs_orig=read.csv(paste0(ESEUR_dir, "ecosystems/SSOCommittees.csv.xz"))

# A lot of the following code is adapted from Simcoe's original Stata code
# Exclude General & User Services Area WG's
# obs=subset(obs_orig, !(techarea == 0 | techarea == 2 | techarea == 9))
obs=subset(obs_orig, !(techarea == "none" | techarea == "gen" | techarea == "usv"))
# Drop BCP's, Historic RFCs, Draft Standards & Internet Standards
obs=subset(obs, !(rfctype == 1 | rfctype == 2 | rfctype == 7 | rfctype == 4))
# Keep IDs with Revisions >=1
obs=subset(obs, age>1)

# Main Sample: Working Group IDs with reliable Email Data
obs=subset(obs, !((!wgDum) | pubCohort < 1993 | pubCohort > 2003))

# Dummy for Robustness to Censoring of DV (Truncated at 5.5 Years)
cSample = (obs$pubCohort <= 2002 & obs$ttlDur <= 2007)

obs_sub=subset(obs, (strfc|nsrfc) & cSample==1)

# Dependent Variables
obs_sub$ttlDur = obs_sub$ttlDur+15
lnDur = log(obs_sub$ttlDur)

#* ID-Level Variables
# Taking Logs
obs_sub$lsize = log(1+obs_sub$filesize)
# size2 = obs_sub$lsize^2
# lKeys = log(1+obs_sub$rfcKeyCnt)
# anyKeys = (obs_sub$rfcKeyCnt>0)
# logEmails = log(1+obs_sub$idTtlMentions)

# Affiliation Dummies
orgDum = (obs_sub$n_org > 0)
eduDum = (obs_sub$n_edu > 0)
govDum = (obs_sub$n_gov > 0)
comNet = (obs_sub$n_com>0 | obs_sub$n_net>0)
obs_sub$othDum = pmax(eduDum, orgDum)
# nonUS = ((!obs_sub$usAuth) & obs_sub$forAuth)
# collab = (obs_sub$n_affil>1)
obs_sub$aut2 = (obs_sub$n_affil==2)
obs_sub$aut3 = (obs_sub$n_affil>2)

#* WG-Level Variables
obs_sub$lwgidnow = log(1+obs_sub$wgIdNow)
lwgidttl = log(1+obs_sub$wgIdCnt)
obs_sub$lwgipr = log(1+obs_sub$cumWgIpr)
lmsgs = log(1+obs_sub$ttlmsg1yr)
obs_sub$lcmsgs = log(1+obs_sub$cummsgs)
lwgorgs = log(1+obs_sub$cumWgOrg2)

#* RFC-Level Variables
ttlCites = obs_sub$patCites + obs_sub$pubCites + obs_sub$rfcCites
logPages = log(1+obs_sub$rfcPages)
logAllCites = log(1+obs_sub$ttlCites)
logPatCites = log(1+obs_sub$patCites)
logPubCites = log(1+obs_sub$pubCites)
logRfcCites = log(1+obs_sub$rfcCites)
logBackCites = log(1+obs_sub$backCites)
logStBackCites = log(1+obs_sub$stBackCites)
logNsBackCites = log(1+obs_sub$nsBackCites)

obs_sub$st_stbafl1yr=(1-obs_sub$nsrfc)*obs_sub$stbafl1yr
obs_sub$st_lwgipr=(1-obs_sub$nsrfc)*obs_sub$lwgipr
obs_sub$st_othDum=(1-obs_sub$nsrfc)*obs_sub$othDum
obs_sub$st_lsize=(1-obs_sub$nsrfc)*obs_sub$lsize
obs_sub$st_lcmsgs=(1-obs_sub$nsrfc)*obs_sub$lcmsgs
obs_sub$st_lwgidnow=(1-obs_sub$nsrfc)*obs_sub$lwgidnow
obs_sub$st_aut2=(1-obs_sub$nsrfc)*obs_sub$aut2
obs_sub$st_aut3=(1-obs_sub$nsrfc)*obs_sub$aut3

# twoway lpolyci ttlDur stbafl1yr if (exiType == 4 & ttlDur<2007 & stbafl1yr>=50), ciplot(rline)  alp(dash)  || lpolyci ttlDur stbafl1yr if (exiType == 3 & ttlDur<2007 & stbafl1yr>=50), ciplot(rline) alp(shortdash) lpat(dash) ytitle("Mean Total Days" " ") xtitle("Suit-share") legend(order(2 4) lab(2  " Standards") lab(4 "Non-standards")) caption("Kernel-weighted local polynomial with 95% CIs.")

non_std=subset(obs_sub, exiType == 3 & ttlDur<2007 & stbafl1yr>=50)
std=subset(obs_sub, exiType == 4 & ttlDur<2007 & stbafl1yr>=50)
plot(non_std$stbafl1yr, non_std$ttlDur, col=hcl_col[2],
	ylim=c(0, 1500),
	xlab="Suit-share", ylab="Production time (days)\n")
points(std$stbafl1yr, std$ttlDur, col=hcl_col[1])
lines(loess.smooth(non_std$stbafl1yr, non_std$ttlDur, span=0.3), col=pal_col[2])
lines(loess.smooth(std$stbafl1yr, std$ttlDur, span=0.3), col=pal_col[1])

legend(x="topleft", legend=c("Standard", "non-Standard"), bty="n", fill=pal_col, cex=1.2)

