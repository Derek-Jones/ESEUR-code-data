#
# passmark-ram.R,  8 Apr 20
#
# Data from:
# www.passmark.com
# David Wren
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG benchmark_memory computer_memory end-user


source("ESEUR_config.r")


pal_col=rainbow(2)


# BaselineId,module type,part density,DDR,number modules,revision,speed,CAS latency,extras,RAM Size,CPU Company,CPU Name,CPU speed,Read Speed MB/Sec
mp=read.csv(paste0(ESEUR_dir, "benchmark/passmark-ram.csv.xz"), as.is=TRUE)

t=(mp$part.density < 100)
mp$part.density[t]=mp$part.density[t]*1024

brew_col=rainbow_hcl(3)


t=subset(mp, CPU.Name == "Core i7-3770K")
t$CPU.Name=NULL
t$CPU.speed=NULL
t$CPU.Company=NULL
t$DDR=NULL
t$module.type=NULL

q=t[order(t$Read.Speed.MB.Sec), ]

# 13800 and 18000 picked by 'eye'
t_middle=subset(q, Read.Speed.MB.Sec > 13800 & Read.Speed.MB.Sec < 18000)

q$Read.Speed.GB.Sec=q$Read.Speed.MB.Sec/1024
plot(q$Read.Speed.GB.Sec, col=pal_col[2],
	xaxs="i",
	xlab="Sorted order", ylab="Read speed (GB/sec)\n")

# Pick offset in the middle of the data
# q$Read.Speed.GB.Sec[trunc(nrow(q)/2)] # 14.8417

# Map sorted order to 0..1, except have to start just above 0
frac_ord=seq(1/nrow(q), 1, by=1/(1+nrow(q)))

# Fit a general logit
rd_mod =nls(Read.Speed.GB.Sec ~ 14.8+a*log((b-frac_ord)/(c*frac_ord)),
		trace=FALSE,
		start=list(a=14.8, b=1, c=1), data=q)
# summary(rd_mod)
pred=predict(rd_mod)
lines(pred, col=pal_col[1])

# plot(t$Read.Speed.MB.Sec ,  t$number.modules)

# plot(t_middle$speed, t_middle$Read.Speed.MB.Sec)
# plot(t_middle$CAS.latency, t_middle$Read.Speed.MB.Sec)
# speed_range=1:12
# 
# loess_mod=loess(Read.Speed.MB.Sec ~ CAS.latency, data=t_middle)
# loess_pred=predict(loess_mod, newdata=data.frame(CAS.latency=speed_range))
# lines(speed_range, loess_pred, col="green")
# 
# t_middle$revision=NULL
# t_middle$extras=NULL
# 
# t_scale=data.frame(scale(t_middle, center=FALSE)*100)
# 
# t_mod=glm(Read.Speed.MB.Sec ~  speed+CAS.latency+RAM.Size
# 				+I(speed*CAS.latency^2),
# 				data=t_middle, family=quasipoisson)
# 
# t_pred=predict(t_mod, se.fit=TRUE, type="response")
# 
# plot(t_middle$Read.Speed.MB.Sec, type="l", col=pal_col[1],
# 	xlim=c(1, nrow(t_middle)), ylim=c(13500, 18000),
# 	xlab="Sorted order", ylab="Read speed (MB/sec)\n")
# points(t_pred$fit, col=pal_col[2])
# 
