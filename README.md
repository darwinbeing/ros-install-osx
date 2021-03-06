ros-install-osx   [![Build Status](https://travis-ci.org/mikepurvis/ros-install-osx.svg?branch=master)](https://travis-ci.org/mikepurvis/ros-install-osx)
===============

Requirement
-----

os: 10.12.6  
boost 1.64  
boost-python 1.64  
gtest  
gazebo  
yaml-cpp 0.5.3

```shell
brew install qt5
brew unlink qt
brew link --force qt5
echo 'export PATH="/usr/local/opt/qt/bin:$PATH"' >> ~/.zshrc
sudo ln -s /usr/local/Cellar/qt/5.9.1/mkspecs /usr/local/mkspecs
sudo ln -s /usr/local/Cellar/qt/5.9.1/plugins /usr/local/plugins
```


```cpp
From 0173a538f89c66e2783dc67ee3609660625e16b4 Mon Sep 17 00:00:00 2001
From: Tim Rakowski <tim.rakowski@googlemail.com>
Date: Thu, 4 Jan 2018 23:14:31 +0100
Subject: [PATCH 1/8] Replaced deprecated log macro calls

---
 tf2/src/buffer_core.cpp | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tf2/src/buffer_core.cpp b/tf2/src/buffer_core.cpp
index 6483ada..75b827d 100644
--- a/tf2/src/buffer_core.cpp
+++ b/tf2/src/buffer_core.cpp
@@ -123,7 +123,7 @@ bool BufferCore::warnFrameId(const char* function_name_arg, const std::string& f
   {
     std::stringstream ss;
     ss << "Invalid argument passed to "<< function_name_arg <<" in tf2 frame_ids cannot be empty";
-    logWarn("%s",ss.str().c_str());
+    CONSOLE_BRIDGE_logWarn("%s",ss.str().c_str());
     return true;
   }

@@ -131,7 +131,7 @@ bool BufferCore::warnFrameId(const char* function_name_arg, const std::string& f
   {
     std::stringstream ss;
     ss << "Invalid argument \"" << frame_id << "\" passed to "<< function_name_arg <<" in tf2 frame_ids cannot start with a '/' like: ";
-    logWarn("%s",ss.str().c_str());
+    CONSOLE_BRIDGE_logWarn("%s",ss.str().c_str());
     return true;
   }

@@ -218,26 +218,26 @@ bool BufferCore::setTransform(const geometry_msgs::TransformStamped& transform_i
   bool error_exists = false;
   if (stripped.child_frame_id == stripped.header.frame_id)
   {
-    logError("TF_SELF_TRANSFORM: Ignoring transform from authority \"%s\" with frame_id and child_frame_id  \"%s\" because they are the same",  authority.c_str(), stripped.child_frame_id.c_str());
+    CONSOLE_BRIDGE_logError("TF_SELF_TRANSFORM: Ignoring transform from authority \"%s\" with frame_id and child_frame_id  \"%s\" because they are the same",  authority.c_str(), stripped.child_frame_id.c_str());
     error_exists = true;
   }

   if (stripped.child_frame_id == "")
   {
-    logError("TF_NO_CHILD_FRAME_ID: Ignoring transform from authority \"%s\" because child_frame_id not set ", authority.c_str());
+    CONSOLE_BRIDGE_logError("TF_NO_CHILD_FRAME_ID: Ignoring transform from authority \"%s\" because child_frame_id not set ", authority.c_str());
     error_exists = true;
   }

   if (stripped.header.frame_id == "")
   {
-    logError("TF_NO_FRAME_ID: Ignoring transform with child_frame_id \"%s\"  from authority \"%s\" because frame_id not set", stripped.child_frame_id.c_str(), authority.c_str());
+    CONSOLE_BRIDGE_logError("TF_NO_FRAME_ID: Ignoring transform with child_frame_id \"%s\"  from authority \"%s\" because frame_id not set", stripped.child_frame_id.c_str(), authority.c_str());
     error_exists = true;
   }

   if (std::isnan(stripped.transform.translation.x) || std::isnan(stripped.transform.translation.y) || std::isnan(stripped.transform.translation.z)||
       std::isnan(stripped.transform.rotation.x) ||       std::isnan(stripped.transform.rotation.y) ||       std::isnan(stripped.transform.rotation.z) ||       std::isnan(stripped.transform.rotation.w))
   {
-    logError("TF_NAN_INPUT: Ignoring transform for child_frame_id \"%s\" from authority \"%s\" because of a nan value in the transform (%f %f %f) (%f %f %f %f)",
+    CONSOLE_BRIDGE_logError("TF_NAN_INPUT: Ignoring transform for child_frame_id \"%s\" from authority \"%s\" because of a nan value in the transform (%f %f %f) (%f %f %f %f)",
               stripped.child_frame_id.c_str(), authority.c_str(),
               stripped.transform.translation.x, stripped.transform.translation.y, stripped.transform.translation.z,
               stripped.transform.rotation.x, stripped.transform.rotation.y, stripped.transform.rotation.z, stripped.transform.rotation.w
@@ -252,7 +252,7 @@ bool BufferCore::setTransform(const geometry_msgs::TransformStamped& transform_i

   if (!valid)
   {
-    logError("TF_DENORMALIZED_QUATERNION: Ignoring transform for child_frame_id \"%s\" from authority \"%s\" because of an invalid quaternion in the transform (%f %f %f %f)",
+    CONSOLE_BRIDGE_logError("TF_DENORMALIZED_QUATERNION: Ignoring transform for child_frame_id \"%s\" from authority \"%s\" because of an invalid quaternion in the transform (%f %f %f %f)",
              stripped.child_frame_id.c_str(), authority.c_str(),
              stripped.transform.rotation.x, stripped.transform.rotation.y, stripped.transform.rotation.z, stripped.transform.rotation.w);
     error_exists = true;
@@ -274,7 +274,7 @@ bool BufferCore::setTransform(const geometry_msgs::TransformStamped& transform_i
     }
     else
     {
-      logWarn("TF_OLD_DATA ignoring data from the past for frame %s at time %g according to authority %s\nPossible reasons are listed at http://wiki.ros.org/tf/Errors%%20explained", stripped.child_frame_id.c_str(), stripped.header.stamp.toSec(), authority.c_str());
+      CONSOLE_BRIDGE_logWarn("TF_OLD_DATA ignoring data from the past for frame %s at time %g according to authority %s\nPossible reasons are listed at http://wiki.ros.org/tf/Errors%%20explained", stripped.child_frame_id.c_str(), stripped.header.stamp.toSec(), authority.c_str());
       return false;
     }
   }
@@ -633,7 +633,7 @@ geometry_msgs::TransformStamped BufferCore::lookupTransform(const std::string& t
     case tf2_msgs::TF2Error::LOOKUP_ERROR:
       throw LookupException(error_string);
     default:
-      logError("Unknown error code: %d", retval);
+      CONSOLE_BRIDGE_logError("Unknown error code: %d", retval);
       assert(0);
     }
   }
@@ -1604,7 +1604,7 @@ void BufferCore::_chainAsVector(const std::string & target_frame, ros::Time targ
     case tf2_msgs::TF2Error::LOOKUP_ERROR:
       throw LookupException(error_string);
     default:
-      logError("Unknown error code: %d", retval);
+      CONSOLE_BRIDGE_logError("Unknown error code: %d", retval);
       assert(0);
     }
   }
@@ -1623,7 +1623,7 @@ void BufferCore::_chainAsVector(const std::string & target_frame, ros::Time targ
     case tf2_msgs::TF2Error::LOOKUP_ERROR:
       throw LookupException(error_string);
     default:
-      logError("Unknown error code: %d", retval);
+      CONSOLE_BRIDGE_logError("Unknown error code: %d", retval);
       assert(0);
     }
   }
--
2.14.3 (Apple Git-98)
```

This repo aims to maintain a usable, scripted, up-to-date installation procedure for
[ROS](http://ros.org), currently Lunar. The intent is that the `install` script may
be executed on a El Capitan or newer machine and produce a working desktop_full
installation, including RQT, rviz, and Gazebo.

This is the successor to my [popular gist on the same topic][1].

[1]: https://gist.github.com/mikepurvis/9837958


Usage
-----

```shell
git clone https://github.com/mikepurvis/ros-install-osx.git
cd ros-install-osx 
ROS_DISTRO=kinetic ./install
```

Note that if you do not yet have XQuartz installed, you will be forced to log out and
in after that installation, and re-run this script.

You will be prompted for your sudo password at the following points in this process:

   - Homebrew installation.
   - Caskroom installation.
   - XQuartz installation.
   - Initializing rosdep.
   - Creating and chowning your `/opt/ros/[distro]` folder.

The installation can be done entirely without sudo if Homebrew and XQuartz are already
installed, rosdep is already installed and initialized, and you set the `ROS_INSTALL_DIR`
environment variable to a path which already exists and you have write access to.


Step by Step
------------

The `install` script should just work for most users. However, if you run into trouble,
it's a pretty big pain to rebuild everything. Note that in this scenario, it may make
sense to treat the script as a list of instructions, and execute them one by one,
manually.

If you have a build fail, for example with rviz, note that you can modify the `catkin build`
line to start at a particular package. Inside your `indigo_desktop_full_ws` dir, run:

    catkin build --start-with rviz

If you've resolved whatever issue stopped the build previously, this will pick up where
it left off.


## Troubleshooting

### Python and pip packages

Already-installed homebrew and pip packages are the most significant source of errors,
especially pip packages linked against the system Python rather than Homebrew's Python,
and Homebrew packages (like Ogre) where multiple versions end up installed, and things
which depend on them end up linked to the different versions. If you have MacPorts or
Fink installed, and Python from either of those is in your path, that will definitely
be trouble.

The script makes _some_ attempt at detecting and warning about these situations, but some
problems of this kind will only be visible as segfaults at runtime.

Unfortunately, it's pretty destructive to do so, but the most reliable way to give
yourself a clean start is removing the current homebrew installation, and all
currently-installed pip packages.

For pip: `pip freeze | xargs sudo pip uninstall -y`

For homebrew, see the following: https://gist.github.com/mxcl/1173223

If you take these steps, obviously also remove your ROS workspace and start the install
process over from scratch as well. Finally, audit your `$PATH` variable to ensure that
when you run `python`, you're getting Homebrew's `python`.
Another way to check which Python you are running is to do:

```bash
which python # Should result in /usr/local/bin/python
ls -l $(which python) # Should show a symlink pointing to Homebrew's Cellar
```

If you are getting permission errors when you `sudo uninstall` pip packages,
see [Issue #11](https://github.com/mikepurvis/ros-install-osx/issues/11) and
[this StackOverflow Q&A](http://stackoverflow.com/a/35051066/2653356).

### El Capitan support

The `install` script may not work as smoothly in OS X El Capitan.
Here are some pointers, tips, and hacks to help you complete the installation.
This list was compiled based on the discussion in [Issue #12](https://github.com/mikepurvis/ros-install-osx/issues/12).

#### library not found for -ltbb

See [Issue #4](https://github.com/mikepurvis/ros-install-osx/issues/4).
You need to compile using Xcode's Command Line Tools:

```shell
xcode-select --install # Install the Command Line Tools
sudo xcode-select -s /Library/Developer/CommandLineTools # Switch to using them
gcc --version # Verify that you are compiling using Command Line Tools
```

The last command should output something that includes the following:

```bash
Configured with: --prefix=/Library/Developer/CommandLineTools/usr
```

You'll then have to rerun the entire `install` script or do the following:

```bash
rm -rf /opt/ros/indigo/* # More generally, /opt/ros/${ROS_DISTRO}/*
rm -rf build/ devel/ # Assuming your working dir is the catkin workspace
catkin build \
  ... # See actual script for the 4-line-long command
```

#### dyld: Library not loaded

If you see this after installation, when trying to execute `rosrun`, then you
have [System Integrity Protection](https://support.apple.com/en-us/HT204899) enabled.
The installation script should have detected that and *suggested* a quick fix.
Please refer to the very last section of 
[`install`](https://github.com/mikepurvis/ros-install-osx/blob/master/install)
