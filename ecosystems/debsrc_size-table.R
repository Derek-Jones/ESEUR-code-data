#
# debsrc_size-table.csv,  5 May 15
#
# Data from:
# Debsources: Live and Historical Views on Macro-Level Software Evolution∗
# Matthieu Caneill and Stefano Zacchirol
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


# release,pkgs,files(k),du(GB),sloc(G),ctags(M),mean pkg size (kSLOC)
# hamm,"1,373","348.4","4.1","35.1","3.9",25.6
deb_size=read.csv(paste0(ESEUR_dir, "ecosystems/debsrc_size-table.csv.xz"), as.is=TRUE)

suite_date=read.csv(paste0(ESEUR_dir, "ecosystems/debsrc_suites.csv.xz"), as.is=TRUE)

s_date=as.Date(suite_date$s_date, format="%Y-%m-%d")
names(s_date)=suite_date$suite

plot(s_date, deb_size$pkgs,
	xlab="Release date", ylab="Packages in release\n")

axis(3, at=s_date, label=deb_size$release, cex.axis=0.9)

deb_mod=glm(pkgs ~ s_date[release], data=deb_size)
pred_deb=predict(deb_mod)

lines(s_date, pred_deb, col="red")

par(new=TRUE)
plot(s_date, deb_size$sloc_G, type="l", col="green",
	xaxt="n", yaxt="n",
	xlab="", ylab="\n")

axis(4, yaxp=c(0, 100*(1+max(deb_size$sloc_G) %/% 100), 4))


