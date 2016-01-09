#
# log-failures.R, 18 Jun 15
#
# Data from:
# Blue gene/L log analysis and time to interrupt estimation
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


best_1st=read.csv(paste0(ESEUR_dir, "hardware/Blue-Gene.log/Best.1st-loc"), sep= " ", header=FALSE, fill=TRUE)

start_secs=as.numeric(as.POSIXct(substr(best_1st$V1[1], 1, 19), format="%Y-%m-%d-%H.%M.%S"))

b_1st_secs=as.numeric(as.POSIXct(substr(best_1st$V1, 1, 19), format="%Y-%m-%d-%H.%M.%S"))

fault_interval=diff(b_1st_secs)

fault_interval=subset(fault_interval, fault_interval > 1)
mean(fault_interval)

plot(density(fault_interval, adjust=0.2, na.rm=TRUE), log="x",
	main="")


plot(table(fault_interval))

