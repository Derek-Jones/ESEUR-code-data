#
# 2015_sosym.R,  2 Jul 16
# Data from:
# The shape of feature code: an analysis of twenty {C}-preprocessor-based systems
# Rodrigo Queiroz and Leonardo Passos and Marco Tulio Valente and Claus Hunsen and Sven Apel and Krzysztof Czarnecki
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")
library("poweRlaw")


plot_layout(5, 4)
pal_col=rainbow(2)


plot_sd=function(file_str)
{
FS=read.csv(paste0(ESEUR_dir, "regression/2015_sosym/", file_str, "_sd.csv.xz"),
			sep=";", as.is=TRUE)

# displ is the constructor for the discrete power law distribution
pow_mod=displ$new(FS$sd)
exp_mod=disexp$new(FS$sd)

# Estimate the lower threshold of the fit
pow_mod$setXmin(estimate_xmin(pow_mod))
exp_mod$setXmin(estimate_xmin(exp_mod))  # discrete power exponential

# Plot stuff
plot(pow_mod, col=point_col, cex.axis=1.1, cex.lab=1.1,
	xlab="Scattering degree", ylab="")
lines(pow_mod, col=pal_col[1])
lines(exp_mod, col=pal_col[2])

# Test hypothesis that sample follows a power law, use bootstrap
bs_p=bootstrap_p(pow_mod, threads=4, no_of_sims=500, xmax=5e3)
text(50, 0.5, bs_p$p, pos=2, cex=1.3, col=pal_col[1])

bs_e=bootstrap_p(exp_mod, threads=4, no_of_sims=500, xmax=5e3)
text(7, 0.02, bs_e$p, pos=2, cex=1.3, col=pal_col[2])

# t=count(FS$sd)
# 
# plot(t$x, t$freq, log="xy", col=point_col, cex.axis=1.1, cex.lab=1.1,
# 	xlab="Feature macros", ylab="")
# 
# text(max(t$x)/1.2, max(t$freq)/1.5, file_str, pos=2, cex=1.3)

}


plot_sd("vi")
plot_sd("lighttpd")
plot_sd("xfig")
plot_sd("sendmail")
plot_sd("sylpheed")

plot_sd("git")
plot_sd("libxml2")
plot_sd("emacs")
plot_sd("openldap")
plot_sd("apachehttpd")

plot_sd("subversion")
plot_sd("imagemagick")
plot_sd("python")
plot_sd("php")
plot_sd("postgresql")

plot_sd("gimp")
plot_sd("glibc")
plot_sd("mysql")
plot_sd("gcc")
plot_sd("linux")


