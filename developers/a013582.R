#
# a013582.R, 15 May 18
# Data from:
# A MODEL OF HUMAN COGNITIVE BEHAVIOR IN WRITING CODE FOR COMPUTER PROGRAMS, VOL I
# Ruven Brooks
# 
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones
#
# TAG cognition debugging experiment LOC


source("ESEUR_config.r")


a013=read.csv(paste0(ESEUR_dir, "developers/a013582.csv.xz"), as.is=TRUE)
a013$position=1:nrow(a013)

plot(~ log(Writing)+log(Debugging)+log(Lines), data=a013)

# d_mod=glm(log(Debugging) ~ log(Lines), data=a013)
# There is a learning effect
d_mod=glm(log(Debugging) ~ log(position)*log(Lines)-log(Lines), data=a013)
summary(d_mod)

w_mod=glm(log(Lines) ~ log(Writing), data=a013)
summary(w_mod)

