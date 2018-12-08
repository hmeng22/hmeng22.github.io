---
title: "Caffe"
date: 2017-07-21T18:00:55-04:00
draft: false
---

# Caffe

[Caffe](http://caffe.berkeleyvision.org/) is a Deep Learning framework by Berkeley Vision and Learning Center(BVLC) and by community contributors.
[Yangqing Jia](http://daggerfs.com/) created the project during his PhD at UC Berkeley. Caffe is released under the [BSD 2-Clause license](https://github.com/BVLC/caffe/blob/master/LICENSE).

# Introduction

You can go directly to [Installation](/) if you are already familiar with these stuff and just want to install Caffe.

Caffe offers some installation instructions at [here](http://caffe.berkeleyvision.org/installation.html). However, I cannot install it successfully just following this instructions.

# Prerequisites

Caffe has several dependencies : CUDA, BLAS, Boost and some libraries. Also some dependencies are optional : OpenCV, IO libraries, cuDNN.

## CUDA

[CUDA](https://en.wikipedia.org/wiki/CUDA) is a parallel computing platform and API model created by Nvidia. It allows developers to use CUDA-enabled GPU for processing. This is all I want to know.

It will not work if you install CUDA driver through CUDA Toolkit. You have to download and install the right CUDA driver from [here](http://www.nvidia.com/object/mac-driver-archive.html). I'm using CUDA 7.5.30 driver for MAC.

Library version 7+ are recommended. If you have a issue 'CUDA driver version is insufficient for CUDA runtime version'. That might be caused by the CUDA driver

## BLAS

Basic Linear Algebra Subprograms(BLAS) is a specification that prescribes a set of low-level routines for performing common linear algebra operations.

Three libraries are recommedned : ATLAS, MKL or OpenBLAS.

Caffe uses ATLAS as default. Intel Math kernel Library(MKL) is optimized for Intel. It is said MKL will be faster. OpenBLAS is an open source implementation with many hand-crafted optimizations for specific processor types.

I just use default ATLAS. Everthing is fine just leave this part alone there.

## Boost

[Boost](https://en.wikipedia.org/wiki/Boost_(C%2B%2B_libraries)#License) is a set of libraries for the C++ that provide support for tasks and structures. It contains over 80 individual libraries. Most of the Boost libraries are licensed under the Boost Software License, designed to allow Boost to be used with both free and proprietary software projects.

## Other libraries

protobuf, glog, gflags, hdf5

OpenCV, lmdb, leveldb, snappy

## cuDNN

cuDNN for GPU acceleration. The NVIDIA CUDA Deep Neural Network library (cuDNN) is a GPU-accelerated library of primitives for deep neural networks.

You can enable this in the Makefile.config, if the server has a GPU and cudnn installed.

## Anaconda

They suggested to use Anaconda Python distribution. Don't do that.

Usually Anaconda will be installed at ~/anaconda. It requires to use ~/anaconda/bin/python or ~/anaconda/bin/ipython to install related Python packages. You have to change the environment before doing that. Apparently it is much easier to use Homerbrew.

Thanks to [this](https://github.com/rainyear/lolita/issues/10).




# Caffe OS X installation

> Operating System : OS X EI Capitan Version 10.11.5
> Graphics : Intel Iris Pro Graphics 6200 1536 MB
> Processor : 3.1 GHz Intel Core i5

```sh
# Install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install XCode
# Install XCode command line tools
xcode-select --install


# Only do this part if you need to use GPU
# Install CUDA toolkit 7.5
# Install CUDA driver
# Only do this part after CUDA if you need to use cuDNN
# download cudnn-x.x-osx-x64.tar
sudo tar -xzvf cudnn-x.x-osx-x64.tar /Developer/NVIDIA/CUDA-7.5/
sudo ln -s /Developer/NVIDIA/CUDA-8.0/lib/libcudnn.dylib /usr/local/cuda/lib/libcudnn.dylib
sudo ln -s /Developer/NVIDIA/CUDA-8.0/lib/libcudnn.5.dylib /usr/local/cuda/lib/libcudnn.5.dylib
sudo ln -s /Developer/NVIDIA/CUDA-8.0/lib/libcudnn_static.a /usr/local/cuda/lib/libcudnn_static.a
sudo ln -s /Developer/NVIDIA/CUDA-8.0/include/cudnn.h /usr/local/cuda/include/cudnn.h
# Not sure about this part. This is from https://gist.github.com/doctorpangloss/f8463bddce2a91b949639522ea1dcbe4 . And you can find this link in  https://github.com/BVLC/caffe/wiki/Installation-(OSX)



# Install dependencies using brew
brew install -vd snappy leveldb gflags glog szip lmdb
# need the homebrew science source for OpenCV and hdf5
brew tap homebrew/science
brew install hdf5 opencv
brew upgrade libpng

# with Python pycaffe needs dependencies built from source
brew install --build-from-source --with-python -vd protobuf
brew install --build-from-source -vd boost boost-python

# using brew python & numpy
brew install python numpy



# Clone the caffe repo
cd ~/Documents
git clone https://github.com/BVLC/caffe.git

cp Makefile.config.example Makefile.config
# config Makefile.config based on your needs
CPU_ONLY := 1

# the brew numpy path
PYTHON_INCLUDE := /usr/include/python2.7 \
  /usr/local/Cellar/numpy/1.11.1/lib/python2.7/site-packages/numpy/core/include

# the brew python path
PYTHON_LIB := /usr/local/Cellar/python/2.7.12/Frameworks/Python.framework/Versions/2.7/lib



# make
make -j8 all
make -j8 test
make runtest



# make pycaffe
for req in $(cat python/requirements.txt); do pip install $req; done

make -j8 pytest
make pycaffe
make distribute



# add PYTHONPATH into .bash_profile
echo "export PYTHONPATH=/path to your caffe/python:$PYTHONPATH" >> ~/.bash_profile
source ~/.bash_profile

# Verify that everything works
python -c 'import caffe'
python -c "import caffe;print caffe.__version__"
```


# Caffe Test

[StackOverFlow](http://stackoverflow.com/questions/29658790/how-to-test-mnist-on-my-own-dataset-images)
```
import os
import sys

import caffe

model_file = './lenet.prototxt'
pretrained_file = './lenet_iter_10000.caffemodel'
net = caffe.Classifier(model_file, pretrained_file, image_dims=(28, 28), raw_scale=255)
score = net.predict([caffe.io.load_image('./7.png', color=False)], oversample=False)
print score
```





# Some useful posts

1. [Deepdream(Caffe-python)](https://github.com/rainyear/lolita/issues/10)











# Problems

## Using different python

```
# check which python you are using
$ which python
$ which pip
# Normally brew will use /usr/local/bin/ . built-in is /usr/bin

# check /etc/paths
$ cat /etc/paths
/usr/local/bin  
/usr/bin
/bin
/usr/sbin
/sbin
```

## numpy not found

```
import numpy as np
np.get_include()

# replace the numpy path
PYTHON_INCLUDE := /usr/include/python2.7 \
		/usr/local/Cellar/numpy/1.11.1/lib/python2.7/site-packages/numpy/core/include

THe Homebrew numpy is recommended.
```

## Reason: image not found

```
Referenced from: /Users/.../Code/caffe_FCN/python/caffe/_caffe.so

Reason: image not found
```

* Solution
```
$ echo "export PYTHONPATH=/your path to caffe/python:$PYTHONPATH" >> ~/.bash_profile
$ source ~/.bash_profile
```

## Library Path

```
echo "export PATH=/usr/local/cuda/bin:$PATH" >> ~/.bash_profile
echo "export DYLD_LIBRARY_PATH=/usr/local/cuda/lib:$DYLD_LIBRARY_PATH" >> ~/.bash_profile
echo "export DYLD_FALLBACK_LIBRARY_PATH=/usr/local/cuda/lib:/usr/local/lib:/usr/lib:$DYLD_FALLBACK_LIBRARY_PATH" >> ~/.bash_profile
```
