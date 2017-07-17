#
# gldt.R, 22 May 16
#
# Data from:
# Andreas Lundqvist, Donjan Rodic
# http://futurist.se/gldt/
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("survival")


gldt=read.csv(paste0(ESEUR_dir, "ecosystems/gldt.csv.xz"), as.is=TRUE)

# Handle missing day of month by assuming day in the middle
gldt$Start=as.Date(paste0(gldt$Start, ".15"), format="%Y.%m.%d")
gldt$Stop=as.Date(paste0(gldt$Stop, ".15"), format="%Y.%m.%d")

# Remove entries that only include the year
gldt=subset(gldt, !is.na(gldt$Start))

end_date=as.Date("2012-10-23", format="%Y-%m-%d")


distrib_surv=Surv(as.numeric(end_date)-as.numeric(gldt$Start),
                 event=!is.na(gldt$Stop), type="right")

distrib_mod=survfit(distrib_surv ~ 1)

# plot(distrib_mod, col="red",
#         xlab="Days", ylab="Survival rate\n")

# table(gldt$Parent)

top_max=5
pal_col=rainbow(top_max)

top_10=head(sort(table(gldt$Parent), decreasing=TRUE), n=top_max)

gldt_top_10=subset(gldt, Parent %in% names(top_10))

top_10_surv=Surv(as.numeric(end_date)-as.numeric(gldt_top_10$Start),
                 event=!is.na(gldt_top_10$Stop), type="right")

top_10_mod=survfit(top_10_surv ~ gldt_top_10$Parent)

plot(top_10_mod, col=pal_col,
        xlab="Days", ylab="Survival rate\n")

legend(x="bottomleft", legend=names(top_10), bty="n", fill=pal_col, cex=1.3)

# length(which(!is.na(gldt$Namechange_1)))
# length(which(!is.na(gldt$Namechange_2)))

