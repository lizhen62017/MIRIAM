#!/bin/bash

startu=$1
endu=$2
step=$3

stbarr=$4
endbarr=$5


delta=$(echo "$endu - $startu" | bc )
window=$(echo "$delta/$step" | bc )
echo "The distance between start and end point is $delta Ang"
echo "$window windows of umbrella sampling will be generated"

kval=1673.6
barrval=1000

offset=0
newend=$(echo "$offset+$window" | bc )

for ((i=$offset; i<=$newend; i+=1 ))
do

	ref=$(echo "$startu+$step*($i-$offset)" | bc -l)
        #j=$(echo "$i*2" | bc -l)
        echo "this is $i"
	if (( $(echo "$ref >= $stbarr" |bc -l) )) && (( $(echo "$ref <= $endbarr" |bc -l) ))
	then 
		kappa=$barrval

	else
		kappa=$kval

	fi

	echo "at $ref k=$kappa kj/mol/A^2"

rm -r u$i
cp -r tmp/ u$i
cp $ref/start.rst u$i

echo "#RESTART

UNITS LENGTH=A TIME=ps ENERGY=kj/mol

#com: COM ATOMS=1-9 # com of imi

dis: DISTANCE ATOMS=54, 55 #distance between Ni2+ e N9

restraint: RESTRAINT ARG=dis AT=$ref KAPPA=$kappa

PRINT ARG=dis,restraint.bias STRIDE=500 FILE=COLVAR

ENDPLUMED" > u$i/umbrella.dat

done

