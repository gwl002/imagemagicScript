#! /bin/bash
INDEX=1
# IMAGE_WIDTH=10752
# IMAGE_HEIGHT=21504
IMAGE_WIDTH=1898
IMAGE_HEIGHT=1064
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
	for (( i=1; i<=3; i++));do
		echo "processing ${file} scale ${i}"
		((level= 4 - i))
		((scale= 2 ** (i-1)))
		((width= $IMAGE_WIDTH / $scale))
		((height= $IMAGE_HEIGHT / $scale))
		resizeFormat="${width}x${height}"
		echo $resizeFormat
		convert "originImages/${file}" -resize $resizeFormat -crop 256x256 -set filename:tile ./${tiles_dir}/${level}-%[fx:page.x/256]-%[fx:page.y/256] %[filename:tile].png
		echo "complete ${file} scale ${i}"
	done
	echo "complete ${file}"
	let INDEX=${INDEX}+1
done