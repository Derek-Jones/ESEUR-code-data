#
# dacapo_progname.R, 11 Nov 15
#
# Data from:
# Are Your Incoming Aliases Really Necessary?  Counting the Cost of Object Ownership
# Alex Potanin and Monique Damitio and James Noble
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("reshape2")

orig.dacapo=read.csv(paste0(ESEUR_dir, "regression/DaCapo.csv.xz"), as.is=TRUE)

# Convert the dataframe format from:
# run iter avrora batik eclipse fop h2 jython luindex lusearch pmd sunflow tomcat tradebeans tradesoap xalan refact
#  to:
# run iter method progname performance

dacapo=melt(orig.dacapo, id=c("run", "iter", "refact"),
		variable.name="progname", value.name="performance")

prog_mod=glm(performance ~ progname-1, data=dacapo)

# bm=glm(performance ~ progname*refact-1, data=dacapo)

t=summary(prog_mod)

print(t)

