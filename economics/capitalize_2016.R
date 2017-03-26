#
# capitalize_2016.R, 27 Feb 17
# Data from:
# Capitalization of Software Development Costs: {Accounting} Practices in the Software Industry, 2014 and 2015
# Charles W. Mulford and Sarika Misra
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


# plot_layout(1, 1, default_width=10, default_height=10)

costs=read.csv(paste0(ESEUR_dir, "economics/capitalize_2016.csv.xz"), as.is=TRUE)

plot(costs$Revenue/1e3, costs$Total.Costs/1e3, log="xy", col=point_col,
	xlab="Revenue (million dollars)", ylab="Software development costs (million dollars)\n")


# # Two obvious outliers
# clean=subset(costs, Total.Costs > 5e3 & !(Revenue <5e5 & Total.Costs > 5e5))
# plot(clean$Revenue/1e3, clean$Total.Costs/1e3, log="xy", col=point_col,
#         xlab="Revenue (million dollars)", ylab="Software development costs (million dollars)\n")
# cost_mod=glm(Total.Costs ~ Revenue, data=clean)
# summary(cost_mod) # Model is basically the same!

# # cost_mod=glm(Total.Costs ~ Revenue+I(Revenue^2), data=costs)
# # cost_mod=glm(log(Total.Costs) ~ log(Revenue), data=costs)
# cost_mod=glm(Total.Costs ~ Revenue, data=costs)
# summary(cost_mod)
# 
