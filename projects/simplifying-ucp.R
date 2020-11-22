#
# simplifying-ucp.R, 17 Jul 20
# Data from:
# Simplifying effort estimation based on Use Case Points
# M. Ochodek and J. Nawrocki and K. Kwarciak
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG estimate_effort use-case-points

source("ESEUR_config.r")


library("plyr")


pr=read.csv(paste0(ESEUR_dir, "projects/simplifying-projects.csv.xz"), as.is=TRUE)
uc=read.csv(paste0(ESEUR_dir, "projects/simplifying-ucases.csv.xz"), as.is=TRUE)

# table(uc$Steps, uc$Actors)

p_uc=count(uc$ProjectID)

pr=merge(pr, p_uc, by.x="ProjectID", by.y="x")

plot(pr$freq, pr$ActualEffort)

pr_mod=glm(ActualEffort ~ freq+freq:sqrt(Staff)+freq:Origin, data=pr)
summary(pr_mod)

# Call:
# glm(formula = ActualEffort ~ freq + freq:sqrt(Staff) + freq:Origin, 
#     data = pr)
# 
# Deviance Residuals: 
#     Min       1Q   Median       3Q      Max  
# -968.44  -249.73   -76.57   216.50  1075.75  
# 
# Coefficients:
#                  Estimate Std. Error t value Pr(>|t|)    
# (Intercept)        477.65     193.60   2.467   0.0215 *  
# freq              -123.58      34.55  -3.577   0.0016 ** 
# freq:sqrt(Staff)    76.94      14.23   5.407 1.71e-05 ***
# freq:OriginU       -22.90      11.51  -1.989   0.0588 .  
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# (Dispersion parameter for gaussian family taken to be 221623.3)
# 
#     Null deviance: 16285039  on 26  degrees of freedom
# Residual deviance:  5097336  on 23  degrees of freedom
# AIC: 414.63
# 
