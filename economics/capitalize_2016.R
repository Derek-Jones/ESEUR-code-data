#
# capitalize_2016.R, 21 May 20
# Data from:
# Capitalization of Software Development Costs: {Accounting} Practices in the Software Industry, 2014 and 2015
# Charles W. Mulford and Sarika Misra
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG development-costs_capitalization accounting-practices software_accounting


source("ESEUR_config.r")


pal_col=rainbow(2)

# plot_layout(1, 1, default_width=10, default_height=10)

costs=read.csv(paste0(ESEUR_dir, "economics/capitalize_2016.csv.xz"), as.is=TRUE)

costs$MRevenue=costs$Revenue/1e3
costs$MTotal.Costs=costs$Total.Costs/1e3


plot(costs$MRevenue, costs$MTotal.Costs, log="xy", col=pal_col[2],
	xlab="Revenue ($million)", ylab="Software development costs ($million)\n")


# # Two obvious outliers
# clean=subset(costs, MTotal.Costs > 5 & !(MRevenue <5e2 & MTotal.Costs > 5e2))
# plot(clean$MRevenue, clean$MTotal.Costs, log="xy", col=point_col,
#         xlab="Revenue ($million)", ylab="Software development costs ($million)\n")
# cost_mod=glm(Total.Costs ~ Revenue, data=clean)
# summary(cost_mod) # Model is basically the same!

# # cost_mod=glm(MTotal.Costs ~ MRevenue+I(MRevenue^2), data=costs)
cost_mod=glm(log(MTotal.Costs) ~ log(MRevenue), data=costs)
# cost_mod=glm(MTotal.Costs ~ MRevenue-1, data=costs)
# summary(cost_mod)
#

x_vals=exp(seq(1, log(max(costs$MRevenue)), by=0.1))
pred=predict(cost_mod, newdata=data.frame(MRevenue=x_vals))

lines(x_vals, exp(pred), col=pal_col[1])

