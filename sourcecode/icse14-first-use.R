#
# icse14-first-use.R, 15 Jun 18
# Data from:
# Mining Billions of {AST} Nodes to Study Actual and Potential Usage of {Java} Language Features
# Robert Dyer and Hridesh Rajan and Hoan Anh Nguyen and Tien N. Nguyen
#
# SourceForge registered user data extracted from:
# A Study of {SourceForge} Users and User Network
# Liguo Yu and Srini Ramaswamy
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")


cum_feature_use=function(df)
{
user_sum=ddply(df, .(date), function(df) return(nrow(df)))

user_sum$cumsum=cumsum(user_sum$V1)

# The model fits very well, so lets extend the adjustment a year earlier.
# Makes it easier to see that there are multiple origin dates for the lines.
user_sum=subset(user_sum, date >= jan_04)

# Adjust for the increase in registered users over time
norm_factor=exp(sfu_coef[1]+sfu_coef[2]*as.numeric(user_sum$date-jan_04))/sfu$users[1]

lines(user_sum$date, user_sum$cumsum/norm_factor, col=df$col_str)
}


# Sourceforge registered user data from February 2005 to June 2012. 
sfu=read.csv(paste0(ESEUR_dir, "sourcecode/7392-32627-1-PB.csv.xz"), as.is=TRUE)

jan_04=as.Date("2004-01-01")
feb_05=as.Date("2005-02-01")
jun_12=as.Date("2012-06-01")
total_days=as.numeric(jun_12-feb_05)

sfu$days=sfu$date*total_days

sfu_mod=glm(log(users) ~ days, data=sfu)
#summary(sfu_mod)
sfu_coef=coef(sfu_mod)


uc=read.csv(paste0(ESEUR_dir, "sourcecode/icse14-first-use.csv.xz"), as.is=TRUE)

uc$date=as.Date(uc$date, format="%Y-%m-%d")
uc=subset(uc, date <= jun_12)

features=unique(uc$feature)

pal_col=rainbow(length(features))
uc$col_str=mapvalues(uc$feature, features, pal_col)


plot(uc$date[1], 1, type="n", log="y",
	xlim=c(jan_04, jun_12), ylim=c(1, 1e4),
	yaxs="i",
	xlab="Date", ylab="Cumulative users of feature\n")

d_ply(uc, .(feature), cum_feature_use)

legend(x="bottom", legend=features, bty="n", fill=pal_col, cex=1.2)

