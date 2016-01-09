#
# indentation.R, 21 Oct 13
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


plot_layout(2,3)


indent_acf=function(lang_str)
{
indent=read.csv(paste0(ESEUR_dir, "time-series/src-indent/sfmirror.", lang_str,
				",distribution.dat"), as.is=TRUE, header=FALSE)

acf(indent$V1, lag.max=20, xlab="Indentation")

text(15, 0.8, labels=lang_str, col="blue")

}


indent_acf("cpp")
indent_acf("c")
indent_acf("java")
indent_acf("php")
indent_acf("pl")
indent_acf("py")

# indent_acf("h")

