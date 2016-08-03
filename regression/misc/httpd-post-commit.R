#
# httpd-post-commit.R,  2 Jun 13
#
# Data from:
# Intensive Metrics for the Study of the Evolution of Open Source Projects: Case studies from Apache Software Foundation projects
# Santiago Gala-P\'{e}rez and Gregorio Robles and Jes\'{u}s M. Gonz\'{a}lez-Barahona and Israel Herraiz
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(3)

httpd=read.csv(paste0(ESEUR_dir, "regression/misc/httpd.csv.xz"), as.is=TRUE)

plot(httpd$total, httpd$commits, col=point_col,
        xlab="Posts per month", ylab="Commits per month\n")

lines(loess.smooth(httpd$total, httpd$commits, span=0.3), col=loess_col)

h_mod=glm(commits ~ total, data=httpd)
summary(h_mod)

lines(httpd$total, predict(h_mod))

h_mod=glm(commits ~ I(total^0.5), data=httpd)
summary(h_mod)

lines(httpd$total, predict(h_mod), col="red")

