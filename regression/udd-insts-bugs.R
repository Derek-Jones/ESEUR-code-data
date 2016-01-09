#
# udd-insts-bugs.R, 22 Dec 15
#
# R code for book "Empirical Software Engineering using R"
# Derek M. Jones, http://shape-of-code.coding-guidelines.com
#
# From an idea published in:
# Impact of Installation Counts on Perceived Quality: A Case Study of Debian
# Israel Herraiz and Emad Shihab and Thanh H. D. Nguyen and Ahmed E. Hassan
#
# Data extract fromt he Postgress databased used by UDD as follows:
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
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(2)

plot_layout(1, 2)

q1=read.csv(paste0(ESEUR_dir, "regression/Q1_udd.csv.xz"), as.is=TRUE)
q10=read.csv(paste0(ESEUR_dir, "regression/Q10_udd.csv.xz"), as.is=TRUE)

udd=merge(q1, q10)

plot(udd$insts, udd$bugs, log="xy", col=point_col,
	xlab="Installs", ylab="Bugs reported\n")

t=glm(bugs ~ log(insts), data=udd, family=poisson)
q=predict(t, newdata=data.frame(insts=1:200000), type="response", se.fit=TRUE)
lines(q$fit, col=pal_col[1])
#lines(q$fit+1.96*q$se.fit, col="blue")
#lines(q$fit-1.96*q$se.fit, col="blue")

t=loess(bugs ~ insts, data=udd, span=0.2)
q=predict(t, newdata=data.frame(insts=1:200000))
# plot(udd$insts, udd$bugs, log="y")
lines(q, col=pal_col[2])


plot(udd$age, udd$bugs, log="y", col=point_col,
	xlab="Age in days", ylab="")

t=glm(bugs ~ age, data=udd, family=poisson)
q=predict(t, newdata=data.frame(age=1:6000), type="response", se.fit=TRUE)
lines(q$fit, col=pal_col[1])
#lines(q$fit+1.96*q$se.fit, col="blue")
#lines(q$fit-1.96*q$se.fit, col="blue")

t=loess(bugs ~ age, data=udd, span=0.2)
q=predict(t, newdata=data.frame(age=1:6000))
# plot(udd$age, udd$bugs, log="y")
lines(q, col=pal_col[2])


# udd_mod=glm(bugs ~ log(insts)*age, data=udd, family=poisson)
# summary(udd_mod)

