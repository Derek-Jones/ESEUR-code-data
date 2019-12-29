#
# RK31-surveycostestim.R,  3 Dec 19
#
# Data from:
# A Survey on Software Estimation in the Norwegian Industry
# Kjetil Moløkken-Østvold and Magne Jørgensen and Sinan S. Tanilkan and Hans Gallis and Anette C. Lien and Siw E. Hove
# A Comparison of Software Project Overruns—Flexible versus Sequential Development Models
# Kjetil Moløkken-Østvold and Magne Jørgensen
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG effort_estimate estimate_internal estimate_external


source("ESEUR_config.r")


pal_col=rainbow(3)


# Nr,Model,Client,Method,Estimate_hrs,Actual_hrs,BREbias,Estimate_days,Actual_days,BREbias,Functionality
est_info=read.csv(paste0(ESEUR_dir, "projects/RK31-surveycostestim.csv.xz"), as.is=TRUE)


# hrs_mod=glm(Actual_hrs ~ (log(Estimate_hrs)+Model+Client+Method+Functionality)^2, data=est_info, family=gaussian(link="log"))
hrs_mod=glm(log(Actual_hrs) ~ log(Estimate_hrs)
				*Client
				# +Method
				# +log(Estimate_days):Method
				# +Client:Functionality
				, data=est_info)
# summary(hrs_mod)

p_int=subset(est_info, Client == "Internal")
p_ext=subset(est_info, Client == "External")

plot(p_int$Estimate_hrs, p_int$Actual_hrs, log="xy", col=pal_col[1],
	xlab="Estimate (hours)", ylab="Actual (hours)\n")
points(p_ext$Estimate_hrs, p_ext$Actual_hrs, col=pal_col[3])

est_range=exp(seq(log(min(est_info$Estimate_hrs)),
		log(max(est_info$Estimate_hrs)), by=0.1))

lines(est_range, est_range, col=pal_col[2])

legend(x="bottomright", legend=c("Internal", "Estimate==Actual", "External"), bty="n", fill=pal_col, cex=1.2)

# Fit internal projects
int_mod=glm(log(Actual_hrs) ~ log(Estimate_hrs), data=p_int)
# summary(int_mod)

pred=predict(int_mod, newdata=data.frame(Estimate_hrs=est_range))
lines(est_range, exp(pred), col=pal_col[1])


# Fit external projects
ext_mod=glm(log(Actual_hrs) ~ log(Estimate_hrs), data=p_ext)
# summary(ext_mod)

pred=predict(ext_mod, newdata=data.frame(Estimate_hrs=est_range))
lines(est_range, exp(pred), col=pal_col[3])


# days_mod=glm(Actual_days ~ (log(Estimate_days)+Model+Client+Method+Functionality)^2, data=est_info, family=poisson)
# days_mod=glm(Actual_days ~ log(Estimate_days)+Model
# 				+log(Estimate_days):Model
# 				+log(Estimate_days):Client
# 				+Model:Functionality, data=est_info
# 				, family=poisson)
# summary(days_mod)


