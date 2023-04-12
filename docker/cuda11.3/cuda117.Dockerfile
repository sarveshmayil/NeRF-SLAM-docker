ARG BASE_IMG=nvidia/cuda:11.7.0-cudnn8-devel-ubuntu20.04

FROM ${BASE_IMG}

# Prevent anything requiring user input
ENV DEBIAN_FRONTEND=noninteractive
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
ENV TERM=linux

ENV CUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda-11.7

RUN apt-get -y update \
    && apt-get -y install \
      python3-pip \
      sudo \
      vim \
      wget \
      curl \
      software-properties-common \
      doxygen \
      git \
    && rm -rf /var/lib/apt/lists/*

# Install PyTorch for CUDA 11.7
RUN pip install torch==1.13.1+cu117 torchvision==0.14.1+cu117 --extra-index-url https://download.pytorch.org/whl/cu117
