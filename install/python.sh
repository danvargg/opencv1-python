# Linux

# Install Python libraries

sudo apt -y update && sudo apt -y upgrade

sudo apt-get install python3-dev python3-pip python3-venv
sudo -H pip3 install -U pip numpy
sudo apt-get install libx11-dev libgtk-3-dev libboost-python-dev
sudo apt-get install python3-testresources
sudo apt-get install build-essential checkinstall cmake pkg-config yasm

cwd=$(pwd)
# create virtual environment
python3 -m venv opencv-course

echo "# Alias for activating the environment" >> ~/.bashrc
echo "alias workoncvcourse=\"source $cwd/opencv-course/bin/activate\"" >> ~/.bashrc
source ~/.bashrc
source "$cwd"/opencv-course/bin/activate

# now install python libraries within this virtual environment
pip3 install --upgrade pip
pip install --upgrade wheel numpy scipy matplotlib scikit-image scikit-learn ipython dlib

# quit virtual environment
deactivate

# Install OpenCV

# Activate virtual environment
workoncvcourse

# Install OpenCV and Dlib modules
pip install --upgrade opencv-contrib-python==4.1.0.25

# Check Installation
workoncvcourse
ipython
import cv2
print(cv2.__version__)
deactivate

# macOS

# Create Virtual Environment
python3 -m venv opencv-course
echo "# Alias for OpenCV Course Virtual Environment" >> ~/.bash_profile
echo "alias workoncvcourse=\"source $(pwd)/opencv-course/bin/activate\"" >> ~/.bash_profile
source $(pwd)/opencv-course/bin/activate

# now install python libraries within this virtual environment
pip install --upgrade wheel numpy scipy matplotlib scikit-image scikit-learn ipython jupyter

# quit virtual environment
deactivate

# Install OpenCV
source ~/.bash_profile

# Activate virtual environment
workoncvcourse

# Install OpenCV and Dlib modules
pip install --upgrade opencv-contrib-python==4.1.0.25

# Check Installation
workoncvcourse
ipython
import cv2
print(cv2.__version__)
deactivate
