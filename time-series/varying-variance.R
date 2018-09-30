#
# varying-variance.R, 14 Oct 16
#
# Data from:
# It's FAKED data!
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG example


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

# Need to replace this for loop
for (i in 2:total_points)
   {
   h[i]=alpha_0 + alpha_1*(a[i-1]^2) + beta_1*h[i-1]
   a[i]=w[i]*sqrt(h[i])
   }

acf(a, col=point_col)
acf(a^2, col=point_col)

