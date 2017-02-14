#!/bin/bash

# set PATHs
WPPTH="/home/adrian/Bilder/Wallpaper"
FINAL="/home/adrian/Bilder/Wallpaper/__00final/__00final.jpg"

#get number of wallpapers in folder
MAX=$(ls $WPPTH -F |grep -v / | wc -l)

#generate four ramndom numbers
RNG1=$(shuf -i 1-$MAX -n 1)
RNG2=$(shuf -i 1-$MAX -n 1)
RNG3=$(shuf -i 1-$MAX -n 1)
RNG4=$(shuf -i 1-$MAX -n 1)

FILE1=""
FILE2=""
FILE3=""
FILE4=""

#echo "$RNG1, $RNG2, $RNG3, $RNG4"

i=0

# iterate all files in wallpaper path
for file in $WPPTH/*
do
#  echo "$file"
  if [ $i -gt 0 ]       # skip __00final.jpg
  then
    if [ $i -eq $RNG1 ] # first file
    then
      FILE1=$file
    fi
    if [ $i -eq $RNG2 ] # second
    then
      FILE2=$file
    fi
    if [ $i -eq $RNG3 ] # third
    then
      FILE3=$file
    fi
    if [ $i -eq $RNG4 ] #fourth
    then
      FILE4=$file
    fi
  fi
  ((i++)) # increment
done

echo "$FILE1, $FILE2, $FILE3, $FILE4"

if [ ${#FILE1} -lt 1 ]
then
  echo "fallback for file1. RNG1: ${#FILE1}"
  FILE1="$WPPTH/fallback.jpg"
fi
if [ ${#FILE2} -lt 1 ]
then
  echo "fallback for file2. RNG2: ${#FILE2}"
  FILE2="$WPPTH/fallback.jpg"
fi
if [ ${#FILE3} -lt 1 ]
then
  echo "fallback for file3. RNG3: ${#FILE3}"
  FILE3="$WPPTH/fallback.jpg"
fi
if [ ${#FILE4} -lt 1 ]
 then
  echo "fallback for file4. RNG4: ${#FILE4}"
  FILE4="$WPPTH/fallback.jpg"
fi

#make sure the siyes are right
convert $FILE1 -resize 2560x1440! -quality 100 "$WPPTH/__00final/__01.jpg"
convert $FILE2 -resize 2560x1440! -quality 100 "$WPPTH/__00final/__02.jpg"
convert $FILE3 -resize 2560x1440! -quality 100 "$WPPTH/__00final/__03.jpg"
convert $FILE4 -resize 2134x1200! -quality 100 "$WPPTH/__00final/__04.jpg"

#crop for the smaller monitor
convert "$WPPTH/__00final/__04.jpg" -crop 1920x1200+107+0 "$WPPTH/__00final/__04.jpg"

# compose full image
convert "$WPPTH/__00final/__01.jpg" "$WPPTH/__00final/__02.jpg" "$WPPTH/__00final/__03.jpg" "$WPPTH/__00final/__04.jpg" +append "$FINAL"

# set wallpaper
gsettings set org.gnome.desktop.background picture-uri file://"$FINAL"
