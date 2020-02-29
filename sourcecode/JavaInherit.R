#
# JavaInherit.R, 16 Jan 20
# Data from:
# An Empirical Investigation of Inheritance Trends in {Java} {OSS} Evolution
# Emal Nasseri
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Java_inheritance method_inheritance class_inheritance inheritance_evolution

source("ESEUR_config.r")


library("lme4")
library(reshape2)


ji=read.csv(paste0(ESEUR_dir, "sourcecode/JavaInherit.csv.xz"), as.is=TRUE)

# di_mod=glm(DIT.2 ~ (Version+DIT.1)^2-Version, data=ji)
# summary(di_mod)
# 
# # di_mod=glm(DIT.2 ~ DIT.1+I(DIT.1^0.7), data=ji)
# 
# din_mod=nls(DIT.2 ~ a+b*DIT.1^c, data=ji, start=list(a=-90, b=0.1, c=0.8))
# summary(din_mod)
# AIC(din_mod)
# 
# di_mod=glm(DIT.2 ~ I(DIT.1^0.75), data=ji)
# summary(di_mod)
#
# di_mod=glm(log(DIT.2) ~ log(DIT.1)+Item, data=ji)
#

# plot(ji$DIT.1, ji$DIT.2)
plot(ji$DIT.1, ji$DIT.2, log="xy",
	xlab="Depth 1 inheritance", ylab="Depth 2 inheritance")

jil=melt(ji, id.vars=c("Item", "System", "Version"),
		variable.name="Depth", value.name="Occurrences")

# Factor converted to corresponding number, i.e., relative order of columns
jil$Depth=as.numeric(jil$Depth)

jil=subset(jil, Occurrences > 0)

o_mod=glm(log(Occurrences) ~ Depth+Version+Item+Depth:Item+System, data=jil)
summary(o_mod)

o_lmod=lmer(log(Occurrences) ~ Depth+Version+Item+Depth:Item+(Depth | System), data=jil)
summary(o_lmod)

