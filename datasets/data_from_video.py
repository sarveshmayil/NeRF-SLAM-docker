import cv2
import json

VIDEO_FILE = 'video.mp4'
PARENT_DIR = 'Data/' 
#You need to make the PARENT_DIR/results directory!!!!

video = cv2.VideoCapture(VIDEO_FILE)
fps = video.get(cv2.CAP_PROP_FPS)
print('frames per second =',fps)


dictionary = {
  "fl_x": 600.0,
  "fl_y": 600.0,
  "k1": 0,
  "k2": 0,
  "p1": 0,
  "p2": 0,
  "cx": 599.5,
  "cy": 339.5,
  "w": 1200,
  "h": 680,
  "aabb": [
    [
      -4,
      -4,
      -4
    ],
    [
      4,
      4,
      4
    ]
  ],
  "aabb_scale": 4,
  "integer_depth_scale": 1.0,
  "frames": []
}




c = 0
while True:
    success,img = video.read()
    if not success:
        break

    w, h, ch = img.shape
    img2 = cv2.resize(img, (h//3, w//3))

    name = 'results/frame' + str(c).zfill(6) + ".jpg"

    d = {
        "file_path": name,
        "transform_matrix": [
          [1, 0, 0, 0],
          [0, 1, 0, 0],
          [0, 0, 1, 0],
          [0, 0, 0, 1]

        ]
    }
    dictionary['frames'].append(d)

    cv2.imwrite(name, img2)
    c += 1

with open("transforms.json", "w") as outfile:
    json.dump(dictionary, outfile, indent=4)
