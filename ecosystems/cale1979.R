#
# cale1979.R,  6 Jun 19
# Data from:
# Price/Performance Patterns of {U.S.} Computer Systems
# E. G. Cale and L. L. Gremillion and J. L. McKenney
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG storage_memory computer_cost 1970 hardware perforance


source("ESEUR_config.r")


library("plyr")


fit_mod=function(df)
{
if (nrow(df) < 2)
   return(NULL)
m_mod=glm(log(Memory.K) ~ log(Price..000), data=df)
# summary(m_mod)

pred=predict(m_mod, newdata=data.frame(Price..000=p_range))
lines(p_range, exp(pred), col=pal_col[df$Year[1]-1969])
}

price_mem=function(df)
{
points(df$Price..000, df$Memory.K, col=pal_col[df$Year[1]-1969])

# fit_mod(df)
}


cale=read.csv(paste0(ESEUR_dir, "ecosystems/cale1979.csv.xz"), as.is=TRUE)
cale$l_DASD=log(cale$DASD.M+1e-2)

pal_col=rainbow(length(unique(cale$Year)))

GP=subset(cale, Kind == "General purpose")

plot(cale$Price..000, cale$Memory.K, type="n", log="xy",
	xlab="Price ($thousand)", ylab="Memory (KB)\n")

p_range=exp(seq(1.5, 8.5, 0.1))

d_ply(cale, .(Year), price_mem)

fit_mod(subset(cale, Year == 1971))
fit_mod(subset(cale, Year == 1974))
fit_mod(subset(cale, Year == 1977))

legend(x="bottomright", legend=paste0(1978:1970), bty="n", fill=rev(pal_col), cex=1.2)

# m_mod=glm(log(Memory.K) ~ log(Price..000), data=GP)
# # summary(m_mod)
# 
# pred=predict(m_mod, newdata=data.frame(Price..000=p_range))
# lines(p_range, exp(pred), col=pal_col[1])

# x_range=seq(-1.5, log(9600), by=0.05)
# 
# m_mod=glm(log(Memory.K) ~ l_DASD+I(l_DASD^2), data=GP)
# summary(m_mod)
# 
# pred=predict(m_mod, newdata=data.frame(l_DASD=x_range))
# lines(exp(x_range), exp(pred))


