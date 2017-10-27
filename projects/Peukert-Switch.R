#
# Peukert-Switch.R, 20 Oct 17
# Data from:
# Christian Peukert
# Switching Costs and Information Technology: {The} Case of {IT} Outsourcing
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")
library("survival")


rle_it_sup=function(df)
{
sup=rle(df$acct_893)
t=data.frame(lifetime=rle(df$acct_893)$lengths)
t$alive=0
t$alive[nrow(t)]=1
return(t)
}


# Reduced size of original dataset
# ncua$join_number=NULL
# ncua$city=NULL
# ncua$state=NULL
# ncua$state_code=NULL
# ncua$zip_code=NULL
# ncua$county_code=NULL
# ncua$year_opened=NULL
# ncua$tom_code=NULL
# ncua$acct_076=NULL
# ncua$ceo=NULL
# ncua$audit=NULL
# ncua[, grepl("^cty_", names(ncua))]=NULL
# ncua[, grepl("^acct_88", names(ncua))]=NULL
# ncua[, grepl("^acct_87", names(ncua))]=NULL


# For details of column names see:
# NATIONAL CREDIT UNION ADMINISTRATION Call report form
ncua=read.csv(paste0(ESEUR_dir, "projects/Peukert-Switch.csv.xz"), as.is=TRUE)

# Removed most columns to save space
# it_sup=tolower(ncua$acct_893)

# # Try and reduce the variation in supplier name.
# it_sup=sub("^www\\.", "", it_sup)
# it_sup=sub("\\.com$", "", it_sup)
# it_sup=sub("\\.net$", "", it_sup)
# it_sup=sub(" inc$", "", it_sup)
# it_sup=sub(" inc\\.$", "", it_sup)
# it_sup=gsub(" +", "", it_sup)
# it_sup=gsub("[/'-.,]", "", it_sup)
# it_sup=sub("\\&co$", "", it_sup)
# it_sup=sub("\\&company$", "", it_sup)
# it_sup=sub("s$", "", it_sup) # remove plurals

# table(tolower(it_sup))
# length(table(tolower(it_sup)))
# table(ncua$acct_892a)

# 
# ncua$acct_893=it_sup

# Only CU's with transactional websites have 'major' IT outsourced
# transactional=subset(ncua, acct_892a == 3)

transactional=ncua

s_trans=ddply(transactional, .(cu_name), rle_it_sup)

plot(survfit(Surv(s_trans$lifetime, s_trans$alive == 1) ~ 1), col=point_col,
	xlim=c(0, 7),
	xlab="Years", ylab="Supplier survival\n")


