FROM python:3.4
MAINTAINER Anubhav Agarwal <agarwal.anubhav@iitrpr.ac.in>

RUN apt-get update -y && apt-get upgrade -y

RUN apt-get install -y build-essential \
cmake \
git \
pkg-config \
libjpeg62-turbo-dev \
libtiff5-dev \
libjasper-dev \
libpng12-dev \
libavcodec-dev \
libavformat-dev \
libswscale-dev \
libv4l-dev \
libgtk2.0-dev \
libatlas-base-dev \
gfortran \
vim

RUN wget https://bootstrap.pypa.io/get-pip.py

RUN python3 get-pip.py

RUN apt-get install python3-dev -y

RUN pip install numpy


RUN git clone https://github.com/Itseez/opencv.git
WORKDIR opencv
RUN git checkout 3.0.0

RUN git clone https://github.com/Itseez/opencv_contrib.git
WORKDIR opencv_contrib
RUN git checkout 3.0.0

WORKDIR /opencv
RUN mkdir build
WORKDIR build

RUN cmake -D CMAKE_BUILD_TYPE=RELEASE \
  -D CMAKE_INSTALL_PREFIX=/usr/local \
  -D INSTALL_C_EXAMPLES=ON \
  -D INSTALL_PYTHON_EXAMPLES=ON \
  -D OPENCV_EXTRA_MODULES_PATH=/opencv_contrib/modules \
  -D BUILD_EXAMPLES=ON ..


RUN make -j4

RUN make install
RUN ldconfig

RUN pip install matplotlib ipython scipy sklearn scikit-image

WORKDIR /
RUN rm -rf opencv
RUN rm get-pip.py
