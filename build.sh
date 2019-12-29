podman build -v /usr/bin/qemu-aarch64-static:/usr/bin/qemu-aarch64-static -t docker.io/zcw607/trt_ssd_r32.3.1:0.1.0 . -f ./Dockerfile
podman push docker.io/zcw607/trt_ssd_r32.3.1:0.1.0