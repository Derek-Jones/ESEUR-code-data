#
# r-email-graph.R, 27 Aug 15
# Data from:
#
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("snatm")
library("tm")
library("tm.plugin.mail")

as.one.file(files, filename = "allthreads.txt.xz", list = "rdevel")

forest = makeforest(month = "allthreads")
head(forest)

removeCitation()
removeSignature()

ae-to-be()

wn.replace()

stemDocument()

termFreq()

tolower()


# does all four???
prepare.text()

# Perform on Author column of forest
find.aliases()


network = adjacency(createedges(forest))
network[1:2, 1:2]

