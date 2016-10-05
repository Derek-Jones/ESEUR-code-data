#
# varying-variance.R,  1 Oct 16
#
# Data from:
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


plot_layout(2, 1)

# Code from section 7.4.4 of
# Introductory Time Series with R
# Paul S.P. Cowpertwait and Andrew V. Metcalfe

total_points=1000
set.seed(1)

alpha_0=0.1
alpha_1=0.4
beta_1=0.2
w=rnorm(total_points)
a=rep(0, total_points)
h=rep(0, total_points)

for (i in 2:total_points)
   {
   h[i]=alpha_0 + alpha_1*(a[i-1]^2) + beta_1*h[i-1]
   a[i]=w[i]*sqrt(h[i])
   }

acf(a)
acf(a^2)

