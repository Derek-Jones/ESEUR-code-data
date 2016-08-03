#
# SPECpower.R, 12 Jun 16
# Data from:
# http://www.spec.org
# SPECpower_ssj2008 results
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

ource("ESEUR_config.r")


jpow=read.csv(paste0(ESEUR_dir, "hardware/SPECpower.csv.xz"), as.is=TRUE)

pal_col=rainbow_hcl(3)

jpow$ops_watt=jpow$ssj_ops/jpow$avg.watts
pairs( ~ ops_watt+
			Nodes+
#			JVM.Vendor+
			MHz+
			Chips+
			Cores+
#			Total.Threads+
			Total.Memory
#			+ssj_ops
			, col=point_col,
			 data=jpow)
j_av_watts=subset(jpow, !is.na(avg.watts))

pow_mod=glm(avg.watts ~ 
			Nodes+
#			JVM.Vendor+
			MHz+
			Chips+
			Cores+
#			Total.Threads+
			Total.Memory
#			+ssj_ops
			, data=j_av_watts)
summary(pow_mod)
vif(pow_mod)

pow_mod=glm(avg.watts ~ 
			Nodes+
#			JVM.Vendor+
			MHz+
# Chips has the highest VIF
#			Chips+
			Cores+
#			Total.Threads+
			Total.Memory
#			+ssj_ops
			, data=j_av_watts)
summary(pow_mod)
vif(pow_mod)


library("penalized")

pen_mod=penalized(avg.watts ~
                        Nodes+
#                       JVM.Vendor+
                        MHz+
                        Chips+
                        Cores+
#                       Total.Threads+
                        Total.Memory
#                       +ssj_ops
                        , data=j_av_watts,
# Give maximum opportunity to change the parameters
			lambda1=1.0,
			lambda2=1.0)
coefficients(pen_mod)

