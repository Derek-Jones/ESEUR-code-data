#
# educators.R, 25 May 20
# Data from:
# Novice {Java} Programming Mistakes: {Large}-Scale Data vs. Educator Beliefs
# Neil C. C. Brown and Amjad Altadmri
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG student_mistake educator_belief

source("ESEUR_config.r")


library("PlackettLuce")


pal_col=rainbow(7)

ed=read.csv(paste0(ESEUR_dir, "reliability/educators.csv.xz"), as.is=TRUE)

plot(sort(ed$A1Confusingtheassignmentoperator), col=pal_col[1], type="l")
lines(sort(ed$B1Useofinsteadof.equalstocompar), col=pal_col[2])
lines(sort(ed$C1Unbalancedparenthesescurlybrackets), col=pal_col[3])
lines(sort(ed$E1Incorrectsemicolonafteranifselec), col=pal_col[4])
lines(sort(ed$F1Wrongseparatorsinforloopsusingc), col=pal_col[5])
lines(sort(ed$G1Insertingtheconditionofanifstate), col=pal_col[6])
lines(sort(ed$H1Usingkeywordsasmethodnamesorvari), col=pal_col[7])

# Pull out existing ranks
p_ranks=with(ed,
		data.frame(A1R=A1Rank, B1R, C1R, D1R, E1R, F1R, G1R, H1R,
				I1R, J1R, K1R, L1R, M1R, N1R, O1R, P1R,
				Q1R, R1R))

# Using the full dataset takes a while, and qvcalc swaps a LOT in 16G
t=as.rankings(p_ranks[1:35,])
p_mle = PlackettLuce(t, nspseudo=0)

beta=coef(p_mle)
beta=beta[order(beta, decreasing=TRUE)]

beta

# Error in X %*% as.vector(coefs) : 
# Cholmod error 'X and/or Y have wrong dimensions' at file ../MatrixOps/cholmod_sdmult.c, line 90
t=qvcalc(p_mle)
plot(t)

