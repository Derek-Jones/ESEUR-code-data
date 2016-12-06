#
# fse13-dyno-fit.R, 23 Sep 16
#
# Data from:
# Dynodroid: {An} Input Generation System for {Android} Apps
# Aravind Machiry and Rohan Tahiliani and Mayur Naik
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("compositions")


pal_col=rainbow(3)
hcl_col=rainbow_hcl(4)

dh=read.csv(paste0(ESEUR_dir, "benchmark/fse13-dynohuman.csv.xz"), as.is=TRUE)
# dm=read.csv(paste0(ESEUR_dir, "benchmark/fse13-dynomonkey.csv.xz"), as.is=TRUE)

# Dynodroid vs human

covered=acomp(dh, parts=c("LOC.covered.exclusively.by.Dyno..D.",
			"LOC.covered.exclusively.by.Human..H.",
			"LOC.covered.by.both.Dyno.and.Human..C."))

# covered=acomp(dm, parts=c("LOC.covered.exclusively.by.Dyno..D.",
# 			"LOC.covered.exclusively.by.Monkey..M.",
#			"LOC.covered.by.both.Dyno.and.Monkey..C."))

# Cannot switch off labels, have to specify empty
plot(covered, labels="", col=point_col, mp=NULL)

# aspanel set so the entire plot is not redrawn
ternaryAxis(side=0,
#                col.axis=hcl_col, col.lab=pal_col,
                small=TRUE, aspanel=TRUE,
		Xlab="Dynodroid", Ylab="Human", Zlab="Human & Dynodroid")

# isoPortionLines(col=hcl_col[4])


dh$l_total_lines=log(dh$Total.App.LOC..T.)
# dm$l_total_lines=log(dm$Total.App.LOC..T.)

# comp_mod=lm(ilr(covered) ~ l_total_lines, data=dh)
comp_mod=lm(ilr(covered) ~ I(l_total_lines^2), data=dh)

# Strip intercept from coefficients and invert the response ilr
d=ilrInv(coef(comp_mod)[-1, ], orig=covered)
straight(mean(covered), d, col="green")


total_pts=seq(1, 15, by=2.0)
pred=predict(comp_mod, newdata=data.frame(l_total_lines=total_pts))

pred_pts=ilrInv(pred, orig=covered)
plot(pred_pts, add=TRUE, col="red")

# Composite does not provide a way of adding text.
# So we have to do the x/y calculation for text ourselves.
text(0.5*cos(pi/6)+pred_pts[,2]*cos(pi/3), cos(pi/6)*pred_pts[,3],
				as.character(round(exp(total_pts))),
				cex=0.8)

# From page 140 of Boogaart and Tolosana-Deldag
# d=ilrInv(predict(comp_mod), orig=covered)

# opar = par(mfrow=c(3,3), mar=c(2,2,1,1), oma=c(4,4,0,0))
# Ypred = ilrInv(predict(comp_mod),orig=covered)
# for(i in 1:3)
#    {
#    for(j in 1:3)
#       {
#       plot(log(covered[,i]/covered[,j]),
#            log(Ypred[,i]/Ypred[,j]),
#            pch=ifelse(i!=j,1,""))
#       if(i==j)
#          text(x=0,y=0, labels=colnames(covered)[i],cex=1.5)
#       else
#     	abline(a=0,b=1,col="gray",lwd=3)
#       }
#    }
# mtext(text=c("observed log-ratio","predicted log-ratio"),
# 			side=c(1,2), at=0.5, line=2, outer=TRUE)
# par(opar)

