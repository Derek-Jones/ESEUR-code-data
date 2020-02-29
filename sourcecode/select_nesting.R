#
# select_nesting.R, 16 Jan 20
# Data from:
# The New {C} Standard: {An} Economic and Cultural Commentary
# Derek M. Jones
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG C selection-statement_nesting source-code_C


source("ESEUR_config.r")


plot_layout(2, 1)

pal_col=rainbow(2)


sn=read.csv(paste0(ESEUR_dir, "sourcecode/select_nesting.csv.xz"), as.is=TRUE)

ll=read.csv(paste0(ESEUR_dir, "sourcecode/logicline.csv.xz"), as.is=TRUE)
# tl=read.csv(paste0(ESEUR_dir, "sourcecode/tokenonline.csv.xz"), as.is=TRUE)

cf=subset(ll, file_suff == ".c")
cf=subset(cf, characters < 400)

plot(cf$characters, cf$occurrences, log="xy", col=point_col,
	xlab="Characters on line", ylab="Lines\n")

# plot(tl$tokens, tl$lines, log="y", col=point_col,
# 	xlab="Tokens on line", ylab="Lines\n")


plot(sn$nesting, sn$occurrences, log="y", col=pal_col[1],
	xaxs="i",
	xlim=c(0, 25),
	xlab="Nesting level", ylab="Selection-statements\n")

mod_113=glm(log(occurrences) ~ nesting, data=sn, subset=2:13)
pred=predict(mod_113)

lines(1:12, exp(pred), col=pal_col[2])

# Embedded C data from Engblom <book Engblom_98>
# 
# emb=data.frame(nesting=1:10,
# 		 occurrences=c(0.495, 0.196, 0.095, 0.067, 0.065,
# 				 0.063, 0.019, 0.014, 0.007, 0.008))
# 
# points(emb$nesting, 1e5*emb$occurrences)


