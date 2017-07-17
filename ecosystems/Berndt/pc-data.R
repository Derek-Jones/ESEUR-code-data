#
# pc-data.R, 18 Apr 16
#
# Data from:
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("foreign")

pc7=read.dta(paste0(ESEUR_dir, "ecosystems/Berndt/pc7699a.dta"))

pc_1987=subset(pc7, year < 1988)

RAPID CHANGE IN THE PERSONAL COMPUTER MARKET
A QUALITY-ADJUSTED HEDONIC PRICE INDEX 1976- 1987
by
JEREMY MICHAEL COHEN
MSc thesis

1) RAM - The amount of Random Access Memory (RAM) standard on each
PC model, measured in K (1024) bytes.
2) Maximum RAM - The maximum amount of RAM that can fit on the system
board (mother-board) of each PC model, measured in K bytes (logical
groupings of eight on/off bits). This figure does not include possible RAM
increases due to expansion cards, since RAM access is typically faster on
the system board than on expansion cards, placing a premium on the amount
of fast system board RAM that the system can have. Also, expansion slots
are typically multi-functional and not restricted to just RAM cards, so the
amount of expansion card based RAM can be quite variable for most PC models.
3) ROM - The amount of Read Only Memory (ROM) standard in each PC
model, measured in K bytes. Since ROM usually contains diagnostics and
low-level operating system routines, this variable may well serve as a
surrogate for the sophistication of the software packages in the PC.
4) Mhz - The clock speed of each PC mode, measured in Megahertz (million of
cycles per second). This is one of the main indicators (along with processor
type) of the throughput of a PC.
5) Hard Disk - The amount of storage on the hard disk (if one exists) in each
PC, measured in M (1024*1024) bytes. A hard disk is often the dividing line be-
tween a home system and an office system, though this distinction has blurred in
recent years. 332 of the 1108 models in the data set had hard disks.
6) Hard Disk Access Speed - The average time it takes to retrieve a byte of in-
formation from the hard disk, measured in milliseconds. This information
would be more useful if it were supplemented by the seek and rotation times of
the hard disks, but it was extremely difficult to obtain this data.
7) Floppy Disk - The amount of storage that the floppy disk drives, if any
exist, are capable of reading or writing to a floppy disk, measured in K bytes.
This includes the flexible 8", 5.25" and 3.5" media and excludes fixed media.
8) Number of Floppy Disk Drives - The number of floppy disk drives standard
on each PC model. A variable equivalent to this one for hard disk drives is
not necessary, since all of the PC models examined had either zero or one hard
disks, while the PCs had either zero, one, or two floppy disk drives.
9) Slots (8 bit) - The number of eight bit expansion slots available within each
PC model for expansion boards.
10) Slots (16 bit) - The number of sixteen bit slots available within each PC
model for expansion boards.
11) Slots (32 bit) - The number of thirty-two bit slots available within each PC
model for expansion boards.
Note: The above three "slot" variables posed a few problems. First, both PC
ads and reviews often failed to state whether any of the slots mentioned were
already filled within the standard setup. To be consistent I have used the
total number of slots in the system, irrespective of whether the slots may
have been initially filled. This may not be optimal, but it was the best
solution given the available data. Since a machine would normally not have
more than one or two slots initially filled, this should not cause any major
problems.  Another problem is that some ads and reviews specified only the
number of slots, not the size of the slots. I resolved this problem through
the use of multiple data sources (particularly the Dataquest guide). In the
few cases where the situation was still unresolved, I assumed that the size
of the slots was the same as the size of the PC's processor chip. This is a
reasonably safe assumption that should not have any negative effects on
the regression analysis.
12) Size - The size of each PC model, measured in cubic inches. This includes
the system unit but normally excludes the weight of the monitor or keyboard.
These components are included, however, if they are integral to the system
unit (i.e., IBM Convertible).
13) Weight - The weight of each PC model, measured in pounds. This includes
the system unit but normally does not include the weight of the monitor or
keyboard. These components are included, however, if they are integral to
the system unit (i.e., Apple Macintosh).
14) Age - The number of years since a given PC model was first introduced. A
model has an age of zero its initial year. This variable ranges from zero to
seven (for the Radio Shack Color Computer) and provides useful information
on the effects of longevity on pricing. 
Note that while the specifications of many PC models changed over time, as
long as the model name remained constant the model was considered to be the
same as the model from the previous year.

Age   Number of Data Points
0       649
1       257
2       118
3        46
4        25
5         9
6         3
7         1
       ----
       1108
Note: The hard disk size, number of floppy disk drives, number of slots, and
age variables had the value one added to them so that it would be possible to
take their natural log during the regression analysis.

Dummy Variables

The twenty-six dummy variables are divided into eight subdivisions, as
described above. The variables and subdivisions are:
1) Processor Type - All of the PCs in my study have either eight bit,
sixteen bit or thirty-two bit processors, this being an indication of how
much data the system can process at a given time. The higher this number,
ceteris paribus, the greater the throughput of the system.
A few processor chips, such as the 68000, can manipulate differing amounts of
data depending on the operation. In this case I have grouped such multiple-size
chips in the lower applicable group, both because this is how these chips are
normally viewed and because the throughput of the chip is restricted by
its lowest grouping.

15) DProcl6 - 1 if the system has a sixteen bit processor chip, 0 otherwise.
16) DProc32 - 1 if the system has a thirty-two bit processor chip, 0 otherwise.

Thus, the base case for this subdivision is having an eight bit processor chip.
In my 1108 data point sample, 540 of the PCs had eight bit processor chips,
506 had sixteen bit processor chips, and 62 had thirty-two bit processor chips.

11) Monitor Type - While many PCs are sold without a monitor, they are also
sometimes sold either with a black and white (B&W) or a color monitor.

17) DBW - 1 if the system comes with a B&W monitor, 0 otherwise.
18) DColor - 1 if the system comes with a color monitor, 0 otherwise.

Thus, the base case for this subdivision is not having a monitor. In my 1108
data point set, 605 of the PCs had no monitor, 478 had a B&W monitor and
25 had a color monitor.

III) Portability - Some PCs, often called "portables" or "convertibles," are
made small and light enough to be portable. These PCs often also have special
features such as battery power capability and an integral monitor.
19) DPortable - 1 if the system is meant to be portable, 0 otherwise.
Thus, the base case for this subdivision is not being portable. In my 1108
point data set, 937 of the systems were not portable, while 171 were
explicitly portable.

IV) Additional Technical Features - Some PCs have extra hardware that is costly
enough to have a significant effect on their overall price, yet rare enough
not to be considered a standard item. Some examples include modems, printers,
or an extra monitor.

20) DExtra - I if the system has a significant piece of additional hardware,
0 otherwise.  Thus, the base case for this subdivision is not having any
additional equipment.

V) Price Type - In my sample I have both list prices and discount prices. This
allows an analysis of discount pricing and also provides more overall
variability in the pricing data. In particular, it is not unusual to see a
PC's list price remain steady over 2-3 years while its discount price may
drop steadily over this time.
21) DDiscount - 1 if the system price is discounted, 0 otherwise.
The base case for this subdivision is having a list price. In my sample, 841 of
the systems had list price information and 267 had discount prices.

VI) Manufacturer - In my data set I have PCs from 114 different companies. In
this subdivision, I attempt to discover any differences in pricing among seven
major PC manufacturers. While any pricing discrepancies may possibly be
accounted for by intangibles such as quality and reliability or more tangible
items such as warranties and included software, these discrepancies may
also be an indicator of a company's overall pricing policy.
22) DApple - I if the PC is made by Apple, 0 otherwise.
23) DCommo - 1 if the PC is made by Commodore, 0 otherwise.
24) DCompa - 1 if the PC is made by Compaq, 0 otherwise.
25) DIBM - 1 if the PC is made by IBM, 0 otherwise.
26) DNEC - I if the PC is made by NEC, 0 otherwise.
27) DPCLim - 1 if the PC is made by PC Limited, 0 otherwise.
28) DRadio - I if the PC is made by Radio Shack, 0 otherwise.
The base case for this subdivision is to be manufactured by one of the 107 other
PC companies. Of the 1108 PC data points, 62 were made by Apple, 40 by
Commodore, 59 by Compaq, 94 by IBM, 36 by NEC, 21 by PC Limited, 85 by Radio
Shack, and 711 by other companies. Thus, 35.4% (396 of 1108) of the models were
built by these seven manufacturers.

VII) Date - The heart of a hedonic pricing study are the yearly dummy variables.
The data in my sample runs from 1976 to 1987, resulting in eleven of these dummy
variables. The parameter coefficients obtained for these variables will be
directly used to construct the hedonic price index.
29) D77 this model/price data point from 1977, otherwise.
30) D78 this model/price data point from 1978, otherwise.
31) D79 this model/price data point from 1979, otherwise.
32) D80 this model/price data point from 1980, otherwise.
33) D81 this model/price data point from 1981, otherwise.
34) D82 this model/price data point from 1982, otherwise.
35) D83 this model/price data point from 1983, otherwise.
36) D84 this model/price data point from 1984, otherwise.
37) D85 this model/price data point from 1985, otherwise.
38) D86 this model/price data point from 1986, otherwise.
39) D87 this model/price data point from 1987, otherwise.
The base case for this subdivision is a model/price data point from 1976. The
number of data points from each year is as follows:
Year # of Data Points
1976   11
1977   17
1978   15
1979   28
1980   45
1981   40
1982   54
1983   85
1984  130
1985  109
1986  178
1987  396
     ----
     1108

VIII) Pre/Post IBM Date - IBM revolutionized the PC industry when it released
its PC line at the end of 1981. Since this may well have affected overall
industry pricing, I examined it using the following dummy variable:
40) DP82 - I if the system data point is from after 1981, 0 otherwise.
The base case for this subdivision is for the data point to be from before 1982.
Of the 1108 data points, 156 are from before 1982, while 952 are from 1982 or later.

Overall Base Case
The overall base case (in which all of the dummy variables equal 0) is: a PC
model with an eight bit processor, no monitor, non-portable, with no extra
hardware features, list price, not from one of the seven specified
manufacturers, from 1976, and from before the late 1981 IBM announcement
date for its PCs.

Omitted Variables
There were several independent variables that I considered using in the initial
regression equation but eventually chose not to use, for various reasons.
These variables are:
1) Hard Disk Seek Speed - This information proved to be very difficult to obtain
for the early PC models, since it was rarely reported either in advertisements
or in product reviews. However, it should prove to be highly correlated with
the hard disk access speed variable, which is included in the regression.
Thus, I conjecture that this variable would not have added much new
information to the analysis.
2) Floppy Disk Access/Seek Speed - This information was difficult to obtain for
recent PC models and often impossible for the earlier models. Thus, I was not
able to gather enough entries for this variable to make it worthwhile for
inclusion in the regression.
3) Asynchronous (Asynch.) Card - While the information on whether each PC
came with an Asynch. card was often available, I decided that this variable
would likely not add much to the regression analysis, since the cost/value of
an asynch.  card is quite low (on the order of $20-40).
4) Clock/Calendar Card - Similar to the asynch. card, the low cost/value of a
clock/calendar card (about $20) implied that it was not worth adding it to the
regression, even though this information was often available.


orig=pc7[, !grepl("^gen", names(pc7))]
orig=orig[, !grepl("^d", names(orig))]
 
