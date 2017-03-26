#
# upgrade-languages.R,  2 Mar 17
# Data from:
# Information Goods Upgrades: {Theory} and Evidence
# V. Brian Viard
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(2)

library("plyr")

full_price=function(df)
{
lines(df$Date, df$Full.Price, col="blue")
}


cc_cpp=read.csv(paste0(ESEUR_dir, "economics/upgrade-languages.csv.xz"), as.is=TRUE)
cc_cpp$OS=(cc_cpp$OS == "Windows")
cc_cpp=subset(cc_cpp, !is.na(Full.Price))
cc_cpp$Date=as.Date(paste0("01-", cc_cpp$Date), format="%d-%b-%y")

# table(cc_cpp$OS, cc_cpp$Cpp)

cc=subset(cc_cpp, Cpp == 0)
no_Watcom=subset(cc_cpp, Firm != "Watcom")

plot(no_Watcom$Full.Price, no_Watcom$Upg.Price, col=point_col,
        xlab="Full retail price ($)", ylab="Upgrade price ($)\n")

plot(cc_cpp$Date, cc_cpp$Full.Price, col=point_col,
        xlab="Date", ylab="Full or Update price ($)\n")
d_ply(cc_cpp, .(Product), full_price)

points(cc_cpp$Date, cc_cpp$Upg.Price, col="green")


upg_mod=glm(Upg.Price ~ Full.Price, data=no_Watcom)
summary(upg_mod)


# Did vendors charge more for Windows versions, compared to DOS,
# of the same compiler?
plot(jitter(no_Watcom$Full.Price), no_Watcom$OS, col=point_col, yaxt="n",
	xlab="Full retail price ($)", ylab="OS")
axis(side=2, at=c(0, 1), label=c("MS-DOS", "Windows"))

sl=glm(OS ~ Full.Price, data=no_Watcom)
# summary(sl)
lines(no_Watcom$Full.Price, predict(sl), col=pal_col[1])

b_sl=glm(OS ~ Full.Price, data=no_Watcom, family=binomial)
# summary(b_sl)

x_vals=min(no_Watcom$Full.Price):max(no_Watcom$Full.Price)

lines(x_vals, predict(b_sl, newdata=data.frame(Full.Price=x_vals), type="response"), col=pal_col[2])

prod_b_sl=glm(OS ~ Full.Price:Cpp, data=no_Watcom, family=binomial)
summary(prod_b_sl)


