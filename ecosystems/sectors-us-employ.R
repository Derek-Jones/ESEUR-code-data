#
# sectors-us-employ.R, 28 Jun 17
# Data from:
#
# John Kossik
# http://www.63alfred.com/whomakesit/clarksmodel.htm
# Collated from the sources:
# Economic Report of the President: 2011 Report Spreadsheet Tables, B-46. Employees on nonagricultural payrolls, by major industry, 1965-2010, U.S. Government Printing Office
# http://www.gpo.gov/fdsys/pkg/ERP-2011/xls/ERP-2011-table46.xls
# Economic Report of the President: 2011 Report Spreadsheet Tables, B-35. Civilian population and labor force, 1929-2010, U.S. Government Printing Office
# http://www.gpo.gov/fdsys/pkg/ERP-2011/xls/ERP-2011-table35.xls
# Economic Report of the President: 2001 Report Spreadsheet Tables, B-46. Employees on nonagricultural payrolls, by major industry, 1950-2000, U.S. Government Printing Office
# https://web.archive.org/web/20110301000000*/http://www.gpoaccess.gov/usbudget/fy02/sheets/b46.xls
# Historical statistics of the United States, colonial times to 1970, Volume 1, Chapter D, Labor Force (Series D 1-682), U.S. Bureau of the Census, 1975
# http://www2.census.gov/prod2/statcomp/documents/CT1970p1-05.pdf
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(4)

employ=read.csv(paste0(ESEUR_dir, "ecosystems/sectors-us-employ.csv.xz"), as.is=TRUE)

plot(employ$Year, 100*(employ$Total.Mining...Logging...fishing+employ$Total.Agricutural.employees)/employ$Total.employees,
	type="l", col=pal_col[1],
	xlab="Year", ylab="Percent of workforce\n")

lines(employ$Year, 100*employ$Total.Manufacturing...Construction/employ$Total.employees,
			col=pal_col[2])
lines(employ$Year, 100*employ$Total.Service.providing.employees/employ$Total.employees,
			col=pal_col[3])
lines(employ$Year, 100*employ$Total.Government.employees/employ$Total.employees,
			col=pal_col[4])

legend(x="top", legend=c("Primary", "Secondary", "Tertiary", "Government"), bty="n", fill=pal_col, cex=1.2)

