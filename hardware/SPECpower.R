#
# SPECpower.R, 18 Nov 15
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
			, data=jpow)

pow_mod=glm(avg.watts ~ 
			Nodes+
#			JVM.Vendor+
			MHz+
			Chips+
			Cores+
#			Total.Threads+
			Total.Memory
#			+ssj_ops
			, data=jpow)
summary(pow_mod)
vif(pow_mod)

pow_mod=glm(ssj_ops ~
			Nodes+
#			JVM.Vendor+
#			MHz+
			Chips+
			Cores+
			Total.Threads+
			Total.Memory
			, data=jpow)
summary(pow_mod)

