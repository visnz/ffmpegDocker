# ffmpegDocker

包含了来自客户提出的一些云端使用ffmpeg渲染视频的解决方案，使用Docker封装。

场景描述：经常遇到客户要求传视频过来，进行简单的处理。通常会遇到使用百度云交付（）。出于一些原因（网络传输状况不佳/操作繁琐等），使用云服务来执行。例如：

1. 客户要求把n段视频切头去尾（不同长度），通过百度云交付，传统做法先下载/切割/上传，使用此方法将直接在云端完成切割并交付。

## Dockerfile

在dockerfile里基于ubuntu镜像封装了一个[baidupcs-go](https://github.com/iikira/BaiduPCS-Go)以及一些基础工具，并通过二阶封装一个``/run.sh``作为通用脚本执行记录。在基础镜像之上,主要使用``run.sh``完成业务逻辑。



## 开始使用

已经打包好的基础Docker在[dockerhub](https://cloud.docker.com/u/visnz/repository/docker/visnz/ffmpeg-docker)

1. 在服务器上安装Docker/DockerCompose、pull镜像``docker pull visnz/ffmpegDocker``（可选，build的时候会检查并拉取的）
2. 在本地``git clone https://github.com/visnz/ffmpegDocker.git``
3. 根据需求在不同的子目录里构建单独的镜像``docker build . -t [ffmpeg-balabala]``tag自选。
4. 修改example文件``docker-compose.yml``，在相同目录中，使用``docker-compose up``（``-d``可挂在后台）
5. 一个docker-compose文件可以撰写多个任务，交由服务器执行。

### 前后切除

1. 前后片段检查
   1. 在``cliptest``目录中构建：``docker build . -t ffmpeg-clip-test``(此tag名需要与docker-compose.yml文件中的image相同)
   2. 执行``docker-compose up``，会自动裁切指定文件的前后30秒并发送到百度云的输出位置（默认为``$DIR/dist/``）。
   3. 检查并确认好前后位置，在cliptest中填写参数进行裁切。
2. 裁切
   1. 将一系列任务写在``clip``目录下，批量添加即可，在自动选择并裁切后，将会回传到百度云。

## 其他

[关于百度USS](https://github.com/iikira/BaiduPCS-Go/wiki/%E5%85%B3%E4%BA%8E-%E8%8E%B7%E5%8F%96%E7%99%BE%E5%BA%A6-BDUSS)