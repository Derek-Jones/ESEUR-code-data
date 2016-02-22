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

httpd=read.csv(paste0(ESEUR_dir, "regression/httpd.csv.xz"), as.is=TRUE)

plot(httpd$total, httpd$commits, col=point_col,
        xlab="Posts per month", ylab="Commits per month\n")

# h_mod=glm(total ~ commits, data=httpd)
# 
# summary(h_mod)

