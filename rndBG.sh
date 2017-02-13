#!/bin/bash

$PATH = "/home/adrian/Bilder/Wallpaper/"

ls $PATH |sort -R |tail -$N |while read file; do
    echo "$file"
done
