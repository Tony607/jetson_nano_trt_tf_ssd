import sys
import time

import cv2
import pycuda.autoinit  # This is needed for initializing CUDA driver

from utils.ssd_classes import get_cls_dict
from utils.ssd import TrtSSD
from utils.visualization import BBoxVisualization
from utils.display import open_window, set_display, show_fps
import time
import numpy as np

model = "ssd_mobilenet_v2_coco"
filename = "./dogs.jpg"
conf_th = 0.3
INPUT_HW = (300, 300)
cls_dict = get_cls_dict("coco")
vis = BBoxVisualization(cls_dict)
img = cv2.imread(filename)
img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
trt_ssd = TrtSSD(model, INPUT_HW)
# Kick start the model.
for _ in range(20):
    boxes, confs, clss = trt_ssd.detect(img, conf_th)
print([get_cls_dict("coco")[c] for c in clss])
img = vis.draw_bboxes(img, boxes, confs, clss)
cv2.imwrite("result.jpg", img[..., ::-1])

times = []
for _ in range(20):
    start_time = time.time()
    boxes, confs, clss = trt_ssd.detect(img, conf_th)
    delta = time.time() - start_time
    times.append(delta)
mean_delta = np.array(times).mean()
fps = 1 / mean_delta
print("Average(sec):{:.4f},fps:{:.2f}".format(mean_delta, fps))
