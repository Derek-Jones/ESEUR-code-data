#
# upgrade-languages.R, 20 Sep 18
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


pal_col=rainbow(2)


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

cc=subset(cc_cpp, Cpp == 0)
no_Watcom=subset(cc_cpp, Firm != "Watcom")

Vis_Cpp=subset(cc_cpp, Product == "Visual C++")
# Product == "Turbo C++" an earlier product targeting a different market
Bor_Cpp=subset(cc_cpp, Product == "C++")

# upg_mod=glm(Upg.Price ~ Full.Price, data=no_Watcom)
# summary(upg_mod)


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

lines(x_vals, predict(prod_b_sl, newdata=data.frame(Full.Price=x_vals, Cpp=1), type="response"), col=pal_col[2])


