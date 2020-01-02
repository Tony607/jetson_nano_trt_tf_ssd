# [How to run SSD Mobilenet V2 object detection on Jetson Nano at 20+ FPS ](https://www.dlology.com/blog/how-to-run-ssd-mobilenet-v2-object-detection-on-jetson-nano-at-20-fps/)| DLology
First, make sure you have flashed the latest JetPack 4.3 on your Jetson Nano development SD card.

# Run the docker
```shell
docker run --runtime nvidia --network host --privileged -it docker.io/zcw607/trt_ssd_r32.3.1:0.1.0
```
## Then run this command to benchmark the inference speed.
```
python3 trt_ssd_benchmark.py
```
# To build the docker yourself
To build the docker on Jetson nano or any other arm64 board.
```bash
docker build -t docker.io/<your user name>/trt_ssd_r32.3.1:0.1.0 . -f ./Dockerfile
docker push docker.io/<your user name>/trt_ssd_r32.3.1:0.1.0
```
To build the docker on a x86 machine, requires podman and qemu installed.
```bash
podman build -v /usr/bin/qemu-aarch64-static:/usr/bin/qemu-aarch64-static -t docker.io/<your user name>/trt_ssd_r32.3.1:0.1.0 . -f ./Dockerfile
podman push docker.io/<your user name>/trt_ssd_r32.3.1:0.1.0
```