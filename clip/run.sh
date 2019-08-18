#!/bin/sh
echo "DIR="$DIR
echo "BDUSS="$BDUSS
echo "FILE="$FILE
echo "START_OFFEST="$START_OFFEST
echo "END_OFFEST="$END_OFFEST
echo "BAIDU_UID_USERNAME="$BAIDU_UID_USERNAME
LOCALDIR=/$BAIDU_UID_USERNAME$DIR
echo "LOCALDIR="$LOCALDIR

# 设置运行路径
EXEC=./baidupcs/BaiduPCS-Go

# 以下两个变量用于检查带空格的文件
DLFILE=`echo $FILE |awk -F\  '{print $1}'`*
OPFILE=`echo $FILE |awk -F\  '{print $1}'`

# 登陆 创建文件 设置下载目录
$EXEC login -bduss=$BDUSS
$EXEC mkdir $DIR/dist/
$EXEC config set -savedir /

# 下载目的文件到本地 并更改用于渲染的名称 创建新目录
$EXEC d $DIR$DLFILE
mv $LOCALDIR$DLFILE $LOCALDIR$OPFILE 
mkdir ./dist/

# 获取短片长度
ORIENDTIME=`ffprobe -v 0 -show_entries format=duration -of compact=p=0:nk=1 $LOCALDIR$OPFILE`
# 片子长度-末端减去=最终的位移长度
NEWENDTIME=`echo $ORIENDTIME-$END_OFFEST|bc`

# 非重编码裁切
ffmpeg -i $LOCALDIR$OPFILE -ss $START_OFFEST -to $NEWENDTIME  -acodec copy -vcodec copy ./dist/$OPFILE.mp4
echo "==================ffmpeg finished ==================="

# 上传
$EXEC u dist/$OPFILE.mp4 $DIR/dist/ --retry 20 -p 2
