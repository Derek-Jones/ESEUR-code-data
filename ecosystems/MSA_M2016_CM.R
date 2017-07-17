#
# MSA_M2016_CM.R,  7 Jul 17
# Data from:
# Occupational Employment Statistics (OES) Survey, May 2016
# www.bls.gov/oes,
# 
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

# Good luck getting these installed on standalone systems
library(choroplethr)
library(choroplethrMaps)



Not all fields are available for every set of estimates files,
,
Field,Field Description
prim_state,Primary state for the MSA (only on MSA and nonmetropolitan files)
area,"MSA, metropolitan division, or state FIPS code, or OES-specific nonmetropolitan area code "
st,State abbreviation (only on the state file)
state,State name (only on the state file)
area_name,Area name (only on metropolitan and nonmetropolitan area files)
naics,North American Industry Classification System (NAICS) code for the given industry (only on the national industry files)
naics_title,North American Industry Classification System (NAICS) title for the given industry (only on the national industry files)
ownership,"Ownership type (only on the industry and ownership level files). Files without an ownership field will always represent private, federal, state, and local government ownerships combined."
occ_code,The 6-digit Standard Occupational Classification (SOC) code or OES-specific code for the occupation 
occ_title,Standard Occupational Classification title or OES-specific title for the occupation
occ_group,"Shows the SOC occupation level: ""total""=total of all occupations; ""major""=SOC major group; ""minor""=SOC minor group; ""broad""=SOC broad occupation; ""detailed""=SOC detailed occupation"
tot_emp,Estimated total employment rounded to the nearest 10 (excludes self-employed)
emp_prse,"Percent relative standard error (RSE) for the employment. Relative standard error is a measure of the reliability of a statistic; the smaller the relative standard error, the more precise the estimate."
pct_total ,Percent of industry employment in the given occupation (only on the national industry files). Percents may not total to 100 due to occupational data not published separately.
pct_rpt,Percent of establishments reporting the given occupation in the given industry (only on the national industry files)
jobs_1000,"The number of jobs (employment) in the given occupation per 1,000 jobs in the given area (only on the statewide, metropolitan, and nonmetropolitan area files)"
loc_quotient,"The location quotient represents the ratio of an occupation’s share of employment in a given area to that occupation’s share of employment in the U.S. as a whole. For example, an occupation that makes up 10 percent of employment in a specific metropolitan area compared with 2 percent of U.S. employment would have a location quotient of 5 for the area in question. (Only on the state, metropolitan, and nonmetropolitan statistical area files.)"
h_mean,Mean hourly wage
a_mean,Mean annual wage 
mean_prse ,"Percent relative standard error (RSE) for the mean wage. Relative standard error is a measure of the reliability of a statistic; the smaller the relative standard error, the more precise the estimate."
h_pct10,Hourly 10th percentile wage
h_pct25,Hourly 25th percentile wage
h_median,Hourly median wage (or the 50th percentile)
h_pct75,Hourly 75th percentile wage
h_pct90,Hourly 90th percentile wage
a_pct10,Annual 10th percentile wage
a_pct25,Annual 25th percentile wage
a_median,Annual median wage (or the 50th percentile)
a_pct75,Annual 75th percentile wage
a_pct90,Annual 90th percentile wage
annual,"Contains ""TRUE"" if only the annual wages are released. The OES program releases only annual wages for some occupations that typically work fewer than 2,080 hours per year but are paid on an annual basis, such as teachers, pilots, and athletes."
hourly,"Contains ""TRUE"" if only the hourly wages are released. Some occupations, such as actors, dancers, and musicians and singers, are paid hourly and generally don't work a standard 2,080 hour work year. "
,
Notes:,
*  = indicates that a wage estimate is not available,
**  = indicates that an employment estimate is not available,
"# = indicates a wage that is equal to or greater than $100.00 per hour or $208,000 per year",
~ =indicates that the percent of establishments reporting the occupation is less than 0.5%,
# extracted Computer and Mathematical Occupations from full list
# comp_math=subset(all_occ, grepl("^15-", OCC_CODE))
comp_math=read.csv(paste0(ESEUR_dir, "ecosystems/MSA_M2016_CM.csv.xz"), as.is=TRUE)


comp_math=comp_math[order(comp_math$AREA), ]

soft_dev=subset(comp_math, OCC_TITLE == "Software Developers, Applications")

dev_county=data.frame(region=as.numeric(soft_dev$AREA),
                         value=as.numeric(soft_dev$EMP_PRSE))
dev_county=subset(dev_county, !is.na(value))

# plot(as.numeric(comp_prog$EMP_PRSE))

# Does not work because AREA includes values other than FIPS codes
county_choropleth(dev_county)

