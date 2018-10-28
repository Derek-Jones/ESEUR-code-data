#
# icsme2015era.R, 21 Oct 18
# Data from:
# Towards a Survival Analysis of Database Framework Usage in {Java} Projects
# Mathieu Goeminne and Tom Mens
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG database-framework Java evolution

source("ESEUR_config.r")


library("msm")
library("plyr")


db_day_range=function(db_start, db_end)
{
# Array containing a 1 on each day the database is in use
days=rep(0, max_date-min_date+1)
if (anyNA(c(db_start, db_end)))
   return(days)
# print(c(db_start, db_end, min_date, max_date))
# print(c(db_start-min_date+1,(db_start-min_date+1)+(db_end-db_start)))
days[(db_start-min_date+1):((db_start-min_date+1)+(db_end-db_start))]=1

return(days)
}


# Count number of databases in use over some interval, for one project
cnt_db=function(df)
{
# cur_df<<-df
min_date<<-min(df$min.JDBC, df$min.Spring,
			df$min.Hibernate, df$min.JPA, na.rm=TRUE)
max_date<<-max(df$max.zombie.JDBC, df$max.zombie.Spring,
			df$max.zombie.Hibernate, df$max.zombie.JPA, na.rm=TRUE)

# Number of rows is number of days over which measurements exist
# A 1 in a row/column indicates that database in use on a given day.
# Data is left censored, because projects are up and running when
# measuring starts.
db_use=data.frame(JDBC=db_day_range(df$min.JDBC, df$max.zombie.JDBC),
		  Spring=db_day_range(df$min.Spring, df$max.zombie.Spring),
		  Hibernate=db_day_range(df$min.Hibernate, df$max.zombie.Hibernate),
		  JPA=db_day_range(df$min.JPA, df$max.zombie.JPA))

day_cnt=rowSums(db_use)
t=rle(day_cnt)

# Start in some state at time 0,
# Finish in the last state at cumulative measurement interval
return(data.frame(date=cumsum(c(0, t$length)),
		  dbs=c(t$values, tail(t$values, 1))))
}


dbinf=read.csv(paste0(ESEUR_dir, "survival/icsme2015era.csv.xz"), as.is=TRUE)

# Need to convert lots of dates
cnames=colnames(dbinf)[-1] # Not the first column
t=sapply(cnames, function(X) dbinf[, X]<<-as.Date(dbinf[, X], format="%Y-%m-%d"))

# y1997=as.Date("1997-01-01", format="%Y-%m-%d")
# which(dbinf$min.JDBC < y1997)
# which(dbinf$min.Spring < y1997)
# which(dbinf$min.Hibernate < y1997)
# which(dbinf$min.JPA < y1997)
# 
# min(dbinf$min.JDBC, dbinf$min.Spring,
# 		dbinf$min.Hibernate, dbinf$min.JPA, na.rm=TRUE)
# max(dbinf$max.zombie.JDBC, dbinf$max.zombie.Spring,
#               dbinf$max.zombie.Hibernate, dbinf$max.zombie.JPA, na.rm=TRUE)

uses=ddply(dbinf, .(X), cnt_db)

# There are entries with dbs == 0, which is probably a fault
# in data collection/processing.
zero_db=which(uses$dbs == 0)
X_zero=unique(uses$X[zero_db])
uses=subset(uses, !(X %in% X_zero))

# The maximum number of databases that can be used is four,
# Assign some starting value for the transition.
Q=matrix(nrow=4, ncol=4,
		c(0,   0.1, 0.1, 0.01,
		  0.1, 0,   0.1, 0.01,
		  0.1, 0.1, 0,   0.1,
		  0.1, 0.1, 0.1, 0))

# Q_crude = crudeinits.msm(dbs ~ date, X, data=uses, qmatrix=Q)
# statetable.msm(dbs, X, data=uses)

db_msm = msm(dbs ~ date, subject=X, data=uses,
			 qmatrix=Q, gen.inits=TRUE, exacttimes=TRUE)

print(pmatrix.msm(db_msm, t=365), digits=2)

sojourn.msm(db_msm)

