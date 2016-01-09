#
# AR-models.R, 29 Jul 15
#
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


plot_layout(1, 2)

next_step=function(theta)
{
y=theta*cur_y+(1-theta)*rnorm(1)

cur_y <<- y

return(y)
}


cur_y=0
time_8_series=replicate(1000, next_step(0.8))
acf(time_8_series, lag=10)

cur_y=0
time_m5_series=replicate(1000, next_step(-0.5))
acf(time_m5_series, lag=10)


