#
# map-corsair.sh, 19 Feb 14

# According to: http://forum.corsair.com/v3/showthread.php?p=413430
# sed -r 's/CM([A-Z]+)([0-9]+)GX([1-3])M([1-9])([A-Z]+)([0-9]+)C+([0-9]+)(.*)$/\1,\2,\3,\4,\5,\7,\8/'

echo "module type,part density,DDR,number modules,revision,speed,CAS latency,extras"

sed -r 's/CM([A-Z]+)([0-9]+)GX([1-4])M([1-9])([A-Z]+)([0-9]+)C*([0-9]*)([^,]*)/1,\2,\3,\4,\5,\6,\7,\8/' | \
sed -r 's/CM([1-4])X([0-9]+)G([A-Z]+)([0-9]+)C*([0-9]*)([^,]*)/NA,\2,\1,NA,\3,\4,\5,\6/' | \
sed -r 's/CM([1-4])B([0-9]+)G([0-9]+)C([0-9]+)([^,]*)/NA,\2,\1,NA,NA,\4,\3,\5/' | \
sed -r 's/CM([1-4])X([0-9]+)G([0-9]+)C([0-9]+)([^,]*)/NA,\2,\1,NA,NA,\3,\4,\5/' | \
sed -r 's/CGM([1-4])X([0-9]+)G([0-9]+)([^,]*)/NA,\2,\1,NA,NA,\3,NA,\4/' | \
sed -r 's/CM([1-4])X([0-9]+)-([0-9]+)C([0-9]+)([^,]*)/NA,\2,\1,NA,NA,\3,\4,\5/' | \
sed -r 's/CM([1-4])X([0-9]+)-([0-9]+)([^,]*)/NA,\2,\1,NA,NA,\3,NA,\4/' | \
sed 's/,,/,NA,/' | sed 's/,$/,NA/' | \
sed '/,CM/d' | sed '/CGM/d' | sed '/2GBA/d'

