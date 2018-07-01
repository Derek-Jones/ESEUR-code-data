#
# wcre2012-delaystudy.R, 19 Mar 18
#
# Data from:
# An empirical study of factors impacting bug fixing time
# Feng Zhang and Foutse Khomh and Ying Zou and Ahmed E. Hassan
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("penalized")
library("rpart")


# bugId,priority,severity,status,resolution,os,hardware,cc,reportDate,reporter,modifiedDate,lastDate,firstResponser,firstResponseTime,assignee,assignedTime,fixer,fixTime,lenTITLE,lenDESC,nCOMM,avg_LENCOMM,max_LENCOMM,min_LENCOMM,nbFiles,codeChurn_avg,codeChurn_sum,codeChurn_max,loc_avg,loc_sum,loc_max,vg_avg,vg_sum,vg_max,nom_avg,nom_sum,nom_max,wmc_avg,wmc_sum,wmc_max,isReporterAssignee,isReporterAuthor,isAssigneeCCed,isAuthorCCed,fixingStartTime,fixingEndTime,numberAuthors,authors,delayFromReport,delayFromResponse,delayOfResponse,delayBeforeChange,delayAfterChange,nbMacroChangeTypes,sumMacroChangeTypes,nbMicroChangeTypes,sumMicroChangeTypes,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,f19,f20,f21,f22,f23,f24,f25,f26,f27,f28,f29,f30,f31,f32,f33,f34,f35,f36,f37,f38,f39,f40,f41,f42,f43,f44,f45,f46,f47,f48,f49,f50,f51,f52,f53,f54,f55,f56,f57,f58,f59,f60,f61,f62,f63,f64,f65,f66,f67,f68,f69,f70,f71,f72,f73,f74,f75,f76,f77,f78,f79,f80,f81,f82,f83,f84,f85,f86,f87,f88,f89,f90,f91,f92,f93,f94,f95,f96,f97,f98,f99,f100,f101,f102,f103,f104,f105,f106,f107,f108,f109,f110,f111,f112,f113,f114,f115,f116,f117,f118,f119,f120,f121,f122,f123,f124,f125,f126,f127,f128,f129,f130,f131,f132,f133,f134,f135,f136,f137,f138,f139,f140,f141,f142,f143,f144,f145,f146,f147,f148,f149,f150,f151,f152,f153,f154,f155,f156,f157,f158,f159,f160,f161,f162,hourOfDayReport,dayOfWeekReport,monthOfYearReport,hourOfDayAssign,dayOfWeekAssign,monthOfYearAssign,hourOfDayStartFix,dayOfWeekStartFix,monthOfYearStartFix

# severity,status,resolution,os,hardware,reportDate,modifiedDate,lastDate,firstResponseTime,assignedTime,fixTime,fixingStartTime,fixingEndTime,delayFromReport,delayFromResponse,delayOfResponse,delayBeforeChange,delayAfterChange,hourOfDayReport,dayOfWeekReport,monthOfYearReport,hourOfDayAssign,dayOfWeekAssign,monthOfYearAssign,hourOfDayStartFix,dayOfWeekStartFix,monthOfYearStartFix

# delayFromReport,delayFromResponse,delayOfResponse,delayBeforeChange,delayAfterChange,hourOfDayReport,dayOfWeekReport,monthOfYearReport,hourOfDayAssign,dayOfWeekAssign,monthOfYearAssign,hourOfDayStartFix,dayOfWeekStartFix,monthOfYearStartFix


buglist=read.csv(paste0(ESEUR_dir, "odds-and-ends/wcre2012-delaystudy.csv.xz"), as.is=TRUE)

# delayOf... strongly correlated with each other because they
# are all essential measuring when a work starts of a fault.
delays=subset(buglist, select=grepl("delay.", names(buglist)))
delays=subset(delays, (delayFromReport > 0) &
			(delayFromResponse > 0) &
			(delayOfResponse > 0) &
			(delayBeforeChange > 0) &
			(delayAfterChange > 0))

pairs(delays, col=point_col)

ldelays=log(delays)
pairs(ldelays, col=point_col)

l_moda=glm(delayBeforeChange ~ .-delayAfterChange, data=delays)
summary(l_moda, correlation=TRUE)

l_modb=update(l_moda, .~. -delayOfResponse)
summary(l_modb)

pen_mod=penalized(delayBeforeChange ~ .-delayAfterChange,
			data=delays,
			steps=50,
			lambda1=1.0)
plotpath(pen_mod)
coefficients(pen_mod)


# l_modc=update(l_modb, .~. -delayFromReport)
# summary(l_modc)

# plot(log(delays$delayBeforeChange-delays$delayOfResponse))

delays=subset(buglist, (delayAfterChange > 0))

pairs( ~ log(delayAfterChange)+hourOfDayStartFix+dayOfWeekStartFix, data=delays)

delays=subset(buglist, (fixTime > 0))
dt_mod=rpart(delayAfterChange ~ ., data=delays)

