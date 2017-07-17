#
# bolz_data_struct_racket.R, 18 May 17
# Data from:
# Record Data Structures in Racket Usage Analysis and Optimization
# Tobias Pape and Carl Friedrich Bolz and Vasily Kirilichev and Robert Hirschfeld
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("gamlss")
library("gamlss.tr")


pal_col=rainbow(6)


o_struct=read.csv(paste0(ESEUR_dir, "probability/bolz_data_struct_racket.csv.xz"), as.is=TRUE)

struct=subset(o_struct, size < 15)

pos_struct=subset(struct, size > 0)

plot(struct$size, struct$fields, type="b", col=pal_col[1],
	xlim=c(0, 12), ylim=c(1, 520),
	xlab="Size", ylab="Fields\n")

xbounds=0:15

all_sizes=rep(struct$size, times=struct$fields)
pos_sizes=rep(pos_struct$size, times=pos_struct$fields)

zi_mod=gamlss(all_sizes ~ 1, family=ZIP)
summary(zi_mod)

lines(xbounds, length(all_sizes)*dZIP(x=xbounds, mu=exp(coef(zi_mod, what="mu")),
	   sigma=exp(coef(zi_mod, what="sigma"))), col=pal_col[2])


zi2_mod=gamlss(all_sizes ~ 1, family=ZIP2)
summary(zi2_mod)

lines(xbounds, length(all_sizes)*dZIP2(x=xbounds, mu=exp(coef(zi2_mod, what="mu")),
	   sigma=exp(coef(zi2_mod, what="sigma"))), col=pal_col[3])

za_mod=gamlss(all_sizes ~ 1, family=ZAP)
summary(za_mod)

lines(xbounds, length(all_sizes)*dZAP(x=xbounds, mu=exp(coef(za_mod, what="mu")),
	   sigma=exp(coef(za_mod, what="sigma"))), col=pal_col[4])


gen.trun(par=0, family=PO)

tr_mod=gamlss(pos_sizes ~ 1, family=POtr)
summary(tr_mod)

xbounds=1:15

lines(xbounds, length(pos_sizes)*dPOtr(x=xbounds, mu=exp(coef(tr_mod, what="mu"))),
		 col=pal_col[5])


gen.trun(par=1, family=EXP)
one_struct=subset(struct, size > 1)
one_sizes=rep(one_struct$size, times=one_struct$fields)

tr_mod=gamlss(one_sizes ~ 1, family=EXPtr)
summary(tr_mod)

xbounds=2:15

lines(xbounds, length(one_sizes)*dEXPtr(x=xbounds, mu=exp(coef(tr_mod, what="mu"))),
		 col=pal_col[6])




