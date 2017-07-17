#
# req-cost-benefit.R, 23 Mar 17
# Data from:
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

# Sum of yearly survival contributions

source("ESEUR_config.r")


pal_col=rainbow(4)

sur=function(c, y=6)
   return((1-c)/(c*(1-c^y)))


plot_cost_benefit=function(surviv, color, years)
{
cost.total=1+dm_ratio*sur(surviv, years)
lines(dm_ratio, cost.total, col=color)
}


# Plot various project lifespans for given survival rate
cost_benefit=function(surviv, color)
{
plot_cost_benefit(surviv, color, 5.5)
plot_cost_benefit(surviv, color, 6)
plot_cost_benefit(surviv, color, 6.5)
plot_cost_benefit(surviv, color, 7)
plot_cost_benefit(surviv, color, 7.5)
}

years=1:10
dm_ratio=seq(1, 10, by=0.5)

plot(1, type="n",
	xlim=c(1, 10), ylim=c(0, 8.5),
       xlab="development/maintenance cost ratio",
       ylab="Break-even saving/investment ratio")
# Plot various survival rates
cost_benefit(0.9, "black")
cost_benefit(0.8, "red")
cost_benefit(0.7, "blue")
cost_benefit(0.6, "green")



