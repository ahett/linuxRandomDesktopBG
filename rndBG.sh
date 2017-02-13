#!/bin/bash

WPPTH="/home/adrian/Bilder/Wallpaper/"

#get number of wallpapers in folder
MAX=$(ls $WPPTH -F |grep -v / | wc -l)
echo "MAX: $MAX"

#generate four ramndom numbers
RNG1=$(shuf -i 1-$MAX -n 1)
RNG2=$(shuf -i 1-$MAX -n 1)
RNG3=$(shuf -i 1-$MAX -n 1)
RNG4=$(shuf -i 1-$MAX -n 1)

FILE1=""
FILE2=""
FILE3=""
FILE4=""

echo "$RNG1, $RNG2, $RNG3, $RNG4"
echo ""
i=1

# iterate all files in wallpaper path
for file in $WPPTH*
do
    if [ $i -eq $RNG1 ]
    then
      FILE1=$file
    fi
    if [ $i -eq $RNG2 ]
    then
      FILE2=$file
    fi
    if [ $i -eq $RNG3 ]
    then
      FILE3=$file
    fi
    if [ $i -eq $RNG4 ]
    then
      FILE4=$file
    fi
    ((i++))
done
rm -f pics/*.*

convert $FILE1 -resize 2560x1440! -quality 100 "pics/1.jpg"
convert $FILE2 -resize 2560x1440! -quality 100 "pics/2.jpg"
convert $FILE3 -resize 2560x1440! -quality 100 "pics/3.jpg"
convert $FILE4 -resize 2560x1440! -quality 100 "pics/4.jpg"
convert "pics/4.jpg" -crop 1920x1200+0+0 "pics/4.jpg"
convert "pics/1.jpg" "pics/2.jpg" "pics/3.jpg" "pics/4.jpg" +append "pics/all.jpg"
echo "1: $FILE1, 2: $FILE2, 3: $FILE3, 4: $FILE4"
