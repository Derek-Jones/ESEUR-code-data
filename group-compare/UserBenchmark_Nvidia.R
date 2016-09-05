#
# UserBenchmark_Nvidia.R, 26 Aug 16
# Data from:
# http://userbenchmark.com
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")
library("stringr")
library("XML")


pal_col=rainbow(3)


extract_number=function(vec, bench_name)
{
b_str=str_match(vec, paste0(bench_name, " +[0-9.]+"))
return(as.numeric(sub(paste0(bench_name, " +"), "", b_str)))
}


extract_driver=function(vec, header_str)
{
b_str=str_match(vec, paste0(header_str, " +[a-zA-Z0-9.]+"))
return(sub(paste0(header_str, " +"), "", b_str))
}


extract_mother=function()
{
h_str="Report\r\n\t\t\r\n\t\t"
b_str=str_match(nbench$V1, paste0(h_str, "[^\r]+"))
return(sub(h_str, "", b_str))
}


nvidia=readHTMLTable(paste0(ESEUR_dir, "group-compare/UserBenchmark_Nvidia-GTX-970.htm.xz"))

nbench=nvidia[[1]] # Benchmark data is the first table in the list
nbench=nbench[-1, ] # Skip first entry

GTX_970=data.frame(
		Variant=extract_mother(),
		Driver=extract_driver(nbench$V1, "Driver:"),
		Driver_ver=extract_driver(nbench$V1, "Ver."),
		Lighting=extract_number(nbench$V3, "Lighting"),
		Reflection=extract_number(nbench$V3, "Reflection"),
		Parallax=extract_number(nbench$V3, "Parallax"),
		
		MRender=extract_number(nbench$V4, "MRender"),
		Gravity=extract_number(nbench$V4, "Gravity"),
		Splatting=extract_number(nbench$V4, "Splatting")
		)

Asus_1043_8508=subset(GTX_970, Variant == "Asus(1043 8508)")
MSI_1462_3160=subset(GTX_970, Variant == "MSI(1462 3160)")
Gigabyte_1458_366A=subset(GTX_970, Variant == "Gigabyte(1458 366A)")
Gigabyte_1458_367A=subset(GTX_970, Variant == "Gigabyte(1458 367A) ≥ 4GB")
EVGA_3842_2974=subset(GTX_970, Variant == "EVGA(3842 2974)")

mean(Asus_1043_8508$Reflection)
mean(MSI_1462_3160$Reflection)
mean(Gigabyte_1458_367A$Reflection)
mean(EVGA_3842_2974$Reflection)

Asus=count(Asus_1043_8508$Reflection)
MSI=count(MSI_1462_3160$Reflection)
Giga=count(Gigabyte_1458_367A$Reflection)
EVGA=count(EVGA_3842_2974$Reflection)

plot(Asus$x, Asus$freq, type="l", col=pal_col[1],
	xlim=c(155, 215), ylim=c(1, 27),
	xlab="Reflection performance", ylab="Reports")
lines(MSI$x, MSI$freq, col=pal_col[2])
lines(Giga$x, Giga$freq, col=pal_col[3])

legend(x="topleft", legend=c("Asus(1043 8508)", "MSI(1462 3160)", "Gigabyte(1458 367A) 4GB"), bty="n", fill=pal_col, cex=1.2)

