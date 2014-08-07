# Install XQuartz from: https://xquartz.macosforge.org

# Homebrew (as necessary)
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
echo export PATH='/usr/local/bin:$PATH' >> ~/.bash_profile
source .bash_profile
brew doctor
brew update

# Brewed Python
brew install python
mkdir -p ~/Library/Python/2.7/lib/python/site-packages
echo "$(brew --prefix)/lib/python2.7/site-packages" >> ~/Library/Python/2.7/lib/python/site-packages/homebrew.pth

# Homebrew taps for specific formulae
brew tap ros/deps
brew tap osrf/simulation
brew tap homebrew/versions
brew tap homebrew/science

# Prerequisites
brew install cmake libyaml lz4
brew install boost --with-python
brew install opencv --with-qt --with-eigen --with-tbb
brew install ogre  # --head  # Ogre 1.9 for indigo's rviz, but we're using hydro's rviz pending some bugfixes

# Install Pillow (Pending: https://github.com/ros/rosdistro/issues/5220)
pip install pillow

# ROS build infrastructure tools
pip install -U setuptools rosdep rosinstall_generator wstool rosinstall catkin_tools catkin_pkg bloom
sudo rosdep init
rosdep update

# ROS Indigo Source Install
sudo mkdir -p /opt/ros/indigo
sudo chown $USER /opt/ros/indigo
mkdir indigo_desktop_ws && cd indigo_desktop_ws
rosinstall_generator desktop --rosdistro indigo --deps --tar > indigo.rosinstall
rosinstall_generator rviz --rosdistro hydro --tar >> indigo.rosinstall  # Version of rviz from Hydro
wstool init -j8 src indigo.rosinstall
rosdep install --from-paths src --ignore-src --rosdistro indigo -y --skip-keys=python-imaging

# Parallel build
catkin build --install -DCMAKE_BUILD_TYPE=Release --install-space /opt/ros/indigo \
  -DPYTHON_LIBRARY=/usr/local/Cellar/python/2.7.8/Frameworks/Python.framework/Versions/2.7/lib/libpython2.7.dylib \
  -DPYTHON_INCLUDE_DIR=/usr/local/Cellar/python/2.7.8/Frameworks/Python.framework/Versions/2.7/include/python2.7

source /opt/ros/indigo/setup.bash