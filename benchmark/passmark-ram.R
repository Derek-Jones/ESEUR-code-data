#
# passmark-ram.R,  2 Dec 15
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")

plot_layout(1, 2)

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

plot(q$Read.Speed.MB.Sec, col=point_col,
	xlab="Sorted order", ylab="Read speed (MB/sec)\n")

# plot(t$Read.Speed.MB.Sec ,  t$number.modules)

# plot(t_middle$speed, t_middle$Read.Speed.MB.Sec)
# plot(t_middle$CAS.latency, t_middle$Read.Speed.MB.Sec)
# speed_range=1:12
# 
# loess_mod=loess(Read.Speed.MB.Sec ~ CAS.latency, data=t_middle)
# loess_pred=predict(loess_mod, newdata=data.frame(CAS.latency=speed_range))
# lines(speed_range, loess_pred, col="green")

t_middle$revision=NULL
t_middle$extras=NULL

t_scale=data.frame(scale(t_middle, center=FALSE)*100)

t_mod=glm(Read.Speed.MB.Sec ~  speed+CAS.latency+RAM.Size
				+I(speed*CAS.latency^2),
				data=t_middle, family=quasipoisson)

t_pred=predict(t_mod, se.fit=TRUE, type="response")

plot(t_middle$Read.Speed.MB.Sec, col=point_col,
	xlim=c(1, nrow(t_middle)), ylim=c(13500, 18000),
	xlab="Sorted order", ylab="Read speed (MB/sec)\n")
points(t_pred$fit, col="red")

