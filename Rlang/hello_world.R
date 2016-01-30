#
# hello_world.R,  7 Jan 16
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

# Read the complete contents of a file

source("ESEUR_config.r")

the_data=read.csv("hello_world.csv")

plot(the_data)

# plot(apply(the_data, 1, charToRaw),
# 	xlab="Hello", ylab="World")

