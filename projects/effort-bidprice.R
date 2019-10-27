#
# effort-bidprice.R,  3 Oct 19
#
# Data from:
# Variability and Reproducibility in Software Engineering: A Study of Four Companies that Developed the Same System
# Bente C. D. Anda and Dag I. K. Sj{\o}berg and Audris Mockus
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAGS experiment_people estimate tender_bid


source("ESEUR_config.r")


bid_info=read.csv(paste0(ESEUR_dir, "projects/SoftEngjan10.csv.xz"), as.is=TRUE)

# Consistency check
# (bid_info$A_D_bid+bid_info$A_D_planned/10) == bid_info$A_D_emphasis

plot(bid_info$bid_price, bid_info$est_time, col=point_col, lwd=1.4,
	xlab="Amount quoted", ylab="Estimated time\n")

bid_mod=glm(est_time ~ bid_price, data=bid_info)

sub_info=subset(bid_info, bid_price < 50000)

# sub_mod=glm(est_time ~ (bid_price+A_D_bid+A_D_planned+A_D_emphasis)^2, data=sub_info)
# t=stepAIC(sub_mod)

sub_mod=glm(est_time ~ bid_price + A_D_bid + A_D_planned + 
	+ bid_price:(A_D_bid + A_D_planned)
	# + A_D_planned:(A_D_bid + A_D_emphasis)
	# Given the relationship between these three variables,
	# we can simplify:
	+ A_D_planned:A_D_bid
	+ I(A_D_planned^2)
	, data=sub_info)
summary(sub_mod)


