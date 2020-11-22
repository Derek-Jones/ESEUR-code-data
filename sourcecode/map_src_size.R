#
# map_src_size.R, 31 Jan 20
# Data from:
# How Scale Affects Structure in {Java} Programs
# Cristina V. Lopes and Joel Ossher
#
# Empirical analysis of the relationship between {CC} and {SLOC} in a large corpus of {Java} methods and {C} functions
# Davy Landman and Alexander Serebrenik and Eric Bouwers and Jurgen J. Vinju
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG method_SLOC C_SLOC file project Java_method Java_class Java_SLOC

source("ESEUR_config.r")


library("ascii")
library("plyr")
library("Matrix") # quantreg does not automatically include this!
library("quantreg")


proj_totals=function(df)
{
sloc=sum(df$sloc)
methods=nrow(df)
files=length(unique(df$file))

return(data.frame(sloc, methods, files))
}


mk_reg_string=function(formula, java_df, x_str)
{
qr50_mod=rq(formula, data=java_df, tau=0.50)
c50=coef(qr50_mod)
qr95_mod=rq(formula, data=java_df, tau=0.95)
c95=coef(qr95_mod)
qr05_mod=rq(formula, data=java_df, tau=0.05)
c05=coef(qr05_mod)

cpm95=abs(c95-c05)/2

equ_str=paste0("<equ>", signif(exp(c50[1]), digits=2), "\\substack{ +", signif(exp(c95[1])-exp(c50[1]), digits=1), "\\\\ -", signif(exp(c50[1])-exp(c05[1]), digits=1),
		"}\\times\\mathit{", x_str, "}^{", round(c50[2], digits=2), "\\pm", round(cpm95[2], digits=2), "}</equ>")

return(equ_str)
}


gp=read.csv(paste0(ESEUR_dir, "sourcecode/1508-00628.csv.xz"), as.is=TRUE)
gp_nz=subset(gp, (SLOC > 0) &
                        (Classes > 0) &
                        (Methods > 9))

cc_loc=read.csv(paste0(ESEUR_dir, "sourcecode/Landman.csv.xz"), as.is=TRUE)
cc_loc$logloc=log(cc_loc$sloc)

# smoothScatter(log(cc_loc$sloc), log(cc_loc$cc),
#         xlab="log(SLOC)", ylab="log(CC)")

proj_info=ddply(cc_loc, .(project), proj_totals)
proj_info=subset(proj_info, methods > 9)

# qr_mod=rqss(log(Methods) ~ log(SLOC), data=gp_nz)
# summary(qr_mod)

fitted_gc=data.frame(
		"to"=c("SLOC", "Methods", "Classes", "Files"),
		SLOC=c(
			"",
			mk_reg_string(log(Methods) ~ log(SLOC), gp_nz, "SLOC"),
			mk_reg_string(log(Classes) ~ log(SLOC), gp_nz, "SLOC"),
			mk_reg_string(log(files) ~ log(sloc), proj_info, "SLOC")
			),
		Methods=c(
			mk_reg_string(log(SLOC) ~ log(Methods), gp_nz, "Methods"),
			"",
			mk_reg_string(log(Classes) ~ log(Methods), gp_nz, "Methods"),
			mk_reg_string(log(files) ~ log(methods), proj_info, "Methods")
			),
		Classes=c(
			mk_reg_string(log(SLOC) ~ log(Classes), gp_nz, "Classes"),
			mk_reg_string(log(Methods) ~ log(Classes), gp_nz, "Classes"),
			"",
			""
			),
		Files=c(
			mk_reg_string(log(sloc) ~ log(files), proj_info, "Files"),
			mk_reg_string(log(methods) ~ log(files), proj_info, "Files"),
			"",
			""
			)
		)


print(ascii(fitted_gc, include.rownames=FALSE,
        align="r", frame="topbot", grid="none"))


# fitted_land=data.frame(
# 		"from/to"=c("SLOC", "Methods", "Files"),
# 		SLOC=c(
# 			"",
# 			mk_reg_string(log(methods) ~ log(sloc), proj_info, "SLOC"),
# 			mk_reg_string(log(files) ~ log(sloc), proj_info, "SLOC")
# 			),
# 		Methods=c(
# 			mk_reg_string(log(sloc) ~ log(methods), proj_info, "Methods"),
# 			"",
# 			mk_reg_string(log(files) ~ log(methods), proj_info, "Methods")
# 			),
# 		Files=c(
# 			mk_reg_string(log(sloc) ~ log(files), proj_info, "Files"),
# 			mk_reg_string(log(methods) ~ log(files), proj_info, "Files"),
# 			""
# 			)
# 		)
# 
# 
# print(ascii(fitted_land, include.rownames=FALSE,
#         align="r", frame="topbot", grid="none"))
# 
# 
