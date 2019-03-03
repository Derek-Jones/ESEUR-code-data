#
# like-n-dis.R, 25 Feb 19
# Data from:
# The Sources and Consequences of the Fluent Processing of numbers
# Dan King and Chris Janiszewski
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment human number like dislike

source("ESEUR_config.r")


plot_layout(2, 1)


lnd=read.csv(paste0(ESEUR_dir, "developers/like-n-dis.csv.xz"), as.is=TRUE)

plot(lnd$Number, lnd$Like, type="l", col=point_col,
	xaxs="i",
	xlab="Number", ylab="Like\n")
lines(loess.smooth(lnd$Number, lnd$Like, span=0.3), col=loess_col)


spectrum(lnd$Like, main="Spectrum density", sub="", col=point_col,
		xlab="Frequency", ylab="Density\n")

# spectrum(lnd$Dislike)

# spectrum(lnd$Neutral)

lnd$l_0=grepl("0$", lnd$Number)
lnd$l_1=grepl("1$", lnd$Number)
lnd$l_2=grepl("2$", lnd$Number)
lnd$l_3=grepl("3$", lnd$Number)
lnd$l_4=grepl("4$", lnd$Number)
lnd$l_5=grepl("5$", lnd$Number)
lnd$l_6=grepl("6$", lnd$Number)
lnd$l_7=grepl("7$", lnd$Number)
lnd$l_8=grepl("8$", lnd$Number)
lnd$l_9=grepl("9$", lnd$Number)
lnd$f_1=grepl("^1", lnd$Number)
lnd$f_2=grepl("^2", lnd$Number)
lnd$f_3=grepl("^3", lnd$Number)
lnd$f_4=grepl("^4", lnd$Number)
lnd$f_5=grepl("^5", lnd$Number)
lnd$f_6=grepl("^6", lnd$Number)
lnd$f_7=grepl("^7", lnd$Number)
lnd$f_8=grepl("^8", lnd$Number)
lnd$f_9=grepl("^9", lnd$Number)

like_mod=glm(Like ~ log(Number)+
			(l_0+
			# l_1+
			l_2+
			# l_3+
			l_4+l_5+
                        l_6+
			# l_7+
			l_8)
			# +l_9
			+(
			# f_1+
			# f_2+
			f_3+
			f_4+f_5+
                        f_6+
			f_7
			# +f_8
			# +f_9
			)
			, data=lnd)
summary(like_mod)

dislike_mod=glm(Dislike ~ log(Number)+
			(l_0+
			# l_1+
			l_2+
			# l_3+
			l_4+l_5+
                        l_6+
			# l_7+
			l_8)
			# +l_9
			+(
			# f_1+
			# f_2+
			f_3+
			f_4+f_5+
                        f_6+
			f_7
			# +f_8
			# +f_9
			)
			, data=lnd)
summary(dislike_mod)

