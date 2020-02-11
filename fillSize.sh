#! /bin/bash
START=`date +%s%N`;
for folder in `ls | grep "H*tiles"`;do
	echo $folder
	for image in `ls $folder`;do
		echo $image
		ratio=`identify "${folder}/${image}" | cut -d " " -f 3`
		if [ "$ratio" != "128x128" ];then
			echo $ratio
			convert "${folder}/${image}" -background transparent -gravity NorthWest -extent 512x512 "${folder}/${image}"
		fi 
	done
done
END=`date +%s%N`;
time=$((END-START))
time=`expr $time / 1000000`
echo "totally spend time ${time}"