#
# lee.R, 10 Oct 16
#
# Data from:
# Regression modeling strategies for microarchitectural performance and power prediction
# Benjamin C. Lee and David M. Brooks
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


lee=read.csv(paste0(ESEUR_dir, "experiment/lee2006/data_model_ammp.txt.xz"),
		sep="\t", as.is=TRUE)

lee$sec = 1.1 * lee$cycle * 18 / lee$depth;
lee$bips = lee$inst / lee$sec;


brew_col=rainbow_hcl(3)

f_lee=within(lee,
		{
		depth=as.factor(depth)
		width=as.factor(width)
		gpr_phys=as.factor(gpr_phys)
		br_resv=as.factor(br_resv)
		dmem_lat=as.factor(dmem_lat)
		load_lat=as.factor(load_lat)
		br_lat=as.factor(br_lat)
		fix_lat=as.factor(fix_lat)
		fpu_lat=as.factor(fpu_lat)
		d2cache_lat=as.factor(d2cache_lat)
		l2cache_size=as.factor(l2cache_size)
		icache_size=as.factor(icache_size)
		dcache_size=as.factor(dcache_size)})


form_fact=power ~ depth+
		width+
		gpr_phys+
		br_resv+
		dmem_lat+
		load_lat+
		br_lat+
		fix_lat+
		fpu_lat+
		d2cache_lat+
		l2cache_size+
		icache_size+
		dcache_size

plot.design(form_fact, data=f_lee, cex=0.7,
		xaxt="n", xlab="")

x_lab=all.vars(form_fact)[-1]
text(x=seq(1, 13, by=1)-0.3, par("usr")[3]-0.2, labels=x_lab, srt=-60,
			pos=4, xpd = TRUE)


# t=glm(form_fact, data=lee)
#
# cor(lee[, c("depth", "width", "gpr_phys", "br_resv", "dmem_lat")])

p=hclust(as.dist(1-cor(lee[, 6:20], method="spe")^2))
plot(p) # y-axis labels need to be reversed...


# A packaged way of doing things
# library("Hmisc")
# 
# p=varclus(~ (depth + width + gpr_phys + br_resv + dmem_lat
#               + load_lat + br_lat + fix_lat + fpu_lat + d2cache_lat
#               + l2cache_size + icache_size + dcache_size + sec + bips),
# 		similarity="spearman",
# 		data = lee)
#  
# plot(p)

