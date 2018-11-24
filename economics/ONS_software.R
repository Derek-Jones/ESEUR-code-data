#
# ONS_software.R, 18 Nov 18
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
# TAG software-UK hardware-UK software-purchase software-cost hardware-purchase

source("ESEUR_config.r")


pal_col=rainbow(3)


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

plot(ONS$Date, ONS$Total_pur/1000, col=pal_col[1],
	xlab="Year (quarterly)", ylab="Billion (£)\n")
points(ONS$Date, ONS$Total_own/1000, col=pal_col[2])
points(ONS$Date, ONS$Total_hard/1000, col=pal_col[3])

legend(x="topleft", legend=c("Purchased software", "Own software", "Hardware"), bty="n", fill=pal_col, cex=1.2)


# plot(stl(ts(ONS$Total_pur, frequency=4), s.window="periodic"))

# ccf(diff(ONS$Total_pur), diff(ONS$Total_own))

