#
# cpu-sales.R,  7 Mar 16
#
# Data from:
#
# Jim Turley
# Embedded Processors
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG cpu_embedded cpu_sales cpu_8-bit cpu_16-bit cpu_32-bit


source("ESEUR_config.r")


plot_wide()
pal_col=rainbow(3)

proc_sales=read.csv(paste0(ESEUR_dir, "introduction/turley_02.csv.xz"), as.is=TRUE)

proc_sales$date=as.Date(proc_sales$date, format="%d/%m/%Y")
proc_sales$days=as.numeric(proc_sales$date)

# Picked out of thin air and tweaked
y_1998=as.Date("01-04-1998", format="%d-%m-%Y")

#p4=glm(bit.4 ~ date, data=proc_sales)
p4=glm(bit.4 ~ date*(date < y_1998)+date*(date >= y_1998), data=proc_sales)
print(summary(p4))

