#
# Landy_TML-19-rwise.R, 15 Jan 17
# Data from:
# Categories of Large Numbers in Line Estimation
# David Landy and Arthur Charlesworth and Erin Ottmar
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")


lin_log=function(df)
{
thousand=subset(df, stimulus < 1e6)
million=subset(df, (stimulus >= 1e6) & (stimulus < 1e9))

plot(thousand$stimulus, thousand$xPosProportion, col=pal_col[thousand$outlier+1],
	xlim=c(0, 2e6), ylim=c(0, 1),
	xlab="Value", ylab="Proportion of line\n")
points(1e6+million$stimulus/1e3, million$xPosProportion, col=pal_col[million$outlier+1])

lines(loess.smooth(thousand$stimulus, thousand$xPosProportion, span=0.3), col=loess_col)
lines(loess.smooth(1e6+million$stimulus/1e3, million$xPosProportion, span=0.3), col=loess_col)

# thou_mod=glm(xPosProportion ~ stimulus, data=thousand)
# print(summary(thou_mod))
# mill_mod=glm(xPosProportion ~ stimulus, data=million)
# print(summary(mill_mod))

}


plot_subj_resp=function(df, x_str, y_str)
{
# if (df$sID < 180 | df$sID > 270)
#    return(NULL)
thousand=subset(df, stimulus < 1e6)
million=subset(df, (stimulus >= 1e6) & (stimulus < 1e9))

plot(thousand$stimulus, thousand$xPosProportion, col=point_col,
	xaxt="n", cex.axis=1.8, cex.lab=1.7,
        xlim=c(0, 2e6), ylim=c(0, 1),
        xlab="", ylab=y_str)
axis(1, at=c(0, 5e5, 1e6, 1.5e6, 2e6), cex.axis=1.35,
	labels=c("0", "500\nThousand", "Million", "500\nMillion", "Billion"))
points(1e6+million$stimulus/1e3, million$xPosProportion, col=point_col)

text(5e5, 0.9, paste0("Subject ", df$sID[1]), cex=1.8)

lines(loess.smooth(thousand$stimulus, thousand$xPosProportion, span=0.3), col=pal_col[2])
lines(loess.smooth(1e6+million$stimulus/1e3, million$xPosProportion, span=0.3), col=pal_col[3])
}


subj_outlier=function(df)
{
thousand=subset(df, stimulus < 1e6)
million=subset(df, (stimulus >= 1e6) & (stimulus < 1e9))

thou_mod=glm(xPosProportion ~ stimulus, data=thousand)
# thou_mod=loess(xPosProportion ~ stimulus, data=thousand)
pred=predict(thou_mod)
thousand$outlier=abs(thousand$xPosProportion-pred)/pred > 0.5

plot(thousand$stimulus, thousand$xPosProportion, col=pal_col[thousand$outlier+1],
        xlim=c(0, 2e6), ylim=c(0, 1),
        xlab="Value", ylab="Proportion of line\n")
points(1e6+million$stimulus/1e3, million$xPosProportion, col=pal_col[thousand$outlier+1])

lines(loess.smooth(thousand$stimulus, thousand$xPosProportion, span=0.3), col=loess_col)
lines(loess.smooth(1e6+million$stimulus/1e3, million$xPosProportion, span=0.3), col=loess_col)

mill_mod=glm(xPosProportion ~ stimulus, data=million)
# mill_mod=loess(xPosProportion ~ stimulus, data=million)
pred=predict(mill_mod)
million$outlier=abs(million$xPosProportion-pred)/pred > 0.5

return(rbind(thousand, million))
}

plot_layout(2, 2, max_width=6.5, max_height=6.5)
par(mar=c(1.2, 4.4, 0, 0.0))

pal_col=rainbow(3)

# block: stimuli were presented in random order, but split into blocks.  All the items in block m were presented before any in block m+1.
# index: a number corresponding to the specific stimulus item
# age: participant age, in years
# sID: a random subject number.
# stimulus: the numerical value of the presented stimulus
# xPos: the literal position of the mouse click on the item.
# rt: the response time in milliseconds
# sex: obvious
# mathField: Did the participant report working in a mathematically sophisticated domain?
# xPosProportion: the proportion of the line to the left of the mouse click. in the original image, the line runs from x value 55 to 456, so this is (xPos-55)/(456-55).
# 
val_pos=read.csv(paste0(ESEUR_dir, "developers/Landy_TML-19-rwise.tsv.xz"), as.is=TRUE, sep="\t")

val_pos$outlier=FALSE

numeric=subset(val_pos, condition == 2)
hybrid=subset(val_pos, condition == 1)

plot_subj_resp(subset(numeric, sID == 5), "", "Proportion of Line\n")
plot_subj_resp(subset(numeric, sID == 45), "Value", "Proportion of Line\n")
plot_subj_resp(subset(numeric, sID == 147), "", "")
plot_subj_resp(subset(numeric, sID == 155), "Value", "")

# 5, 17 35 45 52 147 155

# plot(hybrid$xPos, hybrid$stimulus, log="y",
# 	xlab="Value", ylab="Proportion of line")

# plot(numeric$stimulus, numeric$xPosProportion, log="x",
# 	xlab="Value", ylab="Proportion of line\n")
# plot(hybrid$stimulus, hybrid$xPosProportion, log="x",
# 	xlab="Value", ylab="Proportion of line\n")

# clean_num=ddply(numeric, .(sID), subj_outlier)
# clean_hyb=ddply(hybrid, .(sID), subj_outlier)
# 
# lin_log(clean_num)
# lin_log(clean_hyb)

