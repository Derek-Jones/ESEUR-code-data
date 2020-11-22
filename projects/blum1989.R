#
# blum1989.R, 14 Jun 20
# Data from:
# Improving Software Maintenance by learning from the Past: {A} Case Study
# Bruce I. Blum
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG evolution program_evolution database_program

source("ESEUR_config.r")


library("plyr")
library("survival")


pal_col=rainbow(2)


add_prog_updates=function(X)
{
# Go through each row, first and last column not of interest
y_upd=t(bl[X, -c(1, ncol(bl))])
start_y=X-1 #1980 does not have number not modified in 1980

# Create vector of number of programs last modifie din a given year
years=rep((1:length(y_upd))-start_y, times=y_upd)

num_surv=tail(y_upd, 1) # The last entry is the number of the 'survivors'

# 1 in the year of last modification
surv=c(rep(1, length(years)-num_surv), rep(0, num_surv))

return(data.frame(years, surv))
}


bl=read.csv(paste0(ESEUR_dir, "projects/blum1989.csv.xz"), as.is=TRUE)

bl[is.na(bl)]=0 # rep does not like NAs as a value for times


# Process each row, the evolution of programs created in a given year
progs=adply(1:nrow(bl), 1, add_prog_updates)

prog_surv=Surv(progs$years, event=(progs$surv == 1), type="right")
prog_mod=survfit(prog_surv ~ 1)

plot(prog_mod, col=pal_col[c(1, 2, 2)], conf.int=TRUE,
        xaxs="i", yaxs="i",
        xlim=c(0,8), ylim=c(0, 0.8),
        xlab="Years", ylab="Still evolving\n")

