#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

library(plyr)
library(ggplot2)
library(Rmisc)

############################################################


remove_outlier_from_column <- function(df, col_name, fac=1.5) {
  
  a <- quantile( df[,col_name] , probs=c(.25,.75))
  limit <- a[2] + fac * (a[2]-a[1])
  dfres <- df[ df[, col_name]<=limit, ]
  
  limit2 <- a[1] - fac * (a[2]-a[1])
  dfres <- dfres[ dfres[,col_name] >= limit2, ]
  
  dfres
}


df.fig1 <- read.csv2("data_fig1.dat")

df.fig1.scan <- df.fig1[ df.fig1$test == "Scan", ]
df.fig1.allreduce <- df.fig1[ df.fig1$test == "Allreduce", ]

par(mfrow=c(1,2))

df.fig1.scan.1 <- remove_outlier_from_column(df.fig1.scan, "time")
hist(df.fig1.scan.1$time, freq = FALSE)
lines(density(df.fig1.scan.1$time, bw=2), col="red", lwd=2)

df.fig1.allreduce.1 <- remove_outlier_from_column(df.fig1.allreduce, "time")
hist(df.fig1.allreduce.1$time, freq = FALSE)
lines(density(df.fig1.allreduce.1$time, bw=2), col="red", lwd=2)


df.fig3 <- read.csv2("data_fig3.dat")

df.fig1.scan.1 <- df.fig3[ df.fig3$exp == 58, ]
df.fig1.scan.2 <- df.fig3[ df.fig3$exp == 67, ]

df.fig1.scan.1.1 <- remove_outlier_from_column(df.fig1.scan.1, "time")
df.fig1.scan.2.1 <- remove_outlier_from_column(df.fig1.scan.2, "time")

hist(df.fig1.scan.1.1$time, freq = FALSE, xlim=c(15,40))
lines(density(df.fig1.scan.1.1$time, bw=1), col="red", lwd=2)

hist(df.fig1.scan.2.1$time, freq = FALSE, xlim=c(15,40))
lines(density(df.fig1.scan.2.1$time, bw=1), col="red", lwd=2)







