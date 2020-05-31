#
# clone_surv.R, 24 May 20
# Data from:
# Toward improved understanding and management of software clones
# Wei Wang
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG clone_survival


source("ESEUR_config.r")


library("plyr")
library("survival")


ver_start_end_day=function(df)
{
end_pos=which(df$end_ver == rev_date$Version)

t=cbind(start_day=rev_date$Release_date[which(df$start_ver == rev_date$Version)],
#        end_day=max(rev_date$Release_date[end_pos], rev_date$Release_date[1+end_pos]))
        end_day=rev_date$Release_date[1+end_pos])

return(t)
}



clone=read.csv(paste0(ESEUR_dir, "ecosystems/clone/survival.csv.xz"), as.is=TRUE)

pal_col=rainbow(3)

rev_date=read.csv(paste0(ESEUR_dir, "regression/Linux-days.csv.xz"), as.is=TRUE)

# Add column giving number of days since first release
rev_date$Release_date=as.Date(rev_date$Release_date, format="%d-%b-%Y")

t=adply(clone, 1, ver_start_end_day)


clone_surv=Surv(t$end_day-t$start_day, event=t$end_ver != "2.6.32.7")
clone_mod=survfit(clone_surv ~ 1, subset=t$clone_type==1)

plot(clone_mod, col=pal_col[1],
	xaxs="i", yaxs="i",
	xlim=c(1, 5500), ylim=c(0, 1),
	xlab="Days", ylab="Clone survival\n")

clone_mod=survfit(clone_surv ~ 1, subset=t$clone_type==2)

lines(clone_mod, col=pal_col[2])


clone_mod=survfit(clone_surv ~ 1, subset=t$clone_type==3)

lines(clone_mod, col=pal_col[3])

legend(x="topright", legend=c("Type 1", "Type 2", "Type 3"),
			bty="n", fill=pal_col, cex=1.3)

