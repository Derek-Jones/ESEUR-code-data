#
# numstruct.sh, 10 Apr 09

echo -n "" > Agstruct.num
echo -n "" > Trstruct.num
echo -n "" > Restruct.num
echo -n "" > Ststruct.num

for f in 2005/* 2008/*
   do
   awk -f numfield.awk -vKIND_PROB="Agriculture"< $f | grep struct | wc -l | sed '/^0/d' >> Agstruct.num
   awk -f numfield.awk -vKIND_PROB="Transport"< $f | grep struct | wc -l | sed '/^0/d' >> Trstruct.num
   awk -f numfield.awk -vKIND_PROB="Resources"< $f | grep struct | wc -l | sed '/^0/d' >> Restruct.num
   done

cat Agstruct.num Trstruct.num Restruct.num > Allstruct.num

for f in loyola08-annotated/*
   do
   awk -f numfield.awk -vKIND_PROB="Agriculture"< $f | grep struct | wc -l | sed '/^0/d' >> Ststruct.num
   done

