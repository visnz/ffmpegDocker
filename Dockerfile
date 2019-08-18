FROM ubuntu
RUN apt-get update \
    && apt-get install -y unzip wget ffmpeg bc \
    && wget https://github.com/iikira/BaiduPCS-Go/releases/download/v3.5.6/BaiduPCS-Go-v3.5.6-linux-amd64.zip \
    && unzip BaiduPCS-Go-v3.5.6-linux-amd64.zip \
    && mv BaiduPCS-Go-v3.5.6-linux-amd64 baidupcs \
    && chmod +x ./baidupcs/BaiduPCS-Go 