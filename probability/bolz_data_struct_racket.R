#
# bolz_data_struct_racket.R, 17 Jan 19
# Data from:
# Record Data Structures in Racket Usage Analysis and Optimization
# Tobias Pape and Carl Friedrich Bolz and Vasily Kirilichev and Robert Hirschfeld
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG racket data-structure fields


source("ESEUR_config.r")


library("COMPoissonReg")
library("gamlss")
library("gamlss.tr")


pal_col=rainbow(3)


o_struct=read.csv(paste0(ESEUR_dir, "probability/bolz_data_struct_racket.csv.xz"), as.is=TRUE)

struct=subset(o_struct, size < 15)

pos_struct=subset(struct, size > 0)

# plot(struct$size, struct$fields, type="b", col=pal_col[1],
# 	xlim=c(0, 12), ylim=c(1, 520),
# 	xlab="Fields", ylab="Structure types\n")

all_sizes=rep(struct$size, times=struct$fields)
pos_sizes=rep(pos_struct$size, times=pos_struct$fields)

# Negative binomial, type I
nbi_mod=gamlss(all_sizes ~ 1, family=NBI)

nbi_pred=sapply(0:12, function(y) length(all_sizes)*
                        dNBI(y, mu=exp(coef(nbi_mod, what="mu")),
                                sigma=exp(coef(nbi_mod, what="sigma"))))

# COM-Poisson
cmp_mod=glm.cmp(all_sizes ~ 1, formula.nu=all_sizes~1, beta.init=2.0)
# summary(cmp_mod)
 
cmp_pred=sapply(0:12, function(y) length(all_sizes)*
                        dcmp(y, lambda=exp(cmp_mod$beta),
                                nu=exp(cmp_mod$gamma)))

plot(struct$size, struct$fields, log="y", col=pal_col[1],
        xlab="Fields", ylab="Structure types\n")
# 
lines(0:12, cmp_pred, col=pal_col[2])
lines(0:12, nbi_pred, col=pal_col[3])


