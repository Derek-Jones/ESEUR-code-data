#
# MIT-LCS-TR-068.R, 25 May 17
# Data from:
# Economies of Scale in Computer Use: {Initial} Tests and Implications for the Computer Utility
# Lee L. Selwyn
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

pal_col=rainbow(3)


rent_buy=read.csv(paste0(ESEUR_dir, "ecosystems/MIT-LCS-TR-068.csv.xz"), as.is=TRUE)

rental=subset(rent_buy, min.rent > 100)

# one=subset(rent_buy, Inst == 1)
# which(one$min_rent != one$mean_rent)
# which(one$max_rent != one$mean_rent)
# 
# two=subset(rent_buy, Inst == 2)
# which((two$min_rent+two$max_rent)/2 != two$mean_rent)
# 
# three=subset(rent_buy, Inst == 3)
# which(three$mean_rent*3-three$min_rent-three$max_rent < three$min_rent)
# which(three$mean_rent*3-three$min_rent-three$max_rent > three$max_rent)
# 
# four=subset(rent_buy, Inst == 4)
# which(four$mean_rent*4-four$min_rent*2-four$max_rent < four$min_rent)
# 

# plot(rental$mean.rent, rental$min.rent, log="xy", col=pal_col[1])
# points(rental$mean.rent, rental$max.rent, col=pal_col[2])
# points(rental$min.rent, rental$max.rent, col=pal_col[3])

plot(rental$min.rent, rental$max.rent, log="xy", col=point_col,
	xlab="Minimum", ylab="Maximum\n")


