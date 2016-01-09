#
# grp-data-boot.R, 21 Apr 15
#
# Modified version of code appearing in:
# Circular statistics in R
# Pewsey, Neuhauser and Ruxton
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

UGsqMonTotalsBoot = function (montotals, B)
{
nmon = 12 ; mons = 1:nmon
daysmon = c(31,28,31,30,31,30,31,31,30,31,30,31)
daysyear = rep(mons, daysmon)
n = sum(montotals)
Pval = daysmon/365
Eval = Pval*n

   UGsq = function (mtots)
   {
   Dval = mtots - Eval
   Sval = cumsum(Dval) ; Sbar = sum(Pval*Sval)
   tstat = sum((Sval-Sbar)*(Sval-Sbar)*Pval)/n
   return(tstat)
   }

tstat = UGsq(montotals)
nxtrm = 1
for (b in 2:(B+1))
   {
   udays = sample(daysyear, size=n, replace = TRUE)
#   umontot = 0 ; for (j in 1:nmon) {umontot[j] = 0}
   umontot=rep(0, nmon)
#   for (j in 1:n) { umontot[udays[j]] = umontot[udays[j]]+1 }
   t=table(udays)
   umontot[as.numeric(names(t))]=t
   tstat[b] = UGsq(umontot)
   if (tstat[b] >= tstat[1]) {nxtrm = nxtrm + 1}
   }
pval = nxtrm/(B+1) 
return(list(pval, tstat))
}


UGsqWeekTotalsBoot = function (day_totals, B)
{
nday = 7 ; days = 1:nday
hrsday = rep(24, 7)
hrsweek = rep(days, hrsday)
n = sum(day_totals)
Pval = hrsday/(24*7)
Eval = Pval*n

   UGsq = function (mtots)
   {
   Dval = mtots - Eval
   Sval = cumsum(Dval) ; Sbar = sum(Pval*Sval)
   tstat = sum((Sval-Sbar)*(Sval-Sbar)*Pval)/n
   return(tstat)
   }

tstat = UGsq(day_totals)
nxtrm = 1
for (b in 2:(B+1))
   {
   udays = sample(hrsweek, size=n, replace = TRUE)
#   umontot = 0 ; for (j in 1:nday) {umontot[j] = 0}
   umontot=rep(0, nday)
#   for (j in 1:n) { umontot[udays[j]] = umontot[udays[j]]+1 }
   t=table(udays)
   umontot[as.numeric(names(t))]=t
   tstat[b] = UGsq(umontot)
   if (tstat[b] >= tstat[1]) {nxtrm = nxtrm + 1}
   }
pval = nxtrm/(B+1) 
return(list(pval, tstat))
}

