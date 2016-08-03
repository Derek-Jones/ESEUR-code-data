#
# pr_soc_lan.R,  2 Aug 16
#
# Data from:
# Quality and Productivity Outcomes Relating to Continuous Integration in GitHub
#∗Bogdan Vasilescu†and Yue Yu‡and Huaimin Wang‡and Premkumar Devanbu†and Vladimir Filkov†
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pr_soc=read.csv(paste0(ESEUR_dir, "regression/pr_soc_lan.csv"), as.is=TRUE)

plot(pr_soc$team_size, pr_soc$n_pr_core)
plot(pr_soc$proj_age, pr_soc$n_pr_core)

lines(loess.smooth(pr_soc$proj_age, pr_soc$n_pr_core, span=0.3), col=loess_col)

# pr_mod=glm(n_pr_core ~ team_size+I(proj_age^0.4)+log(src_loc+1e-3)+log(test_loc+1e-3), data=pr_soc, family=poisson)
pr_mod=glm(n_pr_core ~ team_size+I(proj_age^0.4), data=pr_soc, family=poisson)
summary(pr_mod)


