#
# Butts_Nasa.R, 15 May 16
# Data from:
#
# Costs and Schedules from:
# NASA's Joint Confidence Level Paradox: A History of Denial
# Glenn Butts and Kent Linton
#
# Launch dates from: claudelafleur.qc.ca/Spacecrafts-index.html
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

plot_sat=function(df)
{
mod=glm(Latest.Cost ~ Launch.date, data=df)
pred=predict(mod)
lines(df$Launch.date, pred, col=pal_col[c_cnt])

points(df$Launch.date, df$Latest.Cost, col=pal_col[c_cnt])

c_cnt <<- c_cnt+1
}


butts=read.csv(paste0(ESEUR_dir, "introduction/Butts_Nasa.csv"), as.is=TRUE)
butts$Name=tolower(butts$Name)

spacecraft=read.csv(paste0(ESEUR_dir, "introduction/spacecraft.csv"), as.is=TRUE)

spacecraft$Launch.date=as.Date(spacecraft$Launch.date, format="%d %b %y")

spacecraft$Spacecraft=tolower(spacecraft$Spacecraft)

spacecraft$Spacecraft=sub(" / .*", "", spacecraft$Spacecraft)

t=merge(butts, spacecraft, by.x="Name", by.y="Spacecraft")

# Final.Schedule has 74 entries
# Latest.Cost has 45 entries
sat_cost=subset(t, !is.na(Latest.Cost))

plot(sat_cost$Launch.date, sat_cost$Latest.Cost, type="n", log="y")

pal_col=rainbow(5)
c_cnt=0

d_ply(sat_cost, .(Theme), plot_sat)

mod=glm(Latest.Cost ~ Launch.date, data=sat_cost)
pred=predict(mod)
lines(sat_cost$Launch.date, pred, col="black")

