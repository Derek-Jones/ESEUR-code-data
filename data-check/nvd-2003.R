#
# nvd-2003.R,  1 May 14
# Data from:
# http://nvd.nist.gov
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


bench=read.csv(paste0(ESEUR_dir, "data-check/nvdcve-2.0-2003.xml.csv.xz"), as.is=TRUE)

# nvd..pub_date.  vuln.last.modified.datetime  vuln.published.datetime cvss.generated.on.datetime

bench$vuln.published=as.Date(bench$vuln.published.datetime, format="%Y-%m-%d")

t=table(bench$vuln.published)
plot(t, ylab="Vulnerabilities published\n")

