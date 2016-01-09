#
# httpd.R,  8 Oct 13
#
# Date from:
# Intensive Metrics for the Study of the Evolution of Open Source Projects: Case studies from Apache Software Foundation projects
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

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

