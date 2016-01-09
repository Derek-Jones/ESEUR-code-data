
From: http://forum.corsair.com/v3/showthread.php?p=413430

CM -> Corsair Memory

Code 	(1..2) 	#G 	X# 	M# 	(1..2) 	#	C#
Part # 	D 	8G 	X3 	M4 	A	1600 	C8

NOTE:
(1..2) means that one or 2 characters will appear here
# means that a number will appear here


Here's what each section of the part number means:

Code 	Meaning
(1..2) 	Module Type
#G 	Total Part Number Density
X# 	Memory Tech (DDR1 / DDR2 / DDR3)
M# 	Module Quantity (Number of Modules)
(1..2) 	Revision
# 	Speed (MHz)
C# 	CAS Latency

(1..2) 	Module Type
C 	XMS classic (old) heat spreader
X 	XMS classic (new) heat spreader
Z 	Vengeance series
L 	Vengeance Low Profile
D 	Dominator or Platinum
P 	D but with something added
G 	GT with Airflow II
GS 	GT single module
T 	G but with something added
R 	Retail
E 	Non-Registered ECC
S 	Registered ECC
SO 	SoDIMM
SX 	SoDIMM Vengeance
V 	Value Select (or equivalent)


sed -e 's/CM([A-Z]+)([0-9]+)GX([1-3])M([1-9])A([A-Z0-9]+)([0-9]+)C([0-9]+)(.+)$/\1,\2,\3,\4,\5,\7,\8/

sed -e 's/CM([1-3])X([0-9]+)G([0-9]+)C([0-9]+)(.+)$/NA,\1,\3,\2,NA,NA,\4,\5/

sed -e 's/CM([1-3])X([0-9]+)-([0-9]+)C([0-9]+)(.+)$/NA,\1,\3,\2,NA,NA,\4,\5/


