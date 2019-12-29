#
# udd-insts-bugs.R, 25 Dec 19
#
# From an idea published in:
# Impact of Installation Counts on Perceived Quality: A Case Study of Debian
# Israel Herraiz and Emad Shihab and Thanh H. D. Nguyen and Ahmed E. Hassan
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Debian_packages packages_installations

source("ESEUR_config.r")


plot_layout(2, 1)
pal_col=rainbow(2)


#
# Data extract from the Postgress databased used by UDD as follows:
#
# drv = dbDriver("PostgreSQL")
# con = dbConnect(drv,
# 	dbname="udd", port=5432, host="public-udd-mirror.xvm.mit.edu", user="public-udd-mirror", password="public-udd-mirror")
#
# rs <- dbSendQuery(con, statement = paste(
#                       "select b.source, insts, count(b.id) as bugs ",
#                       "from popcon_src as p, all_bugs as b, sources as s ",
#                       "where p.source=b.source and s.source=p.source and release like 'wheezy%' group by b.source,p.insts;"))
# we now fetch records from the resultSet into a data.frame
# Q1_data <- fetch(rs, n = -1)   # extract all rows
# dbClearResult(rs)
# 
# Age for all packages
# rs <- dbSendQuery(con, statement = paste(
# 	"select u.source, extract('epoch' from now()-min(date))/3600/24 as age",
#                       "from upload_history as u, sources as s ",
#                       "where s.source=u.source and release like 'wheezy%' group by u.source;"))
# Q10_data <- fetch(rs, n = -1)   # extract all rows
# dbClearResult(rs)
# 
# dbDisconnect(con)
#

q1=read.csv(paste0(ESEUR_dir, "regression/Q1_udd.csv.xz"), as.is=TRUE)
q10=read.csv(paste0(ESEUR_dir, "regression/Q10_udd.csv.xz"), as.is=TRUE)

udd=merge(q1, q10)

plot(udd$insts, udd$bugs, log="xy", col=point_col,
	xlab="Installs", ylab="Fault reports\n")

t=glm(log(bugs) ~ log(insts), data=udd)
# t=glm(bugs ~ log(insts), data=udd, family=poisson)
q=predict(t, newdata=data.frame(insts=1:200000), type="response", se.fit=TRUE)
lines(exp(q$fit), col=pal_col[1])
#lines(q$fit, col=pal_col[1])
#lines(exp(q$fit+1.96*q$se.fit), col="blue")
#lines(exp(q$fit-1.96*q$se.fit), col="blue")

t=loess(log(bugs) ~ insts, data=udd, span=0.2)
q=predict(t, newdata=data.frame(insts=1:200000))
# plot(udd$insts, udd$bugs, log="y")
lines(exp(q), col=pal_col[2])


plot(udd$age, udd$bugs, log="y", col=point_col,
	xaxs="i",
	xlim=c(0, max(udd$age)),
	xlab="Age (days)", ylab="Fault reports\n")

t=glm(log(bugs) ~ age, data=udd)
# t=glm(bugs ~ age, data=udd, family=poisson)
q=predict(t, newdata=data.frame(age=1:6000), type="response", se.fit=TRUE)
lines(exp(q$fit), col=pal_col[1])
# lines(q$fit, col=pal_col[1])
#lines(exp(q$fit+1.96*q$se.fit), col="blue")
#lines(exp(q$fit-1.96*q$se.fit), col="blue")

t=loess(log(bugs) ~ age, data=udd, span=0.2)
q=predict(t, newdata=data.frame(age=1:6000))
# plot(udd$age, udd$bugs, log="y")
lines(exp(q), col=pal_col[2])


# udd_mod=glm(log(bugs) ~ log(insts)*age, data=udd)
# udd_mod=glm(bugs ~ log(insts)*age, data=udd, family=poisson)
# summary(udd_mod)
# aov(udd_mod)

