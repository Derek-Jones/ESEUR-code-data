#
# SPECpower.R, 12 Aug 16
# Data from:
# http://www.spec.org
# power_ssj2008-results-20160613-125328.csv
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("car")


jpow=read.csv(paste0(ESEUR_dir, "hardware/ssj2008-results-20160613.csv.xz"), as.is=TRUE)

jpow$ssj_ops=jpow$ssj_ops...100..of.target.load
jpow$avg.watts=jpow$Average.watts...100..of.target.load

pal_col=rainbow_hcl(3)

jpow$ops_watt=jpow$ssj_ops/jpow$avg.watts
pairs( ~ ops_watt+
			Nodes+
#			JVM.Vendor+
			Processor.MHz+
			Chips+
			Cores+
#			Threads.Per.Core+
			Memory.GB
#			+ssj_ops
			, col=point_col,
			 data=jpow)
j_av_watts=subset(jpow, !is.na(avg.watts))

pow_mod=glm(avg.watts ~ 
			Nodes+
#			JVM.Vendor+
			Processor.MHz+
			Chips+
			Cores+
#			Threads.Per.Core+
			Memory.GB
#			+ssj_ops
			, data=j_av_watts)
summary(pow_mod)
vif(pow_mod)

pow_mod=glm(avg.watts ~ 
			Nodes+
#			JVM.Vendor+
			Processor.MHz+
# Chips has the highest VIF
#			Chips+
			Cores+
#			Threads.Per.Core+
			Memory.GB
#			+ssj_ops
			, data=j_av_watts)
summary(pow_mod)
vif(pow_mod)


library("penalized")

pen_mod=penalized(avg.watts ~
                        Nodes+
#                       JVM.Vendor+
                        Processor.MHz+
                        Chips+
                        Cores+
#                       Threads.Per.Core+
                        Memory.GB
#                       +ssj_ops
                        , data=j_av_watts,
# Give maximum opportunity to change the parameters
			lambda1=1.0,
			lambda2=1.0)
coefficients(pen_mod)

