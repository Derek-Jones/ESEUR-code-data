#
# win-compiler-prices.R, 20 Sep 18
# Data from:
# Information Goods Upgrades: {Theory} and Evidence
# V. Brian Viard
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG economics cost-retail upgrade compiler


source("ESEUR_config.r")


library("plyr")


full_price=function(df)
{
df=df[order(df$Date), ]
lines(df$Date, df$Full.Price, col=df$col[1])
}


cc_cpp=read.csv(paste0(ESEUR_dir, "economics/upgrade-languages.csv.xz"), as.is=TRUE)
cc_cpp$OS=(cc_cpp$OS == "Windows")
cc_cpp=subset(cc_cpp, !is.na(Full.Price))
cc_cpp$Date=as.Date(paste0("01-", cc_cpp$Date), format="%d-%b-%y")

# table(cc_cpp$OS, cc_cpp$Cpp)

# table(cc_cpp$Product, cc_cpp$Firm)

unq_prod=unique(cc_cpp$Product)
pal_col=rainbow(length(unq_prod))
cc_cpp$col_str=mapvalues(cc_cpp$Product, unq_prod, pal_col)


cc=subset(cc_cpp, Cpp == 0)
no_Watcom=subset(cc_cpp, Firm != "Watcom")

# plot(no_Watcom$Full.Price, no_Watcom$Upg.Price, col=pal_col,
#         xlab="Full retail price ($)", ylab="Upgrade price ($)\n")

plot(cc_cpp$Date, cc_cpp$Full.Price, col=point_col, type="n",
        xlab="Date", ylab="Full or Update price ($)\n")
d_ply(cc_cpp, .(Product), full_price)

points(cc_cpp$Date, cc_cpp$Upg.Price, col=point_col)


