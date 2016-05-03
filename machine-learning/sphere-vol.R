#
# sphere-vol.R, 28 Mar 16
#
# Data from:
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

n=50

# Initial values that result in 2-D/3-D circle/sphere having correct values
sphere_vol=1
sphere_vol[2]=2

# R indexes from 1, not zero, so we are off by one
for (d in 3:n)
   sphere_vol[d]=sphere_vol[d-2]*2*pi/(d-1)

plot(1:n, sphere_vol, log="y",
	xlab="Dimensions", ylab="Volume\n")


