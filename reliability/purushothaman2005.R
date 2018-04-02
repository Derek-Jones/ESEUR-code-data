#
# purushothaman2005.R, 11 Mar 18
# Data from:
# Toward Understanding the Rhetoric of Small Source Code Changes
# Ranjith Purushothaman and Dewayne E. Perry
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("betareg")


pal_col=rainbow(2)


line_err=read.csv(paste0(ESEUR_dir, "reliability/purushothaman2005.csv.xz"), as.is=TRUE)
line_err$Ins_frac=line_err$Inserted/100
line_err$Mod_frac=line_err$Modified/100

plot(line_err$Lines, line_err$Inserted, log="xy", col=pal_col[1],
	xlab="Lines", ylab="Fault percentage\n")
points(line_err$Lines, line_err$Modified, col=pal_col[2])

legend(x="bottomright", legend=c("Inserted", "Modified"), bty="n", fill=pal_col, cex=1.2)

I_mod=betareg(Ins_frac ~ log(Lines), data=line_err)
summary(I_mod)

pred=predict(I_mod)
lines(line_err$Lines, pred*100, col=pal_col[1])


M_mod=betareg(Mod_frac ~ log(Lines), data=line_err)
summary(M_mod)

pred=predict(M_mod)
lines(line_err$Lines, pred*100, col=pal_col[2])


