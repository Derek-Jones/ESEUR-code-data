#
# lee2006.R, 13 Oct 14
#
# Data from:
# Regression Modeling Strategies for Microarchitecture Performance and Power Prediction
# Benjamin C. Lee and David M. Brooks
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("mgcv")

lee=read.csv(paste0(ESEUR_dir, "regression/lee2006.csv.xz"), as.is=TRUE, sep="\t")

# Taken from script associated with data
lee$sec = 1.1 * lee$cycle * 18 / lee$depth
lee$bips = lee$inst / lee$sec

l_mod=gam(sqrt(bips) ~ benchmark
                   + fix_lat
                   + s(depth, k=4)
                   + s(gpr_phys, k=10)
                   + s(br_resv, k=6)
                   + s(dmem_lat, k=10)
                   + s(fpu_lat, k=6)
                   + s(l2cache_size, k=5)
                   + s(icache_size, k=3)
                   + s(dcache_size, k=3)
                   + s(depth, by=width, k=6)
                   + s(depth, gpr_phys, k=10)
                   + s(gpr_phys, by=width, k=10)
		   , data=lee
                   )


# The following is closer the the model proposed by Lee and Brooks
l_mod_a=gam(sqrt(bips) ~ benchmark
		   ## first-order effects
                   + s(depth, k=4)
                   + width
                   + s(gpr_phys, k=10)
                   + s(br_resv, k=6)
                   + s(dmem_lat, k=10)
                   + fix_lat
                   + s(fpu_lat, k=6)
                   + s(l2cache_size, k=5)
                   + s(icache_size, k=3)
                   + s(dcache_size, k=3)

                   ## second-order effects
                   ## interactions of pipe dimensions and
                   ## in-flight resources
                   # + s(depth, by=width, k=6)
                   # + s(depth, gpr_phys, k=10)
                   + s(gpr_phys, by=width, k=10)

                   ## interactions of depth and hazards
                   # + s(icache_size, by=width, k=5)
                   # + s(depth, dcache_size, k=11)
                   # + s(depth, l2cache_size, k=12)

                   ## interactions in memory hiearchy
                   # + s(icache_size, l2cache_size, k=5)
                   # + s(dcache_size, l2cache_size, k=5)
		   , select=TRUE
		   , data=lee
                   )

summary(l_mod_a)

anova(l_mod, l_mod_a, test="F")

