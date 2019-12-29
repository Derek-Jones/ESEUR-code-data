#
# L18-1529.R,  8 Dec 19
# Data from:
# Grounding Gradable Adjectives through Crowdsourcing
# Rebecca Sharp and Mithun Paul and Ajay Nagesh and Dane Bell and Mihai Surdeanu
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_human adjective_gradable

source("ESEUR_config.r")


library("vioplot")


# The following code is a modified version of some of the R code the
# authors included in their data package.

m=read.csv(paste0(ESEUR_dir, "reliability/L18-1529.csv.xz"), as.is=TRUE)
#nrow(m) == 4960

#-----------------------------------------
# Remove unreliable turkers (more than 50% of their responses were removed as outliers)
#-----------------------------------------

rd2 = subset(m, (turker != "T_121936") &
		(turker != "T_1298416") &
		(turker != "T_2115504") &
		(turker != "T_2153811") &
		(turker != "T_2892459") &
		(turker != "T_3492478") &
		(turker != "T_39282") &
		(turker != "T_4014221") &
		(turker != "T_6891188") &
		(turker != "T_9330037"))
# nrow(rd2) == 4760 rows

#-----------------------------------------
# Remove unreliable turkers (20% or more of their responses were identical to mean)
#-----------------------------------------

rd2=subset(rd2, (turker != "T_1165715") &
		(turker != "T_1165716") &
		(turker != "T_1196469") &
		(turker != "T_1912172") &
		(turker != "T_5183220") &
		(turker != "T_5217880") &
		(turker != "T_5626997") &
		(turker != "T_6285431") &
		(turker != "T_6319106") &
		(turker != "T_6705482") &
		(turker != "T_910400") &
		(turker != "T_9408028") &
		(turker != "T_9453622") &
		(turker != "T_9940419"))
# nrow(rd2) == 4480 rows

#-----------------------------------------
# Remove unreliable turkers (50% or more of their responses were identical to given range endpoint)
#-----------------------------------------

rd2=subset(rd2, (turker != "T_4606060") &
		(turker != "T_6842232") &
		(turker != "T_947851"))
# nrow(rd2) == 4420 rows


#-----------------------------------------
# Remove negatives (50% or more of their responses were identical to given range endpoint)
#-----------------------------------------
rd2 = subset(rd2, had_negative != "hadNeg")

# [1] 3734

brew_col=rainbow(10)

adj_list=c("adequate", "conservative", "fair", "huge", "major", "moderate", "slight", "small", "substantial", "weak")

rd2_subset = subset(rd2, adjective %in% adj_list)

# Paper removed outliers, this is a crude approach
rd2_subset=subset(rd2_subset, respdev < 8)

# boxplot(respdev ~ adjective, data=rd2_subset,
# 	notch=TRUE, horizontal=TRUE,
# 	boxwex=0.4,
#         col="yellow", border=brew_col,
# 	yaxs="i",
# 	ylim=c(0, 7),
# 	xlab="Response (standard deviations)")

# Order adjectives by the mean response deviation
adj_ord=with(rd2_subset, reorder(adjective, respdev))

vioplot(respdev ~ adj_ord, data=rd2_subset, 
        horizontal=TRUE, cex.axis=0.7,
        col=brew_col, border=brew_col,
	xaxs="i",
        ylim=c(0, 8),
        xlab="Response (standard deviations)", ylab="")

# 
# 
# #-----------------------------------------
# # Outlier removal function
# # taken from https://datascienceplus.com/identify-describe-plot-and-removing-the-outliers-from-the-dataset/
# # slightly customized (i.e., to remove prompting before removing outliers)
# #-----------------------------------------
# outlierKD <- function(dt, var) {
#      var_name <- eval(substitute(var),eval(dt))
#      na1 <- sum(is.na(var_name))
#      m1 <- mean(var_name, na.rm = T)
#      par(mfrow=c(2, 2), oma=c(0,0,3,0))
#      boxplot(var_name, main="With outliers")
#      hist(var_name, main="With outliers", xlab=NA, ylab=NA)
#      outlier <- boxplot.stats(var_name)$out
#      mo <- mean(outlier)
#      var_name <- ifelse(var_name %in% outlier, NA, var_name)
#      boxplot(var_name, main="Without outliers")
#      hist(var_name, main="Without outliers", xlab=NA, ylab=NA)
#      title("Outlier Check", outer=TRUE)
#      na2 <- sum(is.na(var_name))
#      cat("Outliers identified:", na2 - na1, "n")
#      cat("Propotion (%) of outliers:", round((na2 - na1) / sum(!is.na(var_name))*100, 1), "n")
#      cat("Mean of the outliers:", round(mo, 2), "n")
#      m2 <- mean(var_name, na.rm = T)
#      cat("Mean without removing outliers:", round(m1, 2), "n")
#      cat("Mean if we remove outliers:", round(m2, 2), "n")
#      dt[as.character(substitute(var))] <- invisible(var_name)
#           assign(as.character(as.list(match.call())$dt), dt, envir = .GlobalEnv)
#           cat("Outliers successfully removed", "n")
#           return(invisible(dt))
#      #response <- readline(prompt="Do you want to remove outliers and to replace with NA? [yes/no]: ")
#      #if(response == "y" | response == "yes"){
#      #     dt[as.character(substitute(var))] <- invisible(var_name)
#      #     assign(as.character(as.list(match.call())$dt), dt, envir = .GlobalEnv)
#      #     cat("Outliers successfully removed", "n")
#      #     return(invisible(dt))
#      #} else{
#      #     cat("Nothing changed", "n")
#      #     return(invisible(var_name))
#      #}
# }
# 
# 
# #-----------------------------------------
# # Outlier removal by adjective
# #-----------------------------------------
# m = rd2
# relative = subset(m, m$adjective == "relative")
# outlierKD(relative, respdev)
# little = subset(m, m$adjective == "little")
# outlierKD(little, respdev)
# big = subset(m, m$adjective == "big")
# outlierKD(big, respdev)
# favorable = subset(m, m$adjective == "favorable")
# outlierKD(favorable, respdev)
# legitimate = subset(m, m$adjective == "legitimate")
# outlierKD(legitimate, respdev)
# sizable = subset(m, m$adjective == "sizable")
# outlierKD(sizable, respdev)
# tiny = subset(m, m$adjective == "tiny")
# outlierKD(tiny, respdev)
# extraordinary = subset(m, m$adjective == "extraordinary")
# outlierKD(extraordinary, respdev)
# weak = subset(m, m$adjective == "weak")
# outlierKD(weak, respdev)
# striking = subset(m, m$adjective == "striking")
# outlierKD(striking, respdev)
# rich = subset(m, m$adjective == "rich")
# outlierKD(rich, respdev)
# dramatic = subset(m, m$adjective == "dramatic")
# outlierKD(dramatic, respdev)
# fine = subset(m, m$adjective == "fine")
# outlierKD(fine, respdev)
# modest = subset(m, m$adjective == "modest")
# outlierKD(modest, respdev)
# important = subset(m, m$adjective == "important")
# outlierKD(important, respdev)
# unlikely = subset(m, m$adjective == "unlikely")
# outlierKD(unlikely, respdev)
# prominent = subset(m, m$adjective == "prominent")
# outlierKD(prominent, respdev)
# competitive = subset(m, m$adjective == "competitive")
# outlierKD(competitive, respdev)
# good = subset(m, m$adjective == "good")
# outlierKD(good, respdev)
# critical = subset(m, m$adjective == "critical")
# outlierKD(critical, respdev)
# sensitive = subset(m, m$adjective == "sensitive")
# outlierKD(sensitive, respdev)
# narrow = subset(m, m$adjective == "narrow")
# outlierKD(narrow, respdev)
# rare = subset(m, m$adjective == "rare")
# outlierKD(rare, respdev)
# generous = subset(m, m$adjective == "generous")
# outlierKD(generous, respdev)
# outstanding = subset(m, m$adjective == "outstanding")
# outlierKD(outstanding, respdev)
# considerable = subset(m, m$adjective == "considerable")
# outlierKD(considerable, respdev)
# typical = subset(m, m$adjective == "typical")
# outlierKD(typical, respdev)
# promising = subset(m, m$adjective == "promising")
# outlierKD(promising, respdev)
# normal = subset(m, m$adjective == "normal")
# outlierKD(normal, respdev)
# broad = subset(m, m$adjective == "broad")
# outlierKD(broad, respdev)
# light = subset(m, m$adjective == "light")
# outlierKD(light, respdev)
# powerful = subset(m, m$adjective == "powerful")
# outlierKD(powerful, respdev)
# high = subset(m, m$adjective == "high")
# outlierKD(high, respdev)
# huge = subset(m, m$adjective == "huge")
# outlierKD(huge, respdev)
# disappointing = subset(m, m$adjective == "disappointing")
# outlierKD(disappointing, respdev)
# traditional = subset(m, m$adjective == "traditional")
# outlierKD(traditional, respdev)
# serious = subset(m, m$adjective == "serious")
# outlierKD(serious, respdev)
# sound = subset(m, m$adjective == "sound")
# outlierKD(sound, respdev)
# grand = subset(m, m$adjective == "grand")
# outlierKD(grand, respdev)
# minor = subset(m, m$adjective == "minor")
# outlierKD(minor, respdev)
# remarkable = subset(m, m$adjective == "remarkable")
# outlierKD(remarkable, respdev)
# aggressive = subset(m, m$adjective == "aggressive")
# outlierKD(aggressive, respdev)
# usual = subset(m, m$adjective == "usual")
# outlierKD(usual, respdev)
# low = subset(m, m$adjective == "low")
# outlierKD(low, respdev)
# great = subset(m, m$adjective == "great")
# outlierKD(great, respdev)
# steep = subset(m, m$adjective == "steep")
# outlierKD(steep, respdev)
# sharp = subset(m, m$adjective == "sharp")
# outlierKD(sharp, respdev)
# slight = subset(m, m$adjective == "slight")
# outlierKD(slight, respdev)
# firm = subset(m, m$adjective == "firm")
# outlierKD(firm, respdev)
# obvious = subset(m, m$adjective == "obvious")
# outlierKD(obvious, respdev)
# tight = subset(m, m$adjective == "tight")
# outlierKD(tight, respdev)
# major = subset(m, m$adjective == "major")
# outlierKD(major, respdev)
# poor = subset(m, m$adjective == "poor")
# outlierKD(poor, respdev)
# clear = subset(m, m$adjective == "clear")
# outlierKD(clear, respdev)
# appropriate = subset(m, m$adjective == "appropriate")
# outlierKD(appropriate, respdev)
# small = subset(m, m$adjective == "small")
# outlierKD(small, respdev)
# thin = subset(m, m$adjective == "thin")
# outlierKD(thin, respdev)
# adequate = subset(m, m$adjective == "adequate")
# outlierKD(adequate, respdev)
# positive = subset(m, m$adjective == "positive")
# outlierKD(positive, respdev)
# substantial = subset(m, m$adjective == "substantial")
# outlierKD(substantial, respdev)
# impressive = subset(m, m$adjective == "impressive")
# outlierKD(impressive, respdev)
# large = subset(m, m$adjective == "large")
# outlierKD(large, respdev)
# fair = subset(m, m$adjective == "fair")
# outlierKD(fair, respdev)
# intense = subset(m, m$adjective == "intense")
# outlierKD(intense, respdev)
# unexpected = subset(m, m$adjective == "unexpected")
# outlierKD(unexpected, respdev)
# deep = subset(m, m$adjective == "deep")
# outlierKD(deep, respdev)
# fundamental = subset(m, m$adjective == "fundamental")
# outlierKD(fundamental, respdev)
# regular = subset(m, m$adjective == "regular")
# outlierKD(regular, respdev)
# surprising = subset(m, m$adjective == "surprising")
# outlierKD(surprising, respdev)
# stable = subset(m, m$adjective == "stable")
# outlierKD(stable, respdev)
# bullish = subset(m, m$adjective == "bullish")
# outlierKD(bullish, respdev)
# severe = subset(m, m$adjective == "severe")
# outlierKD(severe, respdev)
# healthy = subset(m, m$adjective == "healthy")
# outlierKD(healthy, respdev)
# bearish = subset(m, m$adjective == "bearish")
# outlierKD(bearish, respdev)
# reasonable = subset(m, m$adjective == "reasonable")
# outlierKD(reasonable, respdev)
# comfortable = subset(m, m$adjective == "comfortable")
# outlierKD(comfortable, respdev)
# hefty = subset(m, m$adjective == "hefty")
# outlierKD(hefty, respdev)
# inadequate = subset(m, m$adjective == "inadequate")
# outlierKD(inadequate, respdev)
# wide = subset(m, m$adjective == "wide")
# outlierKD(wide, respdev)
# excessive = subset(m, m$adjective == "excessive")
# outlierKD(excessive, respdev)
# valuable = subset(m, m$adjective == "valuable")
# outlierKD(valuable, respdev)
# conventional = subset(m, m$adjective == "conventional")
# outlierKD(conventional, respdev)
# ordinary = subset(m, m$adjective == "ordinary")
# outlierKD(ordinary, respdev)
# solid = subset(m, m$adjective == "solid")
# outlierKD(solid, respdev)
# nice = subset(m, m$adjective == "nice")
# outlierKD(nice, respdev)
# moderate = subset(m, m$adjective == "moderate")
# outlierKD(moderate, respdev)
# radical = subset(m, m$adjective == "radical")
# outlierKD(radical, respdev)
# likely = subset(m, m$adjective == "likely")
# outlierKD(likely, respdev)
# extensive = subset(m, m$adjective == "extensive")
# outlierKD(extensive, respdev)
# unusual = subset(m, m$adjective == "unusual")
# outlierKD(unusual, respdev)
# liberal = subset(m, m$adjective == "liberal")
# outlierKD(liberal, respdev)
# crucial = subset(m, m$adjective == "crucial")
# outlierKD(crucial, respdev)
# vital = subset(m, m$adjective == "vital")
# outlierKD(vital, respdev)
# strong = subset(m, m$adjective == "strong")
# outlierKD(strong, respdev)
# impossible = subset(m, m$adjective == "impossible")
# outlierKD(impossible, respdev)
# routine = subset(m, m$adjective == "routine")
# outlierKD(routine, respdev)
# acceptable = subset(m, m$adjective == "acceptable")
# outlierKD(acceptable, respdev)
# significant = subset(m, m$adjective == "significant")
# outlierKD(significant, respdev)
# conservative = subset(m, m$adjective == "conservative")
# outlierKD(conservative, respdev)
# familiar = subset(m, m$adjective == "familiar")
# outlierKD(familiar, respdev)
# rd = rbind(relative, little, big, favorable, legitimate, sizable, tiny, extraordinary, weak, striking, rich, dramatic, fine, modest, important, unlikely, prominent, competitive, good, critical, sensitive, narrow, rare, generous, outstanding, considerable, typical, promising, normal, broad, light, powerful, high, huge, disappointing, traditional, serious, sound, grand, minor, remarkable, aggressive, usual, low, great, steep, sharp, slight, firm, obvious, tight, major, poor, clear, appropriate, small, thin, adequate, positive, substantial, impressive, large, fair, intense, unexpected, deep, fundamental, regular, surprising, stable, bullish, severe, healthy, bearish, reasonable, comfortable, hefty, inadequate, wide, excessive, valuable, conventional, ordinary, solid, nice, moderate, radical, likely, extensive, unusual, liberal, crucial, vital, strong, impossible, routine, acceptable, significant, conservative, familiar)
# 
# 
# rd=rd2
# 
# rd = subset(rd, adjective!="impossible")
# rd = subset(rd, adjective!="unlikely")
# # (data very different from the rest)
# 
# rd2 = subset(rd, respdev!="NA")
# nrow(rd2) # get rid of hadNegs first, then outliers
# #[1] 3352
# 
# #-----------------------------------------
# # Remove turkers with 4 or fewer left (so we can use turker as a random effect)
# #-----------------------------------------
# 
# 
# rd2 = subset(rd2, turker != "T_1637507")
# rd2 = subset(rd2, turker != "T_1693338")#
# rd2 = subset(rd2, turker != "T_210456")#     2
# rd2 = subset(rd2, turker != "T_290956")#     1
# rd2 = subset(rd2, turker != "T_3166001")#    1
# rd2 = subset(rd2, turker != "T_3763769")#    1
# rd2 = subset(rd2, turker != "T_4675580")#    2
# rd2 = subset(rd2, turker != "T_5041464")#    2
# rd2 = subset(rd2, turker != "T_5139008")#    1
# rd2 = subset(rd2, turker != "T_5341965")#    1
# rd2 = subset(rd2, turker != "T_5656483")#    1
# rd2 = subset(rd2, turker != "T_6630007")#    2
# rd2 = subset(rd2, turker != "T_7020912")#    1
# rd2 = subset(rd2, turker != "T_8155329")#    1
# rd2 = subset(rd2, turker != "T_8417097")#    3
# rd2 = subset(rd2, turker != "T_883092")#    1
# rd2 = subset(rd2, turker != "T_9136402")#    2
# rd2 = subset(rd2, turker != "T_9884243")#    2
# 
# nrow(rd2)
# # [1] 3326
# 
# #-----------------------------------------
# # Make rd4 —> with logRespDev
# #-----------------------------------------
# rd2$logrespdev = log(rd2$respdev + .Machine$double.eps)
# rd4 = subset(rd2, rd2$respdev > 0)
# 
# #-----------------------------------------
# # Make rd4_highfreq_30 
# #-----------------------------------------
# 
# rd4_highfreq_30 = subset(rd4, rd4$adjective %in% c( "good", "major", "high", "little", "big", "great", "clear", "small", "important", "strong", "likely", "large", "firm", "low", "serious", "light", "poor", "huge", "sound", "significant", "powerful", "positive", "fine", "conservative", "grand", "deep", "traditional", "wide", "critical", "regular" ))
# 
# # Remove the turkers that only had 1 response for purposes of cross-validation:
# rd4_highfreq_30_no1 = subset(rd4_highfreq_30, rd4_highfreq_30$turker != "T_7742505")
# rd4_highfreq_30_no1 = subset(rd4_highfreq_30_no1, rd4_highfreq_30_no1$turker != "T_8960927")
# 
# 
# #-----------------------------------------
# # LogRespDev model
# #-----------------------------------------
# #-----------------------------------------
# # BASIC MODELS:
# #-----------------------------------------
# 
# rd_basic_full_log = lmer(logrespdev ~ adjective
# 				+ mean + onestdev
# 				+ mean:onestdev
# 				+(1|turker), # random slope(right?) for each turk respondent
# 				data = rd4, REML = F)
# 
# summary(rd_basic_full_log)
# 
