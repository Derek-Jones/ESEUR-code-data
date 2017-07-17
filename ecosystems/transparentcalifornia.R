#
# transparentcalifornia.R,  7 Apr 17
# Data from:
# http://transparentcalifornia.com/
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


read_sf=function(year)
{
sf=read.csv(paste0(ESEUR_dir, "ecosystems/transparentcalifornia.com/san-francisco-", year, ".csv.xz"), as.is=TRUE)

return(sf)
}

# Manually changed "Not Provided" to NA in csv files

sf_11=read_sf(2011)
sf_12=read_sf(2012)
sf_13=read_sf(2013)
sf_14=read_sf(2014)
sf_15=read_sf(2015)

# Add NA status for 2011-2013
sf_11$Status=NA
sf_12$Status=NA
sf_13$Status=NA


# Use 2015 column names
names(sf_11)=names(sf_15)
names(sf_12)=names(sf_15)
names(sf_13)=names(sf_15)
names(sf_14)=names(sf_15)

#rbind the data into one dataframe
sf_11_15=rbind(sf_11, sf_12, sf_13, sf_14, sf_15)

# Use of case is not consistent
sf_11_15$Job.Title=tolower(sf_11_15$Job.Title)

# Wow, some negative salaries...
summary(sf_11_15)

# No occurrences of softw in Job.Title
# 20 instance sof comput
progr=subset(sf_11_15, grepl("progr", Job.Title, ignore.case=TRUE))

summary(progr)


