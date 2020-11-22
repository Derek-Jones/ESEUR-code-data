#
# httpd.R,  8 Oct 13
#
# Date from:
# Intensive Metrics for the Study of the Evolution of Open Source Projects: Case studies from Apache Software Foundation projects
# Santiago Gala-P{\'e}rez and Gregorio Robles and Jes{\'u}s M. Gonz{\'a}lez-Barahona and Israel Herraiz
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG project_evolution software_metric Apache_project


source("ESEUR_config.r")

#   year month build issues commits wiki devel user total
httpd=read.csv(paste0(ESEUR_dir, "time-series/httpd.csv.xz"), as.is=TRUE)

httpd$date=as.Date(paste0(httpd$year, "-", httpd$month, "-01"), format="%Y-%m-%d")

commits=subset(httpd, commits > 0)

plot(commits$date, commits$commits)

acf(diff(commits$commits))
#ccf(diff(log(commits$devel)), diff(log(commits$commits)), lag.max=20)
ccf(diff(commits$devel), diff(commits$commits), lag.max=20)

plot(commits$date, commits$devel)
plot(commits$date, commits$user)
plot(commits$date, commits$total)

