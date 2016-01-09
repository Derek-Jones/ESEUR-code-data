#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones
#$Rev: 12179 $ .
data <- read.table(paste0(ESEUR_dir, "src_measure/survey_68745_R_data_file.csv.xz"),
 sep=",", quote = "'", na.strings=c("","\"\""), stringsAsFactors=FALSE)

data[, 1] <- as.numeric(data[, 1])
names(data)[1] <- "id"

data[, 2] <- as.character(data[, 2])
names(data)[2] <- "submitdate"

#Field hidden

data[, 3] <- as.character(data[, 3])
names(data)[3] <- "startlanguage"

data[, 4] <- as.character(data[, 4])
names(data)[4] <- "datestamp"

data[, 5] <- as.character(data[, 5])
names(data)[5] <- "startdate"

data[, 6] <- NA
names(data)[6] <- "refurl"

data[, 7] <- as.numeric(data[, 7])
names(data)[7] <- "Did you participate in the original FLOSS survey in 2002"
data[, 7] <- factor(data[, 7], levels=c(1,2),labels=c("Yes","No"))

data[, 8] <- as.character(data[, 8])
names(data)[8] <- "Please select the area where your main contributions to FLOSS projects are:"
data[, 8] <- factor(data[, 8], levels=c("A1","A2","A3"),labels=c("Code, programming","Other contributions (documentation, translations, tests, artwork...)","Both"))

data[, 9] <- as.numeric(data[, 9])
names(data)[9] <- "E-mail address (or part of it):"

data[, 10] <- as.numeric(data[, 10])
names(data)[10] <- "Which of the following describes how you think of yourself"
data[, 10] <- factor(data[, 10], levels=c(1,2),labels=c("Male","Female"))

data[, 11] <- as.character(data[, 11])
names(data)[11] <- "[Other] Which of the following describes how you think of yourself"

data[, 12] <- as.numeric(data[, 12])
names(data)[12] <- "Do you have a partner"
data[, 12] <- factor(data[, 12], levels=c(1,2,3,4,5),labels=c("No, I am a single","Yes, although we do not live together","Yes, I live together with my partner","Yes, I am married","Yes, I am married, but we do not live together"))

data[, 13] <- as.numeric(data[, 13])
names(data)[13] <- "Do you have children"
data[, 13] <- factor(data[, 13], levels=c(1,2),labels=c("Yes","No"))

data[, 14] <- as.numeric(data[, 14])
names(data)[14] <- "How many children do you have"
data[, 14] <- factor(data[, 14], levels=c(1,2,3,4,5,6,7),labels=c("1","2","3","4","5","6","More than 6"))

data[, 15] <- as.numeric(data[, 15])
names(data)[15] <- "How old are your children"
data[, 15] <- factor(data[, 15], levels=c(1,2,3,4),labels=c("less than 2 years old","between 2 years and 5 years old","between 5 years and 10 years old","more than 10 years old"))

data[, 16] <- as.numeric(data[, 16])
names(data)[16] <- "What is your country of birth"
data[, 16] <- factor(data[, 16], levels=c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,231,232,233,234,235),labels=c("Afghanistan","Albania","Algeria","American Samoa","Andorra","Angola","Anguilla","Antarctica","Antigua and Barbuda","Argentina","Armenia","Aruba","Australia","Austria","Azerbaijan","Bahamas","Bahrain","Bangladesh","Barbados","Belarus","Belgium","Belize","Benin","Bermuda","Bhutan","Bolivia","Bosnia and Herzegovina","Botswana","Bouvet Island","Brazil","British Indian Ocean Territory","Brunei Darussalam","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Canada","Cape Verde","Cayman Islands","Central African Republic","Chad","Chile","China","Christmas Island","Cocos Islands","Colombia","Comoros","Congo","Cook Islands","Costa Rica","Cote d'Ivoire","Croatia","Cuba","Cyprus","Czech Republic","Denmark","Djibouti","Dominica","Dominican Republic","Ecuador","Egypt","El Salvador","Equatorial Guinea","Eritrea","Estonia","Ethiopia","Falkland Islands","Faroe Islands","Fiji","Finland","France","French Guiana","French Polynesia","Gabon","Gambia","Georgia","Germany","Ghana","Gibraltar","Greece","Greenland","Grenada","Guadeloupe","Guam","Guatemala","Guinea","Guinea-Bissau","Guyana","Haiti","Heard Island and McDonald Islands","Honduras","Hong Kong","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Israel","Italy","Jamaica","Japan","Jordan","Kazakhstan","Kenya","Kiribati","Kuwait","Kyrgyzstan","Laos","Latvia","Lebanon","Lesotho","Liberia","Libya","Liechtenstein","Lithuania","Luxembourg","Macao","Madagascar","Malawi","Malaysia","Maldives","Mali","Malta","Marshall Islands","Martinique","Mauritania","Mauritius","Mayotte","Mexico","Micronesia","Moldova","Monaco","Mongolia","Montenegro","Montserrat","Morocco","Mozambique","Myanmar","Namibia","Nauru","Nepal","Netherlands","Netherlands Antilles","New Caledonia","New Zealand","Nicaragua","Niger","Nigeria","Norfolk Island","North Korea","Norway","Oman","Pakistan","Palau","Palestinian Territory","Panama","Papua New Guinea","Paraguay","Peru","Philippines","Pitcairn","Poland","Portugal","Puerto Rico","Qatar","Romania","Russian Federation","Rwanda","Saint Helena","Soviet Union","Saint Lucia","Saint Pierre and Miquelon","Saint Vincent and the Grenadines","Samoa","San Marino","Sao Tome and Principe","Saudi Arabia","Senegal","Serbia","Seychelles","Sierra Leone","Singapore","Slovakia","Slovenia","Solomon Islands","Somalia","South Africa","South Georgia","South Korea","Spain","Sri Lanka","Sudan","Suriname","Svalbard and Jan Mayen","Swaziland","Sweden","Switzerland","Syrian Arab Republic","Taiwan","Tajikistan","Tanzania","Thailand","The Former Yugoslav Republic of Macedonia","Timor-Leste","Togo","Tokelau","Tonga","Trinidad and Tobago","Tunisia","Turkey","Turkmenistan","Tuvalu","Uganda","Ukraine","United Arab Emirates","United Kingdom","United States of America","United States Minor Outlying Islands","Uruguay","Uzbekistan","Vanuatu","Vatican City","Venezuela","Vietnam","Wallis and Futuna","Western Sahara","Yemen","Zambia","Zimbabwe"))

data[, 17] <- as.numeric(data[, 17])
names(data)[17] <- "Which is your country of residence or work"
data[, 17] <- factor(data[, 17], levels=c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,231,232,233,234,235),labels=c("Afghanistan","Albania","Algeria","American Samoa","Andorra","Angola","Anguilla","Antarctica","Antigua and Barbuda","Argentina","Armenia","Aruba","Australia","Austria","Azerbaijan","Bahamas","Bahrain","Bangladesh","Barbados","Belarus","Belgium","Belize","Benin","Bermuda","Bhutan","Bolivia","Bosnia and Herzegovina","Botswana","Bouvet Island","Brazil","British Indian Ocean Territory","Brunei Darussalam","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Canada","Cape Verde","Cayman Islands","Central African Republic","Chad","Chile","China","Christmas Island","Cocos Islands","Colombia","Comoros","Congo","Cook Islands","Costa Rica","Cote d'Ivoire","Croatia","Cuba","Cyprus","Czech Republic","Denmark","Djibouti","Dominica","Dominican Republic","Ecuador","Egypt","El Salvador","Equatorial Guinea","Eritrea","Estonia","Ethiopia","Falkland Islands","Faroe Islands","Fiji","Finland","France","French Guiana","French Polynesia","Gabon","Gambia","Georgia","Germany","Ghana","Gibraltar","Greece","Greenland","Grenada","Guadeloupe","Guam","Guatemala","Guinea","Guinea-Bissau","Guyana","Haiti","Heard Island and McDonald Islands","Honduras","Hong Kong","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Israel","Italy","Jamaica","Japan","Jordan","Kazakhstan","Kenya","Kiribati","Kuwait","Kyrgyzstan","Laos","Latvia","Lebanon","Lesotho","Liberia","Libya","Liechtenstein","Lithuania","Luxembourg","Macao","Madagascar","Malawi","Malaysia","Maldives","Mali","Malta","Marshall Islands","Martinique","Mauritania","Mauritius","Mayotte","Mexico","Micronesia","Moldova","Monaco","Mongolia","Montenegro","Montserrat","Morocco","Mozambique","Myanmar","Namibia","Nauru","Nepal","Netherlands","Netherlands Antilles","New Caledonia","New Zealand","Nicaragua","Niger","Nigeria","Norfolk Island","North Korea","Norway","Oman","Pakistan","Palau","Palestinian Territory","Panama","Papua New Guinea","Paraguay","Peru","Philippines","Pitcairn","Poland","Portugal","Puerto Rico","Qatar","Romania","Russian Federation","Rwanda","Saint Helena","Soviet Union","Saint Lucia","Saint Pierre and Miquelon","Saint Vincent and the Grenadines","Samoa","San Marino","Sao Tome and Principe","Saudi Arabia","Senegal","Serbia","Seychelles","Sierra Leone","Singapore","Slovakia","Slovenia","Solomon Islands","Somalia","South Africa","South Georgia","South Korea","Spain","Sri Lanka","Sudan","Suriname","Svalbard and Jan Mayen","Swaziland","Sweden","Switzerland","Syrian Arab Republic","Taiwan","Tajikistan","Tanzania","Thailand","The Former Yugoslav Republic of Macedonia","Timor-Leste","Togo","Tokelau","Tonga","Trinidad and Tobago","Tunisia","Turkey","Turkmenistan","Tuvalu","Uganda","Ukraine","United Arab Emirates","United Kingdom","United States of America","United States Minor Outlying Islands","Uruguay","Uzbekistan","Vanuatu","Vatican City","Venezuela","Vietnam","Wallis and Futuna","Western Sahara","Yemen","Zambia","Zimbabwe"))

data[, 18] <- as.numeric(data[, 18])
names(data)[18] <- "What is the highest level of education you have completed"
data[, 18] <- factor(data[, 18], levels=c(1,2,3,4,5,6,7),labels=c("Elementary School","High School","A-Level","Apprenticeship","University - Bachelors","University - Masters","University - PhD"))

data[, 19] <- as.numeric(data[, 19])
names(data)[19] <- "What is your level of English"
data[, 19] <- factor(data[, 19], levels=c(1,2,3,4,5,6,7),labels=c("A1 Breakthrough or beginner","A2 Waystage or elementary","B1 Threshold or intermediate","B2 Vantage or upper intermediate","C1 Effective Operational Proficiency or advanced","C2 Mastery or proficiency","It is my mother tongue"))

data[, 20] <- as.numeric(data[, 20])
names(data)[20] <- "What is your profession"
data[, 20] <- factor(data[, 20], levels=c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17),labels=c("Software engineer","Engineering (other than IT)","Programmer","Consultant (IT)","Consultant (other sectors)","Executive (IT)","Executive (other sectors)","Marketing (IT)","Marketing (other sectors)","Product sales (IT)","Product sales (other sectors)","University (IT)","University (other sectors)","Student (IT)","Student (other sectors)","Other (IT)","Other (other sectors)"))

data[, 21] <- as.numeric(data[, 21])
names(data)[21] <- "How would you describe your job"
data[, 21] <- factor(data[, 21], levels=c(1,2,3,4,5,6),labels=c("It is what I always wanted to do, I really love my job","It is interesting, but I can imagine to do another interesting job, too","I just get well paid, I do it primarily for the money","I could not find an employment in my favorite job, it is second best","I do not like it very much, if there is an opportunity, I will change","I really hate my job"))

data[, 22] <- as.numeric(data[, 22])
names(data)[22] <- "What applies to you? I am.."
data[, 22] <- factor(data[, 22], levels=c(1,2,3,4,5),labels=c("Self-employed","Employed","Unemployed","Not paid work (student)","Not paid work (stay-home, etc.)"))

data[, 23] <- as.character(data[, 23])
names(data)[23] <- "[Other] What applies to you? I am.."

data[, 24] <- as.numeric(data[, 24])
names(data)[24] <- "What is your monthly gross income? Please select the appropriate category"
data[, 24] <- factor(data[, 24], levels=c(1,2,3,4,5,6,7,8,9),labels=c("0 EURO / US Dollars","less than 1000 EURO / US Dollars","1001 - 2000 EURO / US Dollars","2001 - 3000 EURO / US Dollars","3001 - 4000 EURO / US Dollars","4001 - 5000 EURO / US Dollars","5001 - 7500 EURO / US Dollars","7501 - 10.000 EURO / US Dollars","more than 10.000 EURO / US Dollars"))

data[, 25] <- as.character(data[, 25])
names(data)[25] <- "In the following questions we will always use the term \"Free, Libre, Open Source Software\" (FLOSS), although we know that many developers make a sharp distinction between these concepts. Do you think of yourself as part of the Free Software or as part of the Open Source community"
data[, 25] <- factor(data[, 25], levels=c("A1","A2","A3"),labels=c("I think of myself as part of the Free Software community","I think of myself as part of the Open Source community","I do not care"))

data[, 26] <- as.character(data[, 26])
names(data)[26] <- "Do you think that Free Software and Open Source communities are different communities"
data[, 26] <- factor(data[, 26], levels=c("A1","A2","A3"),labels=c("Yes, it is not only a different way of thinking, it is a different way of living","Yes, but only in their principles. The way they work is the same","It does not bother me. I like just programming"))

data[, 27] <- as.character(data[, 27])
names(data)[27] <- "Do you think that Free Software and Open Source communities are different communities"
data[, 27] <- factor(data[, 27], levels=c("A1","A2","A3"),labels=c("Yes, it is not only a different way of thinking, it is a different way of living","Yes, but only in their principles. The way they work is the same","It does not bother me. I like just making software"))

data[, 28] <- as.numeric(data[, 28])
names(data)[28] <- "[Hendrik Breitkreuz] do you know (not necessarily personally)"
data[, 28] <- factor(data[, 28], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 29] <- as.numeric(data[, 29])
names(data)[29] <- "[Miguel de Icaza] do you know (not necessarily personally)"
data[, 29] <- factor(data[, 29], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 30] <- as.numeric(data[, 30])
names(data)[30] <- "[Rèmi Denis-Courmont] do you know (not necessarily personally)"
data[, 30] <- factor(data[, 30], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 31] <- as.numeric(data[, 31])
names(data)[31] <- "[Matthias Ettrich] do you know (not necessarily personally)"
data[, 31] <- factor(data[, 31], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 32] <- as.numeric(data[, 32])
names(data)[32] <- "[Paul Gardner] do you know (not necessarily personally)"
data[, 32] <- factor(data[, 32], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 33] <- as.numeric(data[, 33])
names(data)[33] <- "[Luciano Mendietti] do you know (not necessarily personally)"
data[, 33] <- factor(data[, 33], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 34] <- as.numeric(data[, 34])
names(data)[34] <- "[Dru Mortensen] do you know (not necessarily personally)"
data[, 34] <- factor(data[, 34], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 35] <- as.numeric(data[, 35])
names(data)[35] <- "[Murat Ozgobek] do you know (not necessarily personally)"
data[, 35] <- factor(data[, 35], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 36] <- as.numeric(data[, 36])
names(data)[36] <- "[Igor Pavlov] do you know (not necessarily personally)"
data[, 36] <- factor(data[, 36], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 37] <- as.numeric(data[, 37])
names(data)[37] <- "[Bruce Perens] do you know (not necessarily personally)"
data[, 37] <- factor(data[, 37], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 38] <- as.numeric(data[, 38])
names(data)[38] <- "[Eric Raymond] do you know (not necessarily personally)"
data[, 38] <- factor(data[, 38], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 39] <- as.numeric(data[, 39])
names(data)[39] <- "[Noa Resare] do you know (not necessarily personally)"
data[, 39] <- factor(data[, 39], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 40] <- as.numeric(data[, 40])
names(data)[40] <- "[Richard Stallman] do you know (not necessarily personally)"
data[, 40] <- factor(data[, 40], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 41] <- as.numeric(data[, 41])
names(data)[41] <- "[Linus Torvalds] do you know (not necessarily personally)"
data[, 41] <- factor(data[, 41], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 42] <- as.numeric(data[, 42])
names(data)[42] <- "[Jamie Zawinski] do you know (not necessarily personally)"
data[, 42] <- factor(data[, 42], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 43] <- as.numeric(data[, 43])
names(data)[43] <- "I started in"
data[, 43] <- factor(data[, 43], levels=c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37),labels=c("Before 1960","Between 1960 and 1970","Between 1970 and 1980","1980","1981","1982","1983","1984","1985","1986","1987","1988","1989","1990","1991","1992","1993","1994","1995","1996","1997","1998","1999","2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010","2011","2012","2013"))

data[, 44] <- as.numeric(data[, 44])
names(data)[44] <- "My age then was:"
data[, 44] <- factor(data[, 44], levels=c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46),labels=c("10 or younger","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55 or older"))

data[, 45] <- as.numeric(data[, 45])
names(data)[45] <- "On average, how many hours per week did you work on FLOSS projects in the last year"
data[, 45] <- factor(data[, 45], levels=c(1,2,3,4,5,6),labels=c("Less than 2","2 - 5","6 - 10","11 - 20","21 - 40","More than 40"))

data[, 46] <- as.numeric(data[, 46])
names(data)[46] <- "Do you also develop proprietary software"
data[, 46] <- factor(data[, 46], levels=c(1,2),labels=c("Yes","No"))

data[, 47] <- as.numeric(data[, 47])
names(data)[47] <- "Are you involved as well in any way with proprietary software"
data[, 47] <- factor(data[, 47], levels=c(1,2),labels=c("Yes","No"))

data[, 48] <- as.numeric(data[, 48])
names(data)[48] <- "When did you start to develop proprietary software"
data[, 48] <- factor(data[, 48], levels=c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37),labels=c("Before 1960","Between 1960 and 1970","Between 1970 and 1980","1980","1981","1982","1983","1984","1985","1986","1987","1988","1989","1990","1991","1992","1993","1994","1995","1996","1997","1998","1999","2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010","2011","2012","2013"))

data[, 49] <- as.numeric(data[, 49])
names(data)[49] <- "When did you start your involvement with proprietary software"
data[, 49] <- factor(data[, 49], levels=c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37),labels=c("Before 1960","Between 1960 and 1970","Between 1970 and 1980","1980","1981","1982","1983","1984","1985","1986","1987","1988","1989","1990","1991","1992","1993","1994","1995","1996","1997","1998","1999","2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010","2011","2012","2013"))

data[, 50] <- as.numeric(data[, 50])
names(data)[50] <- "On average, how many hours per week did you work on proprietary software projects last year"
data[, 50] <- factor(data[, 50], levels=c(1,2,3,4,5,6),labels=c("Less than 2","2 - 5","6 - 10","11 - 20","21 - 40","more than 40"))

data[, 51] <- as.numeric(data[, 51])
names(data)[51] <- "On average, how many hours per week did you work on proprietary software projects last year"
data[, 51] <- factor(data[, 51], levels=c(1,2,3,4,5,6),labels=c("Less than 2","2 - 5","6 - 10","11 - 20","21 - 40","more than 40"))

data[, 52] <- as.numeric(data[, 52])
names(data)[52] <- "[to participate in new forms of cooperation] Why did you start developing/distributing FLOSS"
data[, 52] <- factor(data[, 52], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 53] <- as.numeric(data[, 53])
names(data)[53] <- "[to learn and develop new skills] Why did you start developing/distributing FLOSS"
data[, 53] <- factor(data[, 53], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 54] <- as.numeric(data[, 54])
names(data)[54] <- "[to share my knowledge and skills] Why did you start developing/distributing FLOSS"
data[, 54] <- factor(data[, 54], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 55] <- as.numeric(data[, 55])
names(data)[55] <- "[to participate in the FLOSS scene] Why did you start developing/distributing FLOSS"
data[, 55] <- factor(data[, 55], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 56] <- as.numeric(data[, 56])
names(data)[56] <- "[to improve my job opportunities] Why did you start developing/distributing FLOSS"
data[, 56] <- factor(data[, 56], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 57] <- as.numeric(data[, 57])
names(data)[57] <- "[to improve FLOSS products of other developers] Why did you start developing/distributing FLOSS"
data[, 57] <- factor(data[, 57], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 58] <- as.numeric(data[, 58])
names(data)[58] <- "[to get a reputation in the FLOSS developers’ scene] Why did you start developing/distributing FLOSS"
data[, 58] <- factor(data[, 58], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 59] <- as.numeric(data[, 59])
names(data)[59] <- "[to distribute not marketable software] Why did you start developing/distributing FLOSS"
data[, 59] <- factor(data[, 59], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 60] <- as.numeric(data[, 60])
names(data)[60] <- "[to get help in realizing a good idea for a software product] Why did you start developing/distributing FLOSS"
data[, 60] <- factor(data[, 60], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 61] <- as.numeric(data[, 61])
names(data)[61] <- "[to solve a problem that could not be done by proprietary software] Why did you start developing/distributing FLOSS"
data[, 61] <- factor(data[, 61], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 62] <- as.numeric(data[, 62])
names(data)[62] <- "[to limit the power of large software companies] Why did you start developing/distributing FLOSS"
data[, 62] <- factor(data[, 62], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 63] <- as.numeric(data[, 63])
names(data)[63] <- "[because I think that software should not be a proprietary product] Why did you start developing/distributing FLOSS"
data[, 63] <- factor(data[, 63], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 64] <- as.numeric(data[, 64])
names(data)[64] <- "[to make money] Why did you start developing/distributing FLOSS"
data[, 64] <- factor(data[, 64], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 65] <- as.numeric(data[, 65])
names(data)[65] <- "[I do not know] Why did you start developing/distributing FLOSS"
data[, 65] <- factor(data[, 65], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 66] <- as.numeric(data[, 66])
names(data)[66] <- "[to participate in new forms of cooperation] Why did you start contributing to FLOSS"
data[, 66] <- factor(data[, 66], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 67] <- as.numeric(data[, 67])
names(data)[67] <- "[to learn and develop new skills] Why did you start contributing to FLOSS"
data[, 67] <- factor(data[, 67], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 68] <- as.numeric(data[, 68])
names(data)[68] <- "[to share my knowledge and skills] Why did you start contributing to FLOSS"
data[, 68] <- factor(data[, 68], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 69] <- as.numeric(data[, 69])
names(data)[69] <- "[to participate in the FLOSS scene] Why did you start contributing to FLOSS"
data[, 69] <- factor(data[, 69], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 70] <- as.numeric(data[, 70])
names(data)[70] <- "[to improve my job opportunities] Why did you start contributing to FLOSS"
data[, 70] <- factor(data[, 70], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 71] <- as.numeric(data[, 71])
names(data)[71] <- "[to improve FLOSS products of others] Why did you start contributing to FLOSS"
data[, 71] <- factor(data[, 71], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 72] <- as.numeric(data[, 72])
names(data)[72] <- "[to get a reputation in the FLOSS scene] Why did you start contributing to FLOSS"
data[, 72] <- factor(data[, 72], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 73] <- as.numeric(data[, 73])
names(data)[73] <- "[to distribute not marketable software] Why did you start contributing to FLOSS"
data[, 73] <- factor(data[, 73], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 74] <- as.numeric(data[, 74])
names(data)[74] <- "[to get help in realizing a good idea for a software product] Why did you start contributing to FLOSS"
data[, 74] <- factor(data[, 74], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 75] <- as.numeric(data[, 75])
names(data)[75] <- "[to solve a problem that could not be done by proprietary software] Why did you start contributing to FLOSS"
data[, 75] <- factor(data[, 75], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 76] <- as.numeric(data[, 76])
names(data)[76] <- "[to limit the power of large software companies] Why did you start contributing to FLOSS"
data[, 76] <- factor(data[, 76], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 77] <- as.numeric(data[, 77])
names(data)[77] <- "[because I think that software should not be a proprietary product] Why did you start contributing to FLOSS"
data[, 77] <- factor(data[, 77], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 78] <- as.numeric(data[, 78])
names(data)[78] <- "[to make money] Why did you start contributing to FLOSS"
data[, 78] <- factor(data[, 78], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 79] <- as.numeric(data[, 79])
names(data)[79] <- "[I do not know] Why did you start contributing to FLOSS"
data[, 79] <- factor(data[, 79], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 80] <- as.numeric(data[, 80])
names(data)[80] <- "[to participate in new forms of cooperation] And today? For what reason(s) do you go on with developing and/or distributing FLOSS"
data[, 80] <- factor(data[, 80], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 81] <- as.numeric(data[, 81])
names(data)[81] <- "[to learn and develop new skills] And today? For what reason(s) do you go on with developing and/or distributing FLOSS"
data[, 81] <- factor(data[, 81], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 82] <- as.numeric(data[, 82])
names(data)[82] <- "[to share my knowledge and skills] And today? For what reason(s) do you go on with developing and/or distributing FLOSS"
data[, 82] <- factor(data[, 82], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 83] <- as.numeric(data[, 83])
names(data)[83] <- "[to participate in the FLOSS scene] And today? For what reason(s) do you go on with developing and/or distributing FLOSS"
data[, 83] <- factor(data[, 83], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 84] <- as.numeric(data[, 84])
names(data)[84] <- "[to improve my job opportunities] And today? For what reason(s) do you go on with developing and/or distributing FLOSS"
data[, 84] <- factor(data[, 84], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 85] <- as.numeric(data[, 85])
names(data)[85] <- "[to improve FLOSS products of other developers] And today? For what reason(s) do you go on with developing and/or distributing FLOSS"
data[, 85] <- factor(data[, 85], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 86] <- as.numeric(data[, 86])
names(data)[86] <- "[to get a reputation in the FLOSS developers’ scene] And today? For what reason(s) do you go on with developing and/or distributing FLOSS"
data[, 86] <- factor(data[, 86], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 87] <- as.numeric(data[, 87])
names(data)[87] <- "[to distribute not marketable software] And today? For what reason(s) do you go on with developing and/or distributing FLOSS"
data[, 87] <- factor(data[, 87], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 88] <- as.numeric(data[, 88])
names(data)[88] <- "[to get help in realizing a good idea for a software product] And today? For what reason(s) do you go on with developing and/or distributing FLOSS"
data[, 88] <- factor(data[, 88], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 89] <- as.numeric(data[, 89])
names(data)[89] <- "[to solve a problem that could not be done by proprietary software] And today? For what reason(s) do you go on with developing and/or distributing FLOSS"
data[, 89] <- factor(data[, 89], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 90] <- as.numeric(data[, 90])
names(data)[90] <- "[to limit the power of large software companies] And today? For what reason(s) do you go on with developing and/or distributing FLOSS"
data[, 90] <- factor(data[, 90], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 91] <- as.numeric(data[, 91])
names(data)[91] <- "[because I think that software should not be a proprietary product] And today? For what reason(s) do you go on with developing and/or distributing FLOSS"
data[, 91] <- factor(data[, 91], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 92] <- as.numeric(data[, 92])
names(data)[92] <- "[to make money] And today? For what reason(s) do you go on with developing and/or distributing FLOSS"
data[, 92] <- factor(data[, 92], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 93] <- as.numeric(data[, 93])
names(data)[93] <- "[I do not know] And today? For what reason(s) do you go on with developing and/or distributing FLOSS"
data[, 93] <- factor(data[, 93], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 94] <- as.numeric(data[, 94])
names(data)[94] <- "[to participate in new forms of cooperation] And today? For what reason(s) do you go on with contributing to FLOSS"
data[, 94] <- factor(data[, 94], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 95] <- as.numeric(data[, 95])
names(data)[95] <- "[to learn and develop new skills] And today? For what reason(s) do you go on with contributing to FLOSS"
data[, 95] <- factor(data[, 95], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 96] <- as.numeric(data[, 96])
names(data)[96] <- "[to share my knowledge and skills] And today? For what reason(s) do you go on with contributing to FLOSS"
data[, 96] <- factor(data[, 96], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 97] <- as.numeric(data[, 97])
names(data)[97] <- "[to participate in the FLOSS scene] And today? For what reason(s) do you go on with contributing to FLOSS"
data[, 97] <- factor(data[, 97], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 98] <- as.numeric(data[, 98])
names(data)[98] <- "[to improve my job opportunities] And today? For what reason(s) do you go on with contributing to FLOSS"
data[, 98] <- factor(data[, 98], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 99] <- as.numeric(data[, 99])
names(data)[99] <- "[to improve FLOSS products of others] And today? For what reason(s) do you go on with contributing to FLOSS"
data[, 99] <- factor(data[, 99], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 100] <- as.numeric(data[, 100])
names(data)[100] <- "[to get a reputation in the FLOSS scene] And today? For what reason(s) do you go on with contributing to FLOSS"
data[, 100] <- factor(data[, 100], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 101] <- as.numeric(data[, 101])
names(data)[101] <- "[to distribute not marketable software] And today? For what reason(s) do you go on with contributing to FLOSS"
data[, 101] <- factor(data[, 101], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 102] <- as.numeric(data[, 102])
names(data)[102] <- "[to get help in realizing a good idea for a software product] And today? For what reason(s) do you go on with contributing to FLOSS"
data[, 102] <- factor(data[, 102], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 103] <- as.numeric(data[, 103])
names(data)[103] <- "[to solve a problem that could not be done by proprietary software] And today? For what reason(s) do you go on with contributing to FLOSS"
data[, 103] <- factor(data[, 103], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 104] <- as.numeric(data[, 104])
names(data)[104] <- "[to limit the power of large software companies] And today? For what reason(s) do you go on with contributing to FLOSS"
data[, 104] <- factor(data[, 104], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 105] <- as.numeric(data[, 105])
names(data)[105] <- "[because I think that software should not be a proprietary product] And today? For what reason(s) do you go on with contributing to FLOSS"
data[, 105] <- factor(data[, 105], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 106] <- as.numeric(data[, 106])
names(data)[106] <- "[to make money] And today? For what reason(s) do you go on with contributing to FLOSS"
data[, 106] <- factor(data[, 106], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 107] <- as.numeric(data[, 107])
names(data)[107] <- "[I do not know] And today? For what reason(s) do you go on with contributing to FLOSS"
data[, 107] <- factor(data[, 107], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 108] <- as.numeric(data[, 108])
names(data)[108] <- "Do you use FLOSS at work or if you are studying, at university/college/school"
data[, 108] <- factor(data[, 108], levels=c(1,2),labels=c("Yes","No"))

data[, 109] <- as.numeric(data[, 109])
names(data)[109] <- "Do you earn money from FLOSS, either directly or indirectly"
data[, 109] <- factor(data[, 109], levels=c(1,2,3,4,5,6,7,9),labels=c("No","Yes, directly: I am paid for developing FLOSS","Yes, directly: I am paid for supporting FLOSS","Yes, directly: I am paid for administrating FLOSS","Yes, directly: Other reasons","Yes, indirectly: I got my job because of my previous FLOSS experience","Yes, indirectly: my job description does not include FLOSS development but I also develop FLOSS in my work","Yes, indirectly: Other reasons"))

data[, 110] <- as.numeric(data[, 110])
names(data)[110] <- "Which of the following is your favorite editor"
data[, 110] <- factor(data[, 110], levels=c(1,2,3,4,5),labels=c("Eclipse","Emacs/XEmacs","Netbeans","Textmate","Vi/Vim"))

data[, 111] <- as.character(data[, 111])
names(data)[111] <- "[Other] Which of the following is your favorite editor"

data[, 112] <- as.numeric(data[, 112])
names(data)[112] <- "[C] In which tools and programming languages are you experienced in"
data[, 112] <- factor(data[, 112], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 113] <- as.numeric(data[, 113])
names(data)[113] <- "[C++] In which tools and programming languages are you experienced in"
data[, 113] <- factor(data[, 113], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 114] <- as.numeric(data[, 114])
names(data)[114] <- "[Objective C] In which tools and programming languages are you experienced in"
data[, 114] <- factor(data[, 114], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 115] <- as.numeric(data[, 115])
names(data)[115] <- "[Java] In which tools and programming languages are you experienced in"
data[, 115] <- factor(data[, 115], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 116] <- as.numeric(data[, 116])
names(data)[116] <- "[Python] In which tools and programming languages are you experienced in"
data[, 116] <- factor(data[, 116], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 117] <- as.numeric(data[, 117])
names(data)[117] <- "[Perl] In which tools and programming languages are you experienced in"
data[, 117] <- factor(data[, 117], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 118] <- as.numeric(data[, 118])
names(data)[118] <- "[PHP] In which tools and programming languages are you experienced in"
data[, 118] <- factor(data[, 118], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 119] <- as.numeric(data[, 119])
names(data)[119] <- "[Unix shell] In which tools and programming languages are you experienced in"
data[, 119] <- factor(data[, 119], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 120] <- as.numeric(data[, 120])
names(data)[120] <- "[HTML] In which tools and programming languages are you experienced in"
data[, 120] <- factor(data[, 120], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 121] <- as.numeric(data[, 121])
names(data)[121] <- "[LISP] In which tools and programming languages are you experienced in"
data[, 121] <- factor(data[, 121], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 122] <- as.numeric(data[, 122])
names(data)[122] <- "[(La)Tex] In which tools and programming languages are you experienced in"
data[, 122] <- factor(data[, 122], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 123] <- as.numeric(data[, 123])
names(data)[123] <- "[Pascal] In which tools and programming languages are you experienced in"
data[, 123] <- factor(data[, 123], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 124] <- as.numeric(data[, 124])
names(data)[124] <- "[Fortran] In which tools and programming languages are you experienced in"
data[, 124] <- factor(data[, 124], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 125] <- as.numeric(data[, 125])
names(data)[125] <- "[Basic] In which tools and programming languages are you experienced in"
data[, 125] <- factor(data[, 125], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 126] <- as.numeric(data[, 126])
names(data)[126] <- "[Visual Basic] In which tools and programming languages are you experienced in"
data[, 126] <- factor(data[, 126], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 127] <- as.numeric(data[, 127])
names(data)[127] <- "[JavaScript] In which tools and programming languages are you experienced in"
data[, 127] <- factor(data[, 127], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 128] <- as.numeric(data[, 128])
names(data)[128] <- "[SQL] In which tools and programming languages are you experienced in"
data[, 128] <- factor(data[, 128], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 129] <- as.numeric(data[, 129])
names(data)[129] <- "[ADA] In which tools and programming languages are you experienced in"
data[, 129] <- factor(data[, 129], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 130] <- as.numeric(data[, 130])
names(data)[130] <- "[Modula] In which tools and programming languages are you experienced in"
data[, 130] <- factor(data[, 130], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 131] <- as.numeric(data[, 131])
names(data)[131] <- "[Eiffel] In which tools and programming languages are you experienced in"
data[, 131] <- factor(data[, 131], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 132] <- as.numeric(data[, 132])
names(data)[132] <- "[Prolog] In which tools and programming languages are you experienced in"
data[, 132] <- factor(data[, 132], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 133] <- as.numeric(data[, 133])
names(data)[133] <- "[XML / SGML] In which tools and programming languages are you experienced in"
data[, 133] <- factor(data[, 133], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 134] <- as.numeric(data[, 134])
names(data)[134] <- "[Ruby] In which tools and programming languages are you experienced in"
data[, 134] <- factor(data[, 134], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 135] <- as.numeric(data[, 135])
names(data)[135] <- "[Smalltalk] In which tools and programming languages are you experienced in"
data[, 135] <- factor(data[, 135], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 136] <- as.numeric(data[, 136])
names(data)[136] <- "[Tcl] In which tools and programming languages are you experienced in"
data[, 136] <- factor(data[, 136], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 137] <- as.numeric(data[, 137])
names(data)[137] <- "[Make] In which tools and programming languages are you experienced in"
data[, 137] <- factor(data[, 137], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 138] <- as.numeric(data[, 138])
names(data)[138] <- "[Scheme] In which tools and programming languages are you experienced in"
data[, 138] <- factor(data[, 138], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 139] <- as.numeric(data[, 139])
names(data)[139] <- "[Versioning systems] In which tools and programming languages are you experienced in"
data[, 139] <- factor(data[, 139], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 140] <- as.numeric(data[, 140])
names(data)[140] <- "[C] In which tools and programming languages are you experienced in"
data[, 140] <- factor(data[, 140], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 141] <- as.numeric(data[, 141])
names(data)[141] <- "[C++] In which tools and programming languages are you experienced in"
data[, 141] <- factor(data[, 141], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 142] <- as.numeric(data[, 142])
names(data)[142] <- "[Objective C] In which tools and programming languages are you experienced in"
data[, 142] <- factor(data[, 142], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 143] <- as.numeric(data[, 143])
names(data)[143] <- "[Java] In which tools and programming languages are you experienced in"
data[, 143] <- factor(data[, 143], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 144] <- as.numeric(data[, 144])
names(data)[144] <- "[Python] In which tools and programming languages are you experienced in"
data[, 144] <- factor(data[, 144], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 145] <- as.numeric(data[, 145])
names(data)[145] <- "[Perl] In which tools and programming languages are you experienced in"
data[, 145] <- factor(data[, 145], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 146] <- as.numeric(data[, 146])
names(data)[146] <- "[PHP] In which tools and programming languages are you experienced in"
data[, 146] <- factor(data[, 146], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 147] <- as.numeric(data[, 147])
names(data)[147] <- "[Unix shell] In which tools and programming languages are you experienced in"
data[, 147] <- factor(data[, 147], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 148] <- as.numeric(data[, 148])
names(data)[148] <- "[HTML] In which tools and programming languages are you experienced in"
data[, 148] <- factor(data[, 148], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 149] <- as.numeric(data[, 149])
names(data)[149] <- "[LISP] In which tools and programming languages are you experienced in"
data[, 149] <- factor(data[, 149], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 150] <- as.numeric(data[, 150])
names(data)[150] <- "[(La)Tex] In which tools and programming languages are you experienced in"
data[, 150] <- factor(data[, 150], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 151] <- as.numeric(data[, 151])
names(data)[151] <- "[Pascal] In which tools and programming languages are you experienced in"
data[, 151] <- factor(data[, 151], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 152] <- as.numeric(data[, 152])
names(data)[152] <- "[Fortran] In which tools and programming languages are you experienced in"
data[, 152] <- factor(data[, 152], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 153] <- as.numeric(data[, 153])
names(data)[153] <- "[Basic] In which tools and programming languages are you experienced in"
data[, 153] <- factor(data[, 153], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 154] <- as.numeric(data[, 154])
names(data)[154] <- "[Visual Basic] In which tools and programming languages are you experienced in"
data[, 154] <- factor(data[, 154], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 155] <- as.numeric(data[, 155])
names(data)[155] <- "[JavaScript] In which tools and programming languages are you experienced in"
data[, 155] <- factor(data[, 155], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 156] <- as.numeric(data[, 156])
names(data)[156] <- "[SQL] In which tools and programming languages are you experienced in"
data[, 156] <- factor(data[, 156], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 157] <- as.numeric(data[, 157])
names(data)[157] <- "[ADA] In which tools and programming languages are you experienced in"
data[, 157] <- factor(data[, 157], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 158] <- as.numeric(data[, 158])
names(data)[158] <- "[Modula] In which tools and programming languages are you experienced in"
data[, 158] <- factor(data[, 158], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 159] <- as.numeric(data[, 159])
names(data)[159] <- "[Eiffel] In which tools and programming languages are you experienced in"
data[, 159] <- factor(data[, 159], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 160] <- as.numeric(data[, 160])
names(data)[160] <- "[Prolog] In which tools and programming languages are you experienced in"
data[, 160] <- factor(data[, 160], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 161] <- as.numeric(data[, 161])
names(data)[161] <- "[XML / SGML] In which tools and programming languages are you experienced in"
data[, 161] <- factor(data[, 161], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 162] <- as.numeric(data[, 162])
names(data)[162] <- "[Ruby] In which tools and programming languages are you experienced in"
data[, 162] <- factor(data[, 162], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 163] <- as.numeric(data[, 163])
names(data)[163] <- "[Smalltalk] In which tools and programming languages are you experienced in"
data[, 163] <- factor(data[, 163], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 164] <- as.numeric(data[, 164])
names(data)[164] <- "[Tcl] In which tools and programming languages are you experienced in"
data[, 164] <- factor(data[, 164], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 165] <- as.numeric(data[, 165])
names(data)[165] <- "[Make] In which tools and programming languages are you experienced in"
data[, 165] <- factor(data[, 165], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 166] <- as.numeric(data[, 166])
names(data)[166] <- "[Scheme] In which tools and programming languages are you experienced in"
data[, 166] <- factor(data[, 166], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 167] <- as.numeric(data[, 167])
names(data)[167] <- "[Versioning systems] In which tools and programming languages are you experienced in"
data[, 167] <- factor(data[, 167], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 168] <- as.numeric(data[, 168])
names(data)[168] <- "[None of them] In which tools and programming languages are you experienced in"
data[, 168] <- factor(data[, 168], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 169] <- as.character(data[, 169])
names(data)[169] <- "Do you use non-FLOSS software/services in your daily life, or for development"
data[, 169] <- factor(data[, 169], levels=c("A1","A2","A3"),labels=c("No, I try to avoid using non-FLOSS software/services as much as I can","I choose to use non-FLOSS software/services for certain tasks","Yes, no problem. I use the best software/services despite being FLOSS or not"))

data[, 170] <- as.character(data[, 170])
names(data)[170] <- "Do you use non-FLOSS software/services in your daily life, or for your contributions"
data[, 170] <- factor(data[, 170], levels=c("A1","A2","A3"),labels=c("No, I try to avoid using non-FLOSS software/services as much as I can","I choose to use non-FLOSS software/services for certain tasks","Yes, no problem. I use the best software/services despite being FLOSS or not"))

data[, 171] <- as.numeric(data[, 171])
names(data)[171] <- "In how many FLOSS development projects have you been involved so far"
data[, 171] <- factor(data[, 171], levels=c(1,2,3,4,5,6,7,8),labels=c("1-5","6-10","11-20","21-30","31-50","51-75","76-100","more than 100"))

data[, 172] <- as.numeric(data[, 172])
names(data)[172] <- "In how many FLOSS development projects have you been involved in as a leader, coordinator, or administrator"
data[, 172] <- factor(data[, 172], levels=c(0,1,2,3,4,5,6,7,8,9),labels=c("None","1","2","3","4-5","6-7","8-10","11-15","16-20","more than 20"))

data[, 173] <- as.numeric(data[, 173])
names(data)[173] <- "Overall, would you say that FLOSS satisfies today\'s requirements for software better than proprietary software"
data[, 173] <- factor(data[, 173], levels=c(1,2,3,4),labels=c("Yes","No","They have nothing to do with each other","I do not know"))

data[, 174] <- as.numeric(data[, 174])
names(data)[174] <- "People working in the domain of FLOSS are more concerned about money than people in the proprietary software domain"
data[, 174] <- factor(data[, 174], levels=c(1,2,3),labels=c("This is good","This is bad","This is not true"))

data[, 175] <- as.numeric(data[, 175])
names(data)[175] <- "People working in the domain of proprietary software are more concerned about money than people in the FLOSS domain"
data[, 175] <- factor(data[, 175], levels=c(1,2,3),labels=c("This is good","This is bad","This is not true"))

data[, 176] <- as.numeric(data[, 176])
names(data)[176] <- "[for a general discussion about software] What is your opinion of the FLOSS scene.."
data[, 176] <- factor(data[, 176], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 177] <- as.numeric(data[, 177])
names(data)[177] <- "[for a sporty competition about the best code] What is your opinion of the FLOSS scene.."
data[, 177] <- factor(data[, 177], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 178] <- as.numeric(data[, 178])
names(data)[178] <- "[for innovative breakthroughs] What is your opinion of the FLOSS scene.."
data[, 178] <- factor(data[, 178], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 179] <- as.numeric(data[, 179])
names(data)[179] <- "[providing imitations of proprietary software products and services] What is your opinion of the FLOSS scene.."
data[, 179] <- factor(data[, 179], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 180] <- as.numeric(data[, 180])
names(data)[180] <- "[for software developers who need a toolbox] What is your opinion of the FLOSS scene.."
data[, 180] <- factor(data[, 180], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 181] <- as.numeric(data[, 181])
names(data)[181] <- "[providing more variety of software] What is your opinion of the FLOSS scene.."
data[, 181] <- factor(data[, 181], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 182] <- as.numeric(data[, 182])
names(data)[182] <- "[for people with the same interests] What is your opinion of the FLOSS scene.."
data[, 182] <- factor(data[, 182], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 183] <- as.numeric(data[, 183])
names(data)[183] <- "[for people who look for project partners] What is your opinion of the FLOSS scene.."
data[, 183] <- factor(data[, 183], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 184] <- as.numeric(data[, 184])
names(data)[184] <- "[for people using new forms of cooperation] What is your opinion of the FLOSS scene.."
data[, 184] <- factor(data[, 184], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 185] <- as.numeric(data[, 185])
names(data)[185] <- "[that enables more freedom in software development] What is your opinion of the FLOSS scene.."
data[, 185] <- factor(data[, 185], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 186] <- as.numeric(data[, 186])
names(data)[186] <- "[for career improvements] What is your opinion of the FLOSS scene.."
data[, 186] <- factor(data[, 186], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 187] <- as.numeric(data[, 187])
names(data)[187] <- "[to exchange knowledge] What is your opinion of the FLOSS scene.."
data[, 187] <- factor(data[, 187], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 188] <- as.numeric(data[, 188])
names(data)[188] <- "[for people looking for fun] What is your opinion of the FLOSS scene.."
data[, 188] <- factor(data[, 188], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 189] <- as.numeric(data[, 189])
names(data)[189] <- "Would you say that expertise in the FLOSS community has a positive impact on job opportunities"
data[, 189] <- factor(data[, 189], levels=c(1,2,3),labels=c("Yes","No","I do not know"))

data[, 190] <- as.numeric(data[, 190])
names(data)[190] <- "Developers contribute to the FLOSS community in different ways, and they receive many benefits from it. In general, how do you assess your balance"
data[, 190] <- factor(data[, 190], levels=c(1,2,3,4,5),labels=c("I give more than I take","I take more than I give","I give as much as I take","I do not care","I do not know"))

data[, 191] <- as.numeric(data[, 191])
names(data)[191] <- "People contribute to the FLOSS community in different ways, and they receive many benefits from it. In general, how do you assess your balance"
data[, 191] <- factor(data[, 191], levels=c(1,2,3,4,5),labels=c("I give more than I take","I take more than I give","I give as much as I take","I do not care","I do not know"))

data[, 192] <- as.numeric(data[, 192])
names(data)[192] <- "When you consider other developers of FLOSS, how do you assess their balance"
data[, 192] <- factor(data[, 192], levels=c(1,2,3,4,5,6),labels=c("Most give more than they take","Most take more than they give","They give as much as they take","They do not care","I do not care","I do not know"))

data[, 193] <- as.numeric(data[, 193])
names(data)[193] <- "When you consider other contributors to FLOSS, how do you assess their balance"
data[, 193] <- factor(data[, 193], levels=c(1,2,3,4,5,6),labels=c("Most give more than they take","Most take more than they give","They give as much as they take","They do not care","I do not care","I do not know"))

data[, 194] <- as.numeric(data[, 194])
names(data)[194] <- "To develop FLOSS is a kind of self-exploitation, because you supply a lot of good ideas and work, and do not receive any benefits in return! To what extent do you agree or disagree with the following statement"
data[, 194] <- factor(data[, 194], levels=c(1,2,3,4,5),labels=c("I totally agree","I agree","I rather disagree","I do not agree at all","I do not know"))

data[, 195] <- as.numeric(data[, 195])
names(data)[195] <- "[to be able to cooperate in a new way] What do you expect from other FLOSS developers"
data[, 195] <- factor(data[, 195], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 196] <- as.numeric(data[, 196])
names(data)[196] <- "[to let me learn and develop new skills] What do you expect from other FLOSS developers"
data[, 196] <- factor(data[, 196], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 197] <- as.numeric(data[, 197])
names(data)[197] <- "[to share their knowledge and skills] What do you expect from other FLOSS developers"
data[, 197] <- factor(data[, 197], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 198] <- as.numeric(data[, 198])
names(data)[198] <- "[to take part in the main communications and discussions] What do you expect from other FLOSS developers"
data[, 198] <- factor(data[, 198], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 199] <- as.numeric(data[, 199])
names(data)[199] <- "[to write beautiful and aesthetic programs] What do you expect from other FLOSS developers"
data[, 199] <- factor(data[, 199], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 200] <- as.numeric(data[, 200])
names(data)[200] <- "[to provide better job opportunities] What do you expect from other FLOSS developers"
data[, 200] <- factor(data[, 200], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 201] <- as.numeric(data[, 201])
names(data)[201] <- "[to improve FLOSS products of other developers] What do you expect from other FLOSS developers"
data[, 201] <- factor(data[, 201], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 202] <- as.numeric(data[, 202])
names(data)[202] <- "[to respect me and my contributions to FLOSS] What do you expect from other FLOSS developers"
data[, 202] <- factor(data[, 202], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 203] <- as.numeric(data[, 203])
names(data)[203] <- "[to distribute not marketable software] What do you expect from other FLOSS developers"
data[, 203] <- factor(data[, 203], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 204] <- as.numeric(data[, 204])
names(data)[204] <- "[to help in realizing ideas for software products] What do you expect from other FLOSS developers"
data[, 204] <- factor(data[, 204], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 205] <- as.numeric(data[, 205])
names(data)[205] <- "[to solve a problem that could not be solved by proprietary software] What do you expect from other FLOSS developers"
data[, 205] <- factor(data[, 205], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 206] <- as.numeric(data[, 206])
names(data)[206] <- "[to help limiting the power of large software companies] What do you expect from other FLOSS developers"
data[, 206] <- factor(data[, 206], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 207] <- as.numeric(data[, 207])
names(data)[207] <- "[to make money] What do you expect from other FLOSS developers"
data[, 207] <- factor(data[, 207], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 208] <- as.numeric(data[, 208])
names(data)[208] <- "[I do not know] What do you expect from other FLOSS developers"
data[, 208] <- factor(data[, 208], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 209] <- as.numeric(data[, 209])
names(data)[209] <- "[to be able to cooperate in a new way] What do you expect from other FLOSS contributors"
data[, 209] <- factor(data[, 209], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 210] <- as.numeric(data[, 210])
names(data)[210] <- "[to let me learn and develop new skills] What do you expect from other FLOSS contributors"
data[, 210] <- factor(data[, 210], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 211] <- as.numeric(data[, 211])
names(data)[211] <- "[to share their knowledge and skills] What do you expect from other FLOSS contributors"
data[, 211] <- factor(data[, 211], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 212] <- as.numeric(data[, 212])
names(data)[212] <- "[to take part in the main communications and discussions] What do you expect from other FLOSS contributors"
data[, 212] <- factor(data[, 212], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 213] <- as.numeric(data[, 213])
names(data)[213] <- "[to write beautiful and aesthetic programs] What do you expect from other FLOSS contributors"
data[, 213] <- factor(data[, 213], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 214] <- as.numeric(data[, 214])
names(data)[214] <- "[to provide better job opportunities] What do you expect from other FLOSS contributors"
data[, 214] <- factor(data[, 214], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 215] <- as.numeric(data[, 215])
names(data)[215] <- "[to improve FLOSS products of others] What do you expect from other FLOSS contributors"
data[, 215] <- factor(data[, 215], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 216] <- as.numeric(data[, 216])
names(data)[216] <- "[to respect me and my contributions to FLOSS] What do you expect from other FLOSS contributors"
data[, 216] <- factor(data[, 216], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 217] <- as.numeric(data[, 217])
names(data)[217] <- "[to distribute not marketable software] What do you expect from other FLOSS contributors"
data[, 217] <- factor(data[, 217], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 218] <- as.numeric(data[, 218])
names(data)[218] <- "[to help in realizing ideas for software products] What do you expect from other FLOSS contributors"
data[, 218] <- factor(data[, 218], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 219] <- as.numeric(data[, 219])
names(data)[219] <- "[to solve a problem that could not be solved by proprietary software] What do you expect from other FLOSS contributors"
data[, 219] <- factor(data[, 219], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 220] <- as.numeric(data[, 220])
names(data)[220] <- "[to help limiting the power of large software companies] What do you expect from other FLOSS contributors"
data[, 220] <- factor(data[, 220], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 221] <- as.numeric(data[, 221])
names(data)[221] <- "[to make money] What do you expect from other FLOSS contributors"
data[, 221] <- factor(data[, 221], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 222] <- as.numeric(data[, 222])
names(data)[222] <- "[I do not know] What do you expect from other FLOSS contributors"
data[, 222] <- factor(data[, 222], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 223] <- as.numeric(data[, 223])
names(data)[223] <- "[to be able to cooperate in a new way] What do you think other FLOSS developers expect from you"
data[, 223] <- factor(data[, 223], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 224] <- as.numeric(data[, 224])
names(data)[224] <- "[to let them learn and develop new skills] What do you think other FLOSS developers expect from you"
data[, 224] <- factor(data[, 224], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 225] <- as.numeric(data[, 225])
names(data)[225] <- "[to share my knowledge and skills] What do you think other FLOSS developers expect from you"
data[, 225] <- factor(data[, 225], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 226] <- as.numeric(data[, 226])
names(data)[226] <- "[to take part in the main communications and discussions] What do you think other FLOSS developers expect from you"
data[, 226] <- factor(data[, 226], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 227] <- as.numeric(data[, 227])
names(data)[227] <- "[to write beautiful and aesthetic programs] What do you think other FLOSS developers expect from you"
data[, 227] <- factor(data[, 227], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 228] <- as.numeric(data[, 228])
names(data)[228] <- "[to provide better job opportunities] What do you think other FLOSS developers expect from you"
data[, 228] <- factor(data[, 228], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 229] <- as.numeric(data[, 229])
names(data)[229] <- "[to improve FLOSS products of other developers] What do you think other FLOSS developers expect from you"
data[, 229] <- factor(data[, 229], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 230] <- as.numeric(data[, 230])
names(data)[230] <- "[to respect them and their contributions to FLOSS] What do you think other FLOSS developers expect from you"
data[, 230] <- factor(data[, 230], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 231] <- as.numeric(data[, 231])
names(data)[231] <- "[to distribute not marketable software] What do you think other FLOSS developers expect from you"
data[, 231] <- factor(data[, 231], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 232] <- as.numeric(data[, 232])
names(data)[232] <- "[to help in realizing ideas for software products] What do you think other FLOSS developers expect from you"
data[, 232] <- factor(data[, 232], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 233] <- as.numeric(data[, 233])
names(data)[233] <- "[to solve a problem that could not be solved by proprietary software] What do you think other FLOSS developers expect from you"
data[, 233] <- factor(data[, 233], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 234] <- as.numeric(data[, 234])
names(data)[234] <- "[to help limiting the power of large software companies] What do you think other FLOSS developers expect from you"
data[, 234] <- factor(data[, 234], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 235] <- as.numeric(data[, 235])
names(data)[235] <- "[to make money] What do you think other FLOSS developers expect from you"
data[, 235] <- factor(data[, 235], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 236] <- as.numeric(data[, 236])
names(data)[236] <- "[I do not know] What do you think other FLOSS developers expect from you"
data[, 236] <- factor(data[, 236], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 237] <- as.numeric(data[, 237])
names(data)[237] <- "[to be able to cooperate in a new way] What do you think other FLOSS contributors expect from you"
data[, 237] <- factor(data[, 237], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 238] <- as.numeric(data[, 238])
names(data)[238] <- "[to let them learn and develop new skills] What do you think other FLOSS contributors expect from you"
data[, 238] <- factor(data[, 238], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 239] <- as.numeric(data[, 239])
names(data)[239] <- "[to share my knowledge and skills] What do you think other FLOSS contributors expect from you"
data[, 239] <- factor(data[, 239], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 240] <- as.numeric(data[, 240])
names(data)[240] <- "[to take part in the main communications and discussions] What do you think other FLOSS contributors expect from you"
data[, 240] <- factor(data[, 240], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 241] <- as.numeric(data[, 241])
names(data)[241] <- "[to write beautiful and aesthetic programs] What do you think other FLOSS contributors expect from you"
data[, 241] <- factor(data[, 241], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 242] <- as.numeric(data[, 242])
names(data)[242] <- "[to provide better job opportunities] What do you think other FLOSS contributors expect from you"
data[, 242] <- factor(data[, 242], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 243] <- as.numeric(data[, 243])
names(data)[243] <- "[to improve FLOSS products of others] What do you think other FLOSS contributors expect from you"
data[, 243] <- factor(data[, 243], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 244] <- as.numeric(data[, 244])
names(data)[244] <- "[to respect them and their contributions to FLOSS] What do you think other FLOSS contributors expect from you"
data[, 244] <- factor(data[, 244], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 245] <- as.numeric(data[, 245])
names(data)[245] <- "[to distribute not marketable software] What do you think other FLOSS contributors expect from you"
data[, 245] <- factor(data[, 245], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 246] <- as.numeric(data[, 246])
names(data)[246] <- "[to help in realizing ideas for software products] What do you think other FLOSS contributors expect from you"
data[, 246] <- factor(data[, 246], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 247] <- as.numeric(data[, 247])
names(data)[247] <- "[to solve a problem that could not be solved by proprietary software] What do you think other FLOSS contributors expect from you"
data[, 247] <- factor(data[, 247], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 248] <- as.numeric(data[, 248])
names(data)[248] <- "[to help limiting the power of large software companies] What do you think other FLOSS contributors expect from you"
data[, 248] <- factor(data[, 248], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 249] <- as.numeric(data[, 249])
names(data)[249] <- "[to make money] What do you think other FLOSS contributors expect from you"
data[, 249] <- factor(data[, 249], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 250] <- as.numeric(data[, 250])
names(data)[250] <- "[I do not know] What do you think other FLOSS contributors expect from you"
data[, 250] <- factor(data[, 250], levels=c(1,0),labels=c("Yes","Not selected"))

data[, 251] <- as.numeric(data[, 251])
names(data)[251] <- "[Make our software stable (reduce bugs)] Below you can find some possible challenges to face by the main FLOSS project in which you are involved. Please select the importance you give to each one"
data[, 251] <- factor(data[, 251], levels=c(1,2,3,4,5,6,7),labels=c("It's not important","It's ok","It's ok, could be better","I'm worried but got no ideas","I'm participating in dealing with this","It's driving me/others out of the project","I don't know"))

data[, 252] <- as.numeric(data[, 252])
names(data)[252] <- "[Feature set] Below you can find some possible challenges to face by the main FLOSS project in which you are involved. Please select the importance you give to each one"
data[, 252] <- factor(data[, 252], levels=c(1,2,3,4,5,6,7),labels=c("It's not important","It's ok","It's ok, could be better","I'm worried but got no ideas","I'm participating in dealing with this","It's driving me/others out of the project","I don't know"))

data[, 253] <- as.numeric(data[, 253])
names(data)[253] <- "[Documentation] Below you can find some possible challenges to face by the main FLOSS project in which you are involved. Please select the importance you give to each one"
data[, 253] <- factor(data[, 253], levels=c(1,2,3,4,5,6,7),labels=c("It's not important","It's ok","It's ok, could be better","I'm worried but got no ideas","I'm participating in dealing with this","It's driving me/others out of the project","I don't know"))

data[, 254] <- as.numeric(data[, 254])
names(data)[254] <- "[Make our software cross-platform/mobile/SaaS] Below you can find some possible challenges to face by the main FLOSS project in which you are involved. Please select the importance you give to each one"
data[, 254] <- factor(data[, 254], levels=c(1,2,3,4,5,6,7),labels=c("It's not important","It's ok","It's ok, could be better","I'm worried but got no ideas","I'm participating in dealing with this","It's driving me/others out of the project","I don't know"))

data[, 255] <- as.numeric(data[, 255])
names(data)[255] <- "[Reduce time between releases] Below you can find some possible challenges to face by the main FLOSS project in which you are involved. Please select the importance you give to each one"
data[, 255] <- factor(data[, 255], levels=c(1,2,3,4,5,6,7),labels=c("It's not important","It's ok","It's ok, could be better","I'm worried but got no ideas","I'm participating in dealing with this","It's driving me/others out of the project","I don't know"))

data[, 256] <- as.numeric(data[, 256])
names(data)[256] <- "[Attract users/contributors] Below you can find some possible challenges to face by the main FLOSS project in which you are involved. Please select the importance you give to each one"
data[, 256] <- factor(data[, 256], levels=c(1,2,3,4,5,6,7),labels=c("It's not important","It's ok","It's ok, could be better","I'm worried but got no ideas","I'm participating in dealing with this","It's driving me/others out of the project","I don't know"))

data[, 257] <- as.numeric(data[, 257])
names(data)[257] <- "[Keep users/contributors involved] Below you can find some possible challenges to face by the main FLOSS project in which you are involved. Please select the importance you give to each one"
data[, 257] <- factor(data[, 257], levels=c(1,2,3,4,5,6,7),labels=c("It's not important","It's ok","It's ok, could be better","I'm worried but got no ideas","I'm participating in dealing with this","It's driving me/others out of the project","I don't know"))

data[, 258] <- as.numeric(data[, 258])
names(data)[258] <- "[Leverage the power of the leader/main company] Below you can find some possible challenges to face by the main FLOSS project in which you are involved. Please select the importance you give to each one"
data[, 258] <- factor(data[, 258], levels=c(1,2,3,4,5,6,7),labels=c("It's not important","It's ok","It's ok, could be better","I'm worried but got no ideas","I'm participating in dealing with this","It's driving me/others out of the project","I don't know"))

data[, 259] <- as.numeric(data[, 259])
names(data)[259] <- "[Fundraising] Below you can find some possible challenges to face by the main FLOSS project in which you are involved. Please select the importance you give to each one"
data[, 259] <- factor(data[, 259], levels=c(1,2,3,4,5,6,7),labels=c("It's not important","It's ok","It's ok, could be better","I'm worried but got no ideas","I'm participating in dealing with this","It's driving me/others out of the project","I don't know"))

data[, 260] <- as.numeric(data[, 260])
names(data)[260] <- "[Legal issues (license, copyright assignments...)] Below you can find some possible challenges to face by the main FLOSS project in which you are involved. Please select the importance you give to each one"
data[, 260] <- factor(data[, 260], levels=c(1,2,3,4,5,6,7),labels=c("It's not important","It's ok","It's ok, could be better","I'm worried but got no ideas","I'm participating in dealing with this","It's driving me/others out of the project","I don't know"))

data[, 261] <- as.numeric(data[, 261])
names(data)[261] <- "[Communication inside the project] Below you can find some possible challenges to face by the main FLOSS project in which you are involved. Please select the importance you give to each one"
data[, 261] <- factor(data[, 261], levels=c(1,2,3,4,5,6,7),labels=c("It's not important","It's ok","It's ok, could be better","I'm worried but got no ideas","I'm participating in dealing with this","It's driving me/others out of the project","I don't know"))

data[, 262] <- as.numeric(data[, 262])
names(data)[262] <- "[Communication upstream/downstream] Below you can find some possible challenges to face by the main FLOSS project in which you are involved. Please select the importance you give to each one"
data[, 262] <- factor(data[, 262], levels=c(1,2,3,4,5,6,7),labels=c("It's not important","It's ok","It's ok, could be better","I'm worried but got no ideas","I'm participating in dealing with this","It's driving me/others out of the project","I don't know"))

