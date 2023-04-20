# nerf-slam
NeRF-SLAM for DeepRob Final Project

## Instructions to Build Docker Image

Before building the specific images for NeRF-SLAM, you will need to pull the official Nvidia base image
```
docker pull nvidia/cuda:11.7.0-cudnn8-devel-ubuntu20.04
```

Then, go into `cuda` directory and build the base cuda-ubuntu 20.04 image. This can be done by running

```
cd docker/cuda
./build.sh
```

Then, go back to the `docker` directory and build the nerf-slam image by running
```
./build.sh
```

And the image can be run as a container by running
```
./run.sh
```

You may need to make the scripts executable by running `chmod +x build.sh`.
