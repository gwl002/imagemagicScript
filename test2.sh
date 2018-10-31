#! /bin/bash

convert logo.gif -crop 250x250 tiles/%3d.png

for image in `ls tiles`;do
	echo $image
	ratio=`identify "tiles/$image" | cut -d " " -f 3`
	echo $ratio
	if [ "$ratio" != "250x250" ];then
		convert "tiles/$image" -background transparent -gravity NorthWest -extent 250x250 "tiles/$image"
	fi 
done