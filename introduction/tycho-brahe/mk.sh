awk -f mkmars-obs.awk < mars-numbers.csv > prog-in.txt
sudo cp prog-3in.txt /mnt/memdisc/.
vi eph-mars.txt 
awk --lint -f mkephmars.awk <eph-mars.txt > pred.txt

