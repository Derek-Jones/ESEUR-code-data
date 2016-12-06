#
# mkmars-obs.awk, 27 Nov 16

#
#               1988 11 08.69578 04 03 55.00 +19 54 12.9         x            035
#               1585 02 13.26042 00 00 00.00 +19 02 00.0         x            035

function abs(val)
{
if (val < 0)
   return -val

return val
}

BEGIN {
	CONVFMT="%.16g"
	FS=","
	}

$2 < 1600 {
	# The RA of an object at a sites meridian is the local sidereal time
	# Local sidereal time = Greenwich sidereal time-time latitude west
	# Greenwich sidereal time is calculated from...
	# The Julian date
	a = (14 - $6)/ 12
	y = $5 + 4800 - a
	m = $6 + 12*a - 3
	# It looks like Brahe was using the Julian calender
	JDN = $7 + int((153*m + 2)/5) + 365*y + int(y/4) - 32083
	# YY=$5
	# MM=$6
	# DY=$7
        # if (MM<3) { YY = YY - 1; MM = MM + 12; }
        # JD=int(365.25* YY)+int(30.6001*(MM+1))+DY+1720994.5
	# # print JDN " " JD
        # T=(JD- 2415020)/36525;
        # SS= 6.6460656 + 2400.051*T +0.00002581*T*T;
        # ST =(SS/24-int(SS/24))*24;
        # GSTH=int(ST);
        # GSTM=int((ST - int(ST)) * 60);
        # GSTS=((ST -int(ST)) * 60 - GSTM) * 60;
//        time sidereal 0h

	# Is the hour am or pm?
	hour=$9
	if ((hour >= 3) && (hour < 12))
	   hour+=12
	# Now convert Julian days+Solar time to Local sidereal time
	# Longitude of Braha's observatory 12.6951876 east
	D=JDN-2451545.0+((12.6951876/15)+(hour+$10/60+$11/3600))/24
	# http://aa.usno.navy.mil/faq/docs/GAST.php
	GMST=18.697374558 + 24.06570982441908*D
	RA=24+(GMST % 24)
	# print ST " " RA
	RA_hr=int(RA)
	RA_min=int((RA-RA_hr)*60)
	RA_sec=((RA-RA_hr)*60-RA_min)*60
	printf("     Mars      ");
	printf("%2d ", $5) # Year
	printf("%0.2d ", $6) # Month
	printf("%08.5f ", $8+(hour+$10/60)/24) # Day (Grigorian)+hour+min

	#printf("00 00 00.00 ") # RA
	printf("%0.2d %0.2d %05.2f ", RA_hr, RA_min, RA_sec) # RA

	# printf("%+0.2d %0.2d %0.2d.0", $14, $15, $16) # Declination
	dec_deg=int($17)
	dec_min=abs(int(($17-dec_deg)*60))
	dec_sec=abs((abs($17-dec_deg)*60-dec_min)*60)
	printf("%+0.2d %0.2d %04.1f", dec_deg, dec_min, dec_sec) # Declination

	printf("         x            035\n")
	next
	}
