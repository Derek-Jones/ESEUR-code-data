#
# skyscraper.R, 21 Mar 19
# Data from:
# nintil.com/2018/10/07/building-skyscrapers-and-spending-on-major-projects
# Jose Luis Recon
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG construction project-time

source("ESEUR_config.r")


library("plyr")


mean_sd_year=function(df)
{
return(data.frame(mean=mean(df$Construction.Years),
                  sd=sd(df$Construction.Years)))
}


mean_sd_m_per_year=function(df)
{
df$m_per_year=df$Height..m./df$Construction.Years
return(data.frame(mean=mean(df$m_per_year),
                  sd=sd(df$m_per_year)))
}


sk=read.csv(paste0(ESEUR_dir, "projects/skyscraper.csv.xz"), as.is=TRUE)

# Remove skyscrapers built using BSB's prefabricated module approach
sk=subset(sk, Construction.Years >= 1)

# sk$Construction.Years_1=as.numeric(sub(",", ".", sk$Construction.Years))
# sk$HPY_1=as.numeric(sub(",", ".", sk$HPY))
# sk$Height..m._1=as.numeric(sub(",", ".", sk$Height..m.))
# sk$Height..ft._1=as.numeric(sub(",", ".", sk$Height..ft.))
# 
# sk$Construction.Years=sk$Construction.Years_1
# sk$HPY=sk$HPY_1
# sk$Height..m.=sk$Height..m._1
# sk$Height..ft.=sk$Height..ft._1
# 
# sk$Construction.Years_1=NULL
# sk$HPY_1=NULL
# sk$Height..m._1=NULL
# sk$Height..ft._1=NULL


m_year_mean=ddply(sk, .(Started), mean_sd_m_per_year)

plot(m_year_mean$Started, m_year_mean$mean, col=point_col,
	xlim=c(1960, 2016),
	xlab="Year started", ylab="Rate of construction (meter/year)\n")

arrows(m_year_mean$Started, m_year_mean$mean,
                m_year_mean$Started, m_year_mean$mean-m_year_mean$sd, col=point_col,
                length=0.1, angle=90, lwd=1.3)
arrows(m_year_mean$Started, m_year_mean$mean,
                m_year_mean$Started, m_year_mean$mean+m_year_mean$sd, col=point_col,
                length=0.1, angle=90, lwd=1.3)


