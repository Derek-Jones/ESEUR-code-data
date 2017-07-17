#
# var-len.R, 29 May 17
# Meaningful Identifier Names: The Case of Single-Letter Variables
# Gal Beniamini Sarah Gingichashvili Alon Klein Orbach Dror G. Feitelson
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("VGAM")

plot_layout(3, 1)

pal_col=rainbow(2)

vlen=read.csv(paste0(ESEUR_dir, "probability/var-len.csv.xz"), as.is=TRUE)

len_30=subset(vlen, len < 30)

plot(vlen$len, vlen$C, type="b", col=pal_col[1],
	xlim=c(0, 12),
	xlab="Length", ylab="Occurrences\n")

xbounds=1:15

C_sizes=rep(len_30$len, times=len_30$C)

C_mod=vglm(C_sizes ~ 1, oipospoisson, trace = TRUE)
summary(C_mod)

C_coef=coef(C_mod, matrix=TRUE)

lines(xbounds, length(C_sizes)*doipospois(x=xbounds, lambda=exp(C_coef[2]), pstr1=logit(C_coef[1], inverse=TRUE)),
		 col=pal_col[2])


plot(vlen$len, vlen$Java, type="b", col=pal_col[1],
	xlim=c(0, 12),
	xlab="Length", ylab="Occurrences\n")

J_sizes=rep(len_30$len, times=len_30$Java)

J_mod=vglm(J_sizes ~ 1, oipospoisson, trace = TRUE)
summary(J_mod)

J_coef=coef(J_mod, matrix=TRUE)

lines(xbounds, length(J_sizes)*doipospois(x=xbounds, lambda=exp(J_coef[2]), pstr1=logit(J_coef[1], inverse=TRUE)),
		 col=pal_col[2])



plot(vlen$len, vlen$perl, type="b", col=pal_col[1],
	xlim=c(0, 12),
	xlab="Length", ylab="Occurrences\n")

P_sizes=rep(len_30$len, times=len_30$perl)

P_mod=vglm(P_sizes ~ 1, oipospoisson, trace = TRUE)
summary(P_mod)

P_coef=coef(P_mod, matrix=TRUE)

lines(xbounds, length(P_sizes)*doipospois(x=xbounds, lambda=exp(P_coef[2]), pstr1=logit(P_coef[1], inverse=TRUE)),
		 col=pal_col[2])


