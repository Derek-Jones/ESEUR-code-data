#
# RK31-surveycostestim.R, 12 Nov 15
#
# Data from:
# A Survey on Software Estimation in the Norwegian Industry
# Kjetil Moløkken-Østvold and Magne Jørgensen and Sinan S. Tanilkan and Hans Gallis and Anette C. Lien and Siw E. Hove
# A Comparison of Software Project Overruns—Flexible versus Sequential Development Models
# Kjetil Moløkken-Østvold and Magne Jørgensen
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


# Nr,Model,Client,Method,Estimate_hrs,Actual_hrs,BREbias,Estimate_days,Actual_days,BREbias,Functionality
est_info=read.csv(paste0(ESEUR_dir, "economics/RK31-surveycostestim.csv.xz"), as.is=TRUE)

plot(est_info$Estimate_hrs, est_info$Actual_hrs, log="xy")
plot(est_info$Estimate_days, est_info$Actual_days, log="xy",
	xlab="Estimate (days)", ylab="Actual (days)")

hrs_mod=glm(Actual_hrs ~ log(Estimate_hrs), data=est_info, family=Gamma(link="log"))

# days_mod=glm(Actual_days ~ (log(Estimate_days)+Model+Client+Method+Functionality)^2, data=est_info, family=poisson)
days_mod=glm(Actual_days ~ log(Estimate_days)+Model
				+log(Estimate_days):Model
				+log(Estimate_days):Client
				+Model:Functionality, data=est_info, family=poisson)


