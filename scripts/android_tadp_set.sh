#!/bin/bash
## set-path-for-android.sh
#### Configures a terminal environment for Android builds.
#### Arguments: 'set' to set, 'remove' to reset $PATH.

export ANDROID_NDK_VERSION='r10c' #`ls /home/$USER/NVPACK | grep ndk | cut -c 13-`

if [ "$1" = "set" ]; then
  export OLD_PATH_BEFORE=$PATH
  export PATH="$PATH:/home/$USER/NVPACK/android-sdk-linux/platform-tools"
  export PATH="$PATH:/home/$USER/NVPACK/android-sdk-linux/build-tools"
  export PATH="$PATH:/home/$USER/NVPACK/android-sdk-linux/tools"
  export ANDROID_HOME="/home/$USER/NVPACK/android-sdk-linux"
  export NDK_ROOT="/home/$USER/NVPACK/android-ndk-$ANDROID_NDK_VERSION"
  export NDKROOT="/home/$USER/NVPACK/android-ndk-$ANDROID_NDK_VERSION"
  export PATH="$PATH:/home/$USER/NVPACK/android-ndk-$ANDROID_NDK_VERSION"
  export NDK_STANDALONE_46_ANDROID9="/home/$USER/NVPACK/android-ndk-$ANDROID_NDK_VERSION/toolchains/arm-linux-androideabi-4.6/gen_standalone/linux-x86_64"
  export NDK_STANDALONE_48_ANDROID19="/home/$USER/NVPACK/android-ndk-$ANDROID_NDK_VERSION/toolchains/arm-linux-androideabi-4.8/gen_standalone/linux-x86_64"
  export ANT_HOME="/home/$USER/NVPACK/apache-ant-1.8.2"
  export PATH="$PATH:/home/$USER/NVPACK/apache-ant-1.8.2/bin"
  export CUDA_TOOLKIT_ROOT="/home/$USER/NVPACK/cuda-6.0"
  export PATH="$PATH:/home/$USER/NVPACK/cuda-6.0/bin"
  export NVPACK_ROOT="/home/$USER/NVPACK"
elif [ "$1" = "remove" ]; then
  export PATH=$OLD_PATH_BEFORE
  export OLD_PATH_BEFORE=
  export ANDROID_HOME=
  export NDK_ROOT=
  export NDK_STANDALONE_46_ANDROID9=
  export NDK_STANDALONE_48_ANDROID19=
  export ANT_HOME=
  export CUDA_TOOLKIT_ROOT=
  export NVPACK_ROOT=
else
  echo "specify what I'm doing with either \'set\' or \'remove\'"
fi
