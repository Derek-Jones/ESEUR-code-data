#
# impl-sim.R, 16 May 17
# Data from:
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG example simulation-discrete_event


source("ESEUR_config.r")


library(gamlss.tr)
library("simmer")

# Create a zero truncated Poisson distribution
gen.trun(family=PO)

max_dev=10
max_steps=20

env=simmer("impl_env")

# Need to model variably sized features where a decision is
# made about how many developers are needed and then calculate
# how many days are needed (with some amount of variability).

feature=trajectory("feature imp") %>%
	set_attribute("num_dev", function() rPOtr(1, 2)) %>%
	seize("developer", function(attrs) attrs[["num_dev"]]) %>%
	timeout(function() rPOtr(1, 2)) %>%
	release("developer", function(attrs) attrs[["num_dev"]])

# Add new features at each timestep, to keep the queue full
# Some will get rejected because there are not enough developers
# available, so we need to generate more than are necessary.
env %>%
	add_resource("developer", max_dev) %>%
	add_generator("feature imp", feature, at(rep(0:max_steps, each=max_dev)))

env %>%
	reset() %>%
	run(until=max_steps)

env %>%
	get_mon_arrivals

env %>%
	get_mon_resources


