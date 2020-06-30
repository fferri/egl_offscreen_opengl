FROM nvidia/cudagl:10.2-base-ubuntu18.04

ENV OPENCV_VERSION "4.2.0"
ENV DEBIAN_FRONTEND "noninteractive"
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
        git \
        vim \
        g++ \
        gcc \
        cmake \
        libopencv-dev \
        libopencv-imgproc-dev \
        libopencv-highgui-dev \
        libgl1-mesa-dev \
        libegl1-mesa-dev \
        libglew-dev \
        libwayland-dev \
        libxkbcommon-dev \
        wayland-protocols \
        wget \
        build-essential \
        cmake \
        qt5-default \
        libvtk6-dev \
        zlib1g-dev \
        libjpeg-dev \
        libwebp-dev \
        libpng-dev \
        libtiff5-dev \
        libopenexr-dev \
        libgdal-dev \
        libdc1394-22-dev \
        libavcodec-dev \
        libavformat-dev \
        libswscale-dev \
        libtheora-dev \
        libvorbis-dev \
        libxvidcore-dev \
        libx264-dev yasm \
        libopencore-amrnb-dev \
        libopencore-amrwb-dev \
        libv4l-dev \
        libxine2-dev \
        libtbb-dev \
        libeigen3-dev \
        python-dev  \
        python-tk  \
        pylint  \
        python-numpy  \
        python3-dev \
        python3-tk \
        pylint3 \
        python3-numpy \
        flake8 \
        ant \
        default-jdk \
        doxygen \
        unzip \
    && rm -rf /var/lib/apt/lists/*

# For the tzdata dependency
ENV TZ=Poland

# OpenCV because `libopencv` does not work
WORKDIR /root
RUN wget https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip \
    && unzip ${OPENCV_VERSION}.zip \
    && rm ${OPENCV_VERSION}.zip \
    && mv opencv-${OPENCV_VERSION} OpenCV \
    && cd OpenCV \
    && mkdir build \
    && cd build  \
    && cmake -DWITH_QT=ON -DWITH_OPENGL=ON -DFORCE_VTK=ON -DWITH_TBB=ON -DWITH_GDAL=ON -DWITH_XINE=ON -DENABLE_PRECOMPILED_HEADERS=OFF .. \
    && make -j8 \
    && make install \
    && ldconfig


# main
WORKDIR /usrc/src/egl
COPY . .
RUN make 


VOLUME /usr/src/egl/img

CMD make test_without_x11 && cp img.png img/
