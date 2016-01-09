#
# DaCapo.R, 26 Aug 13
#
# Data from:
# Are Your Incoming Aliases Really Necessary?  Counting the Cost of Object Ownership
#
# Alex Potanin and Monique Damitio and James Noble
# R code for book "Empirical Software Engineering using R"
# Derek M. Jones, http://shape-of-code.coding-guidelines.com
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("nlme")
library("reshape2")


orig.dacapo=read.csv(paste0(ESEUR_dir, "regression/DaCapo.csv.xz"), as.is=TRUE)

# Convert the dataframe format from:
# run iter avrora batik eclipse fop h2 jython luindex lusearch pmd sunflow tomcat tradebeans tradesoap xalan refact
#  to:
# run iter method progname performance

dacapo=melt(orig.dacapo, id=c("run", "iter", "refact"),
		variable.name="progname", value.name="performance")

b=glm(performance ~ progname, data=dacapo)

bm=glm(performance ~ progname*refact, data=dacapo)

bm2=glm(performance ~ progname+progname:refact, data=dacapo)

#bm2=glm(performance ~ progname+I(progname == "sunflow"):refact, data=dacapo)

#bms=glm(performance ~ progname+progname:refact, data=dacapo, subset=(variable=="sunflow" | variable =="jython"))

bme=lme(performance ~ progname+progname:refact, random= ~1 | refact, data=dacapo)

