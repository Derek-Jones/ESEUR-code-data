#
# HuijgensPhD.R, 12 Jan 19
# Data from:
# Evidence-Based Software Portfolio Management
# Hennie Huijgens
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG projects economics cost time

source("ESEUR_config.r")


eb=read.csv(paste0(ESEUR_dir, "projects/HuijgensPhD.csv.xz"), as.is=TRUE, sep=";")

eb$Actual_cost_EUR=as.numeric(gsub("\\.", "", eb$Actual_cost_EUR))
eb$Actual_duration_months=as.numeric(gsub(",", ".", eb$Actual_duration_months))

plot(eb$Functional_size_FP, eb$Actual_cost_EUR, log="xy",
	xlab="Function points", ylab="Cost (EUR)\n")

fp_mod=glm(log(Actual_cost_EUR) ~ log(Functional_size_FP)+
					Technology_driven_project+
					Rules_and_regulations_driven_project+
					Organization+
					# Development_class+
					# log(Functional_size_FP):
				Development_method
					, data=eb)
summary(fp_mod)

plot(eb$Actual_duration_months, eb$Actual_cost_EUR, log="xy",
	xlab="Duration (months)", ylab="Cost (EUR)\n")


