#
# indentation.R, 20 Mar 20
#
# Data from:
# Reading Beside the Lines: {Indentation} as a Proxy for Complexity Metrics
# Abram Hindle and Michael W. Godfrey and Richard C. Holt
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG source_indentation


source("ESEUR_config.r")


plot_layout(2,3, max_height=11.0)
par(mar=MAR_default-c(0.6, 0, 0.5, 0))


indent_acf=function(lang_str)
{
indent=read.csv(paste0(ESEUR_dir, "time-series/src-indent/sfmirror.", lang_str,
				",distribution.dat"), as.is=TRUE, header=FALSE)

acf(indent$V1, lag.max=20, xlab="Characters", col=point_col,
	yaxs="i",
	ylab="ACF\n")

text(15, 0.8, labels=lang_str, col="blue", cex=1.4)

}


indent_acf("cpp")
indent_acf("c")
indent_acf("java")
indent_acf("php")
indent_acf("pl")
indent_acf("py")

# indent_acf("h")

