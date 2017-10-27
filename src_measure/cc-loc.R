#
# cc-loc.R, 18 Mar 15
#
# Data from:
# Empirical analysis of the relationship between {CC} and {SLOC} in a large corpus of Java methods
# Davy Landman and Alexander Serebrenik and Jurgen Vinju
#
# Davy Landman 
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("lme4")


# project,file,cc,sloc
cc_loc=read.csv(paste0(ESEUR_dir, "src_measure/cc-loc.csv.xz"), as.is=TRUE)
cc_loc$logloc=log(cc_loc$sloc)

# gloc_mod=glm(cc ~ sloc, data=cc_loc)
# loc_mod=glm(cc ~ logloc, data=cc_loc, family=poisson)

#loc_mix=glmer(cc ~ logloc+ (logloc | project)
#                        , data=cc_loc, family=poisson)
# summary(loc_mix)
# gives:
#      AIC       BIC    logLik  deviance 
# 51517739  51517812 -25758864  51517729 
#
#Random effects:
# Groups  Name        Variance Std.Dev. Corr 
# project (Intercept) 0.05975  0.2444        
#         logloc      0.02166  0.1472   -0.92
#Number of obs: 17633256, groups: project, 13103
#
#Fixed effects:
#             Estimate Std. Error z value Pr(>|z|)    
#(Intercept) -0.823192   0.002427  -339.2   <2e-16 ***
#logloc       0.758163   0.001393   544.4   <2e-16 ***
#---
#Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1 
#
#Correlation of Fixed Effects:
#       (Intr)
#logloc -0.913
#

# plot(cc_loc$sloc, cc_loc$cc, log="xy")

smoothScatter(log(cc_loc$sloc), log(cc_loc$cc),
        xlab="log(SLOC)", ylab="log(CC)")


