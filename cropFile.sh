#! /bin/bash
INDEX=1
IMAGE_WIDTH=10752
IMAGE_HEIGHT=21504

for file in `ls "originImages"`;do
	echo "processing ${file}"
	file_base=$(basename $file .png)
	tiles_dir="${file_base}_tiles"
	if [ -e "${tiles_dir}" ] && [ -d "${tiles_dir}" ];then
		echo "${tiles_dir} exisit"
	else
		echo "mkdir ${tiles_dir}"
		mkdir "${tiles_dir}"
		echo "mkdir ${tiles_dir} completed"
	fi
	for (( i=1; i<=7; i++));do
		echo "processing ${file} scale ${i}"
		((level= 7 - i))
		((scale= 2 ** (i-1)))
		((width= $IMAGE_WIDTH / $scale))
		((height= $IMAGE_HEIGHT / $scale))
		resizeFormat="${width}x${height}"
		echo $resizeFormat
		convert "originImages/${file}" -resize $resizeFormat -crop 512x512 -set filename:tile ./${tiles_dir}/${level}-%[fx:page.x/512]-%[fx:page.y/512] %[filename:tile].png
		echo "complete ${file} scale ${i}"
	done
	echo "complete ${file}"
	let INDEX=${INDEX}+1
done