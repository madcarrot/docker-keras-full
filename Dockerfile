# docker-keras-full - Deep learning environment with *Keras* and *Jupyter* using CPU or GPU

FROM gw000/keras:2.1.4-gpu
MAINTAINER gw0 [http://gw.tnode.com/] <gw.2018@ena.one>

# install py3-tf-cpu/gpu (Python 3, TensorFlow, CPU/GPU)
RUN apt-get update -qq \
 && apt-get install --no-install-recommends -y \
    # install python 3
    python3 \
    python3-dev \
    python3-pip \
    python3-setuptools \
    python3-virtualenv \
    python3-wheel \
    pkg-config \
    # requirements for numpy
    libopenblas-base \
    python3-numpy \
    python3-scipy \
    # requirements for keras
    python3-h5py \
    python3-yaml \
    python3-pydot \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# manually update numpy
RUN pip3 --no-cache-dir install -U numpy==1.14.5

ARG TENSORFLOW_VERSION=1.8.0
ARG TENSORFLOW_DEVICE=gpu
ARG TENSORFLOW_APPEND=_gpu
RUN pip3 --no-cache-dir install https://storage.googleapis.com/tensorflow/linux/${TENSORFLOW_DEVICE}/tensorflow${TENSORFLOW_APPEND}-${TENSORFLOW_VERSION}-cp35-cp35m-linux_x86_64.whl

# install Keras for Python 3
ARG KERAS_VERSION=2.2.0
ENV KERAS_BACKEND=tensorflow
RUN pip3 --no-cache-dir install git+https://github.com/fchollet/keras.git


# install additional debian packages
RUN apt-get update -qq \
 && apt-get install --no-install-recommends -y \
    # system tools
    less \
    procps \
    vim-tiny \
    # build dependencies
    build-essential \
    libffi-dev \
    # visualization (Python 3)
    python3-matplotlib \
    python3-pillow \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# install additional python packages
 && pip3 --no-cache-dir install \
    # data analysis (Python 3)
    pandas \
    scikit-learn \
    statsmodels \
