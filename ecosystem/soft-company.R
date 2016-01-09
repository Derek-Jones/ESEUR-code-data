#
# soft-company.R, 23 May 15
#
# Data from:
#
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


ch=read.csv("/usr1/data-rbook/ukcompanydata/BasicCompanyData-2015-03-01-part1_5.zip", as.is=TRUE)

ch$IncorporationDate=as.Date(ch$IncorporationDate, format="%d/%m/%Y")
ch$DissolutionDate=as.Date(ch$DissolutionDate, format="%d/%m/%Y")

soft=subset(ch, grepl("*software*", SICCode.SicText_1))
comp=subset(ch, grepl("*computer*", SICCode.SicText_1))


