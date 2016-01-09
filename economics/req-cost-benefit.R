#
# req-cost-benefit.R,  2 Dec 15
#
# R code for book "Empirical Software Engineering using R"
# Derek M. Jones, http://shape-of-code.coding-guidelines.com
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

# Sum of yearly survival contributions

source("ESEUR_config.r")


sur=function(c, y=6)
   return((1-c)/(c*(1-c^y)))


plot.cost.benefit=function(surviv, color, years)
{
cost.total=1+dm_ratio*sur(surviv, years)
lines(dm_ratio, cost.total, col=color)
}


# Plot various project lifespans for given survival rate
cost.benefit=function(surviv, color)
{
plot.cost.benefit(surviv, color, 5.5)
plot.cost.benefit(surviv, color, 6)
plot.cost.benefit(surviv, color, 6.5)
plot.cost.benefit(surviv, color, 7)
plot.cost.benefit(surviv, color, 7.5)
}

years=1:10
dm_ratio=seq(1, 10, by=0.5)

plot(1, type="n",
	xlim=c(1, 10), ylim=c(0, 8.5),
       xlab="development/maintenance cost ratio",
       ylab="Break-even saving/investment ratio")
# Plot various survival rates
cost.benefit(0.9, "black")
cost.benefit(0.8, "red")
cost.benefit(0.7, "blue")
cost.benefit(0.6, "green")

