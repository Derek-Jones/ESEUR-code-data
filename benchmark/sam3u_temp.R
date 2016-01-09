#
# sam3u_temp.R, 22 Dec 15
#
# Data from:
# A case for opportunistic embedded sensing in presence of hardware power variability
# Lucas Wanner and Charwak Apte and Rahul Balani and Puneet Gupta and Mani Srivastava
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")

library("plyr")

plot_layout(1, 2)

sam_32khz=read.csv(paste0(ESEUR_dir, "benchmark/sam3u_32khz_sleep.csv.xz"), as.is=TRUE)

plot_sleep=function(board_num)
{
# Some boards were not tested at some temperatures, so we have NAs

not_miss=subset(sam_32khz, !is.na(sam_32khz[ , board_num]))

lines(not_miss$temp, not_miss[ , board_num]*1000, col=brew_col[board_num])
points(not_miss$temp, not_miss[ , board_num]*1000, col=brew_col[board_num])
}

brew_col=rainbow(10)

plot(1, type="n",
	xlim=c(20, 60), ylim=c(10, 320),
	xlab="Temperature (C)", ylab=expression("Power ("*mu*"W)\n"))
dummy=sapply(2:11, plot_sleep)
text(40, 20, "Sleeping")

sam_4Mhz=read.csv(paste0(ESEUR_dir, "benchmark/sam3u_4Mhz_temp.csv.xz"), as.is=TRUE)

brew_col=rainbow(10)

plot_power=function(df)
{
av_df=ddply(df, .(temp),
			function(df)
			{
			df$av_pow=mean(df$power)
			return(df)
			})

board_num=df$board[1]
lines(av_df$temp, av_df$av_pow*1000, col=brew_col[board_num])
}

plot(1, type="n",
	xlim=c(-30, 100), ylim=c(8, 10),
	xlab="Temperature (C)", ylab="Power (mW)\n")
d_ply(sam_4Mhz, .(board), plot_power)
text(40, 8.05, "4MHz")


