FROM python:3.8-slim-buster

COPY . ./ocr_api_server
RUN python3 -m pip install --upgrade pip -i https://pypi.tuna.tsinghua.edu.cn/simple/
RUN pip3 install -r ./ocr_api_server/requirements.txt -i  https://pypi.tuna.tsinghua.edu.cn/simple/
RUN rm -rf /tmp/* && rm -rf /root/.cache/* 
RUN sed -i "s@http://\(deb\|security\).debian.org@https://mirrors.huaweicloud.com@g" /etc/apt/sources.list
RUN apt update 
RUN apt-get --allow-releaseinfo-change update && apt install libgl1-mesa-glx libglib2.0-0 -y

WORKDIR /ocr_api_server

CMD ["python3", "ocr_server.py", "--port", "9898", "--ocr", "--det"]
