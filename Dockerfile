FROM nvcr.io/nvidia/l4t-base:r32.3.1
WORKDIR /home
ENV TZ=Asia/Hong_Kong

COPY packages/jetpack4.3/pycuda-2019.1.2-cp36-cp36m-linux_aarch64.whl ./
COPY packages/jetpack4.3/tensorrt.tar.gz ./
COPY utils* ./utils/
COPY packages/jetpack4.3/TRT_ssd_mobilenet_v2_coco.bin ./ssd/
COPY  *.py ./
COPY packages/jetpack4.3/libflattenconcat.so ./ssd/
COPY *.jpg ./

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update && apt install -y --fix-missing python3-pip python3-opencv
# ENV PYPI_MIRROR "https://pypi.douban.com/simple"
# RUN pip config set global.index-url ${PYPI_MIRROR}
RUN pip3 install pycuda-2019.1.2-cp36-cp36m-linux_aarch64.whl \
&& rm pycuda-2019.1.2-cp36-cp36m-linux_aarch64.whl
RUN tar -xzf tensorrt.tar.gz -C /usr/local/lib/python3.6/dist-packages/ \
&& rm tensorrt.tar.gz

# Install pycuda dependencies.
RUN apt-get update && apt install -y libboost-python-dev libboost-thread-dev
CMD [ "bash" ]
