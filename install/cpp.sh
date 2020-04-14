# Ubuntu 16.04

# Update Packages
# Create directory for installation
mkdir installation
mkdir installation/OpenCV

# Save current working directory
OpenCV_Home_DIR=$(pwd)
sudo apt -y update && sudo apt -y upgrade

# Install OS libraries
sudo apt -y remove x264 libx264-dev

## Install dependencies
sudo apt -y install build-essential checkinstall cmake pkg-config yasm
sudo apt -y install git gfortran
sudo apt -y install libjpeg8-dev libjasper-dev libpng12-dev

sudo apt -y install libtiff5-dev

sudo apt -y install libtiff-dev

sudo apt -y install libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev
sudo apt -y install libxine2-dev libv4l-dev
cd /usr/include/linux
sudo ln -s -f ../libv4l1-videodev.h videodev.h
cd "$OpenCV_Home_DIR"

sudo apt -y install libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev
sudo apt -y install libgtk2.0-dev libtbb-dev qt5-default
sudo apt -y install libatlas-base-dev
sudo apt -y install libfaac-dev libmp3lame-dev libtheora-dev
sudo apt -y install libvorbis-dev libxvidcore-dev
sudo apt -y install libopencore-amrnb-dev libopencore-amrwb-dev
sudo apt -y install libavresample-dev
sudo apt -y install x264 v4l-utils

# Optional dependencies
sudo apt -y install libprotobuf-dev protobuf-compiler
sudo apt -y install libgoogle-glog-dev libgflags-dev
sudo apt -y install libgphoto2-dev libeigen3-dev libhdf5-dev doxygen

# Download opencv and opencv_contrib
git clone https://github.com/opencv/opencv.git
cd opencv
git checkout tags/4.1.0
cd ..

git clone https://github.com/opencv/opencv_contrib.git
cd opencv_contrib
git checkout tags/4.1.0
cd ..

# Compile and install OpenCV with contrib modules
cd opencv
mkdir build
cd build

cmake -D CMAKE_BUILD_TYPE=RELEASE \
      -D CMAKE_INSTALL_PREFIX=$OpenCV_Home_DIR/installation/OpenCV \
      -D INSTALL_C_EXAMPLES=ON \
      -D WITH_TBB=ON \
      -D WITH_V4L=ON \
      -D WITH_OPENGL=ON \
      -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
      -D BUILD_EXAMPLES=ON ..
make -j4
make install


# Ubuntu 18.04

# Update Packages
# Create directory for installation
mkdir installation
mkdir installation/OpenCV

# Save current working directory
OpenCV_Home_DIR=$(pwd)
sudo apt -y update && sudo apt -y upgrade

# Install OS libraries
sudo apt -y remove x264 libx264-dev

## Install dependencies
sudo apt -y install build-essential checkinstall cmake pkg-config yasm
sudo apt -y install git gfortran
sudo apt -y install libjpeg8-dev libpng-dev

sudo apt -y install software-properties-common
sudo add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main"
sudo apt -y update

sudo apt -y install libjasper1
sudo apt -y install libtiff5-dev

sudo apt -y install libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev
sudo apt -y install libxine2-dev libv4l-dev
cd /usr/include/linux
sudo ln -s -f ../libv4l1-videodev.h videodev.h
cd "$OpenCV_Home_DIR"

sudo apt -y install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev
sudo apt -y install libgtk2.0-dev libtbb-dev qt5-default
sudo apt -y install libatlas-base-dev
sudo apt -y install libfaac-dev libmp3lame-dev libtheora-dev
sudo apt -y install libvorbis-dev libxvidcore-dev
sudo apt -y install libopencore-amrnb-dev libopencore-amrwb-dev
sudo apt -y install libavresample-dev
sudo apt -y install x264 v4l-utils

# Optional dependencies
sudo apt -y install libprotobuf-dev protobuf-compiler
sudo apt -y install libgoogle-glog-dev libgflags-dev
sudo apt -y install libgphoto2-dev libeigen3-dev libhdf5-dev doxygen

# Download opencv and opencv_contrib
git clone https://github.com/opencv/opencv.git
cd opencv
git checkout tags/4.1.0
cd ..

git clone https://github.com/opencv/opencv_contrib.git
cd opencv_contrib
git checkout tags/4.1.0
cd ..

# Compile and install OpenCV with contrib modules
cd opencv
mkdir build
cd build

cmake -D CMAKE_BUILD_TYPE=RELEASE \
      -D CMAKE_INSTALL_PREFIX=$OpenCV_Home_DIR/installation/OpenCV \
      -D INSTALL_C_EXAMPLES=ON \
      -D WITH_TBB=ON \
      -D WITH_V4L=ON \
      -D WITH_OPENGL=ON \
      -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
      -D BUILD_EXAMPLES=ON ..
make -j4
make install

# macOS

# Install XCode
# 1. If XCode available on the App Store is not compatible with your OS:
# 2. Find XCode version compatible with your OS from this table.
# 3. Go to this webpage: https://developer.apple.com/download/more/
# 4. Login if you have apple developer account. Else, create your account and login
# 5. Search for Xcode and download the version compatible with your OS.
# 6. Install XCode.
# 7. After installation open XCode, and accept xcode-build license when prompted.

brew install cmake
brew install qt5
qtfolder=$(ls /usr/local/Cellar/qt/)
QT5PATH=/usr/local/Cellar/qt/"$qtfolder"

# Download and Install OpenCV 4.1.0
# Create directory for installation
mkdir installation
mkdir installation/OpenCV

# Save current working directory
OpenCV_Home_DIR=$(pwd)

git clone https://github.com/opencv/opencv.git
cd opencv
git checkout tags/4.1.0
cd ..

git clone https://github.com/opencv/opencv_contrib.git
cd opencv_contrib
git checkout tags/4.1.0
cd ..

# Create a build directory
cd opencv
mkdir build
cd build

cmake -D CMAKE_BUILD_TYPE=RELEASE \
      -D CMAKE_INSTALL_PREFIX=$OpenCV_Home_DIR/installation/OpenCV \
      -D INSTALL_C_EXAMPLES=ON \
      -D WITH_TBB=ON \
      -D WITH_V4L=ON \
      -D CMAKE_PREFIX_PATH=$QT5PATH \
      -D CMAKE_MODULE_PATH="$QT5PATH"/lib/cmake \
      -D WITH_QT=ON \
      -D WITH_OPENGL=ON \
      -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
      -D BUILD_EXAMPLES=ON ..
make -j$(sysctl -n hw.physicalcpu)
make install

cd $cwd
