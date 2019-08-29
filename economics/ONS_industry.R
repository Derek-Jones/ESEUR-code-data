#
# ONS_industry.R, 29 Aug 19
# Data from:
#
# http://www.ons.gov.uk/ons/rel/bus-invest/business-investment/index.html
# Office for National Statistics, Government Buildings
# Email: gcf@ons.gsi.gov.uk
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG software-UK software-own software-cost industry-software

source("ESEUR_config.r")


# Plot annual total so plot contains less visible clutter
annual_total=function(X)
{
X_col=soft_own[, X]
year_sum=sapply(0:(length(year_range)-1), function(X) sum(X_col[X*4+1:4]))

lines(year_range, year_sum, col=pal_col[X])
}

# The estimates in this spreadsheet are gross fixed capital formation (GFCF)
# estimates for computer software purchases, own account computer software,
# mineral exploration, research and development and artistic originals by
# industry, consistent with the Business Investment Q2 2017 provisional release.
# The estimates are current price, not seasonally adjusted.

# Industry codes, for break-down numbers, are:
# A,"AGRICULTURE, FORESTRY AND FISHING"
# B,MINING AND QUARRYING
# C,MANUFACTURING
# D,"ELECTRICITY, GAS, STEAM AND AIR CONDITIONING SUPPLY"
# E,"WATER SUPPLY; SEWERAGE, WASTE MANAGEMENT AND REMEDIATION ACTIVITIES"
# F,CONSTRUCTION
# G,WHOLESALE AND RETAIL TRADE; REPAIR OF MOTOR VEHICLES AND MOTORCYCLES
# H,TRANSPORTATION AND STORAGE
# I,ACCOMMODATION AND FOOD SERVICE ACTIVITIES
# J,INFORMATION AND COMMUNICATION
# K,FINANCIAL AND INSURANCE ACTIVITIES
# L,REAL ESTATE ACTIVITIES
# M,"PROFESSIONAL, SCIENTIFIC AND TECHNICAL ACTIVITIES"
# N,ADMINISTRATIVE AND SUPPORT SERVICE ACTIVITIES
# O,PUBLIC ADMINISTRATION AND DEFENCE; COMPULSORY SOCIAL SECURITY
# P,EDUCATION
# Q,HUMAN HEALTH AND SOCIAL WORK ACTIVITIES
# R,"ARTS, ENTERTAINMENT AND RECREATION"
# S,OTHER SERVICE ACTIVITIES
# T,ACTIVITIES OF HOUSEHOLDS AS EMPLOYERS; UNDIFFERENTIATED GOODS-AND SERVICES-PRODUCING ACTIVITIES OF HOUSEHOLDS FOR OWN USE
# U,ACTIVITIES OF EXTRATERRITORIAL ORGANISATIONS AND BODIES

ONS=read.csv(paste0(ESEUR_dir, "economics/ONS_software.csv.xz"), as.is=TRUE)

# Map quarters to dates
ONS$Date=sub("Q1", " 3 31", ONS$Date)
ONS$Date=sub("Q2", " 6 30", ONS$Date)
ONS$Date=sub("Q3", " 9 30", ONS$Date)
ONS$Date=sub("Q4", " 12 31", ONS$Date)

ONS$Date=as.Date(ONS$Date, format="%Y %m %d")

soft_own=subset(ONS, select=grepl("_own", colnames(ONS)))
soft_own$Total_own=NULL
# Make sure the last year contains four rows
soft_own=rbind(soft_own, rep(0, ncol(soft_own)))

pal_col=rainbow(ncol(soft_own))

year_range=1997:2017

plot(1, type="n", log="y",
	xlim=range(year_range), ylim=c(4, max(soft_own, na.rm=TRUE)*3.5),
	xlab="Year", ylab="Software spend (£million)\n")

dummy=sapply(1:ncol(soft_own), annual_total)


# plot(stl(ts(ONS$Total_own, frequency=4), s.window="periodic"))

# ccf(diff(ONS$Total_pur), diff(ONS$Total_own))

