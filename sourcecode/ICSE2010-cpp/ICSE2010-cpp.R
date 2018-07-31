#
# ICSE2010-cpp.R,  5 Jul 18
#
# Data from:
# An Analysis of the Variability in Forty Preprocessor-Based Software Product Line
# J\"{o}rg Liebig and Sven Apel and Chritian Lengauer and Christian K\"{a}stner and Michael Schulze
#
# Example from:
# EVidence-based Software Engineering using R
# Derek M. Jones
#
# TAG C conditional-compilation  LOC


source("ESEUR_config.r")


library("plyr")


pal_col=rainbow(2)

merge_csv=function(file_str)
{
t=read.csv(paste0(dir_str, file_str), as.is=TRUE)

return(data.frame(loc=sum(t$loc, na.rm=TRUE), nofc=sum(t$nofc, na.rm=TRUE)))
}

dir_str=paste0(ESEUR_dir, "sourcecode/ICSE2010-cpp/")
top_files=list.files(dir_str)
top_files=subset(top_files, grepl("csv.xz", top_files))

c_loc_nofc=adply(top_files, 1, merge_csv)
c_loc_nofc$log_loc=log(c_loc_nofc$loc)

plot(c_loc_nofc$loc, c_loc_nofc$nofc, log="xy", col=pal_col[1],
	xlab="LOC", ylab="Feature constants\n")

# lines(loess.smooth(c_loc_nofc$loc, c_loc_nofc$nofc, span=0.3), col="yellow")

c_log_mod=glm(log(nofc) ~ log_loc, data=c_loc_nofc)
summary(c_log_mod)

x_loc=log(min(c_loc_nofc$loc)):(1+log(max(c_loc_nofc$loc)))
c_pred=predict(c_log_mod, newdata=data.frame(log_loc=x_loc), se.fit=TRUE)

lines(exp(x_loc), exp(c_pred$fit), col=pal_col[2])
#lines(exp(x_loc), exp(c_pred$fit+1.96*c_pred$se.fit), col=pal_col[3])
#lines(exp(x_loc), exp(c_pred$fit-1.96*c_pred$se.fit), col=pal_col[3])


