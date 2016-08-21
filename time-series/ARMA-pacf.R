#
# ARMA-pacf.R, 18 Aug 16
#
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


# Calling arima.sim would have been simpler, but the following
# makes what is going on explicit

plot_layout(4, 1)

next_AR_step=function(theta)
{
y=theta*cur_y+(1-theta)*rnorm(1)

cur_y <<- y

return(y)
}


cur_w=0
next_MA_step=function(theta)
{
new_w=(1-theta)*rnorm(1)
y=theta*cur_w+new_w

cur_w <<- new_w

return(y)
}


cur_y=0
time_8_series=replicate(1000, next_AR_step(0.8))
pacf(time_8_series, lag=10, col=point_col)
text(5, 0.6, expression(paste(x[t], " = 0.8", x[t-1], "+", w[t])), cex=1.3)

cur_y=0
time_m5_series=replicate(1000, next_AR_step(-0.5))
pacf(time_m5_series, lag=10, col=point_col)
text(5, -0.4, expression(paste(x[t], " = -0.5", x[t-1], "+", w[t])), cex=1.3)

cur_y=0
time_m5_series=replicate(1000, next_MA_step(0.8))
pacf(time_m5_series, lag=10, col=point_col)
text(5, 0.4, expression(paste(x[t], " = 0.8", w[t-1], "+", w[t])), cex=1.3)

cur_y=0
time_m5_series=replicate(1000, next_MA_step(-0.5))
pacf(time_m5_series, lag=10, col=point_col)
text(5, -0.25, expression(paste(x[t], " = -0.5", w[t-1], "+", w[t])), cex=1.3)


