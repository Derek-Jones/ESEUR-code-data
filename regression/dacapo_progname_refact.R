#
# dacapo_progname_refact.R, 25 Mar 16
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

b=glm(performance ~ progname-1, data=dacapo)

# bm=glm(performance ~ progname*refact-1, data=dacapo)

bm2=glm(performance ~ progname+progname:refact-1, data=dacapo)

t=summary(bm2)

# Exclude t value so long output don't wrap on the printed page
print(t$coefficients[t$coefficients[ , 4] < 0.05 , -3])

