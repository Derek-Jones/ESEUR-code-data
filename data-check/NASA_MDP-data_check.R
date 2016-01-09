#
# NASA_MDP-data_check.R,  8 Nov 12
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

read_data=function(prefix_str)
{
read.table(paste(root,
		 "data-check/NASA_mdp/",
                 prefix_str, "/",
                 prefix_str, "_product_module_metrics.csv.xz", sep=""),
           header=TRUE, sep=",", as.is=TRUE)
}

flag_incon=function(condition, msg)
{
if (condition != 0)
   print(msg)
}


consistency_check=function(data)
{
# First column contains a unique module identifier
flag_incon(anyDuplicated(data[, 2:ncol(data)], MAGINS=1),
                  "Data contains one or more duplicate rows")
# Rows terminated by a comma, so ignore last NA
flag_incon(any(is.na(data[, 1:(ncol(data)-1)])),
                  "Data contains one or more missing values")
# Use transpose because as.array throws an error, otherwise use MARGINS=2
flag_incon(anyDuplicated(t(data), MAGINS=1),
                  "Data contains one or more duplicate columns")
flag_incon(any(sd(data[,1:ncol(data)]) < 0.01),
                "Data contains one or more columns whose values are very similar")
#length(which(sd(data[,1:ncol(data)]) > 0.01))

flag_incon(any(data$CYCLOMATIC_COMPLEXITY > (data$NUM_OPERATORS+1)),
           "Some cyclomatic complexity values greater than number of operators+1")
flag_incon(any(data$CALL_PAIRS > data$NUM_OPERATORS),
           "Some call counts greater than corresponding operator counts")

# Ignore any missing values
flag_incon(any(is.integer(data$NUMBER_OF_LINES[!is.na(data$NUMBER_OF_LINES)])),
           "NUMBER_OF_LINES column contains non-integer values")
flag_incon(any(is.integer(data$LOC_BLANK[!is.na(data$LOC_BLANK)])),
           "LOC_BLANK column contains non-integer values")
}


CM1=read_data("CM1")
JM1=read_data("JM1")
KC1=read_data("KC1")
KC3=read_data("KC3")
KC4=read_data("KC4")

PC1=read_data("PC1")
PC2=read_data("PC2")
PC3=read_data("PC3")
PC4=read_data("PC4")
#PC5=read_data("PC5")

consistency_check(CM1)
consistency_check(JM1)
consistency_check(KC1)
consistency_check(KC3)
consistency_check(KC4)

consistency_check(PC1)
consistency_check(PC2)
consistency_check(PC3)
consistency_check(PC4)
# consistency_check(PC5)

