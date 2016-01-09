#
# struct-10_of_4-2-2.R, 11 Mar 13
#
# See:
# Developer characterization of data structure fields decisions
# Derek M. Jones
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

plot_layout(1, 2)

# Probability of encountering a given percentage of struct types,
# each containing four members with grouped types.
# A total of one hundred such definitions is assumed.

plot(dbinom(0:100, 100, 1/3), type="l", log="y", col="red",
      xlab="Number of occurrences", ylab="Probability")

# Use of point probabilities can be misleading and a better alternative is
# to show the probability that the number of struct types is greater
# than or equal to some value.

plot(pbinom(0:100, 100, 1/3, lower.tail=FALSE), type="l", log="y", col="red",
      xlab="Occurs more often than", ylab="Probability")

