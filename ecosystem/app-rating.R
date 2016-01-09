#
# app-rating.R, 14 May 15
#
# Data from:
# API Change and Fault Proneness: A Threat to the Success of Android Apps
# Mario Linares-V{\'a}squez and Gabriele Bavota and Carlos Bernal-C{\'a}rdenas and Massimiliano {Di Penta} and Rocco Oliveto and Denys Poshyvanyk
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


# AppName,Bugs,ChangedM,ChangedPM,MwithSignatureModified,PMwithSignatureModified,MwithChangesInExceptions,PMwithChangesInExceptions,Votes,Star1Votes,Star2Votes,Star3Votes,Star4Votes,Star5Votes,mean
app_info=read.csv(paste0(ESEUR_dir, "ecosystem/app-rating.csv.xz"), as.is=TRUE)

brew_col=rainbow_hcl(3)

plot_votes=function(x_vals, y_vals, log_str="", err_family=quasipoisson)
{

plot(x_vals, y_vals, log=log_str)

a_mod=glm(y_vals ~ x_vals, family=err_family)

xbounds=seq(min(x_vals), max(x_vals), (max(x_vals)-min(x_vals))/100)
lines(xbounds, predict(a_mod, newdata=data.frame(x_vals=xbounds),
		type="response"), col="red")

lines(loess.smooth(x_vals, y_vals, span=0.3), col="green")

return(a_mod)
}

pop_app=subset(app_info, mean > 0)

t=plot_votes(pop_app$mean, pop_app$Votes, "y")

t=plot_votes(pop_app$mean, pop_app$Bugs, "xy")
# Impact of bugs on mean rating
t=plot_votes(pop_app$Bugs+0.01, pop_app$mean, "xy", gaussian)

t=plot_votes(pop_app$Votes, pop_app$Bugs, "xy")

t=plot_votes(pop_app$mean, pop_app$ChangedM, "y")
t=plot_votes(pop_app$Votes, pop_app$ChangedM, "xy")

t=plot_votes(pop_app$mean, pop_app$ChangedPM, "y")
t=plot_votes(pop_app$Votes, pop_app$ChangedPM, "xy")


pairs(~ log(Bugs)+ChangedM+log(ChangedPM)+Star3Votes+log(Star4Votes)+Star5Votes,
		data=app_info)

