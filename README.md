###步骤：

1. 安装 imagemagic 软件，把imagemagic 路径添加到path环境变量
2. 把要切的源文件放到 orignalimages文件夹内
3. 执行 ./cropFile.sh && ./fillSize.sh





### cropFile.sh 解释
把图片切成 指定 level数（这里是7）的tiles图片

### fillSize.sh 解释
有些图片切完会小于 512 * 512，需要把图片放在 512 * 512 透明背景的左上角



