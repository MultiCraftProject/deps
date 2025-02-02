#!/bin/bash -e

. sdk.sh
JPEG_VERSION=2.1.4

mkdir -p deps; cd deps

if [ ! -d libjpeg-src ]; then
	wget https://download.sourceforge.net/libjpeg-turbo/libjpeg-turbo-$JPEG_VERSION.tar.gz
	tar -xzvf libjpeg-turbo-$JPEG_VERSION.tar.gz
	mv libjpeg-turbo-$JPEG_VERSION libjpeg-src
	rm libjpeg-turbo-$JPEG_VERSION.tar.gz
	mkdir libjpeg-src/build
fi

cd libjpeg-src/build

cmake .. -DANDROID_STL="c++_static" -DANDROID_NATIVE_API_LEVEL="$NATIVE_API_LEVEL" \
	-DCMAKE_BUILD_TYPE=Release \
	-DENABLE_SHARED=OFF \
	-DANDROID_ABI="$ANDROID_ABI" \
	-DANDROID_PLATFORM="$API" \
	-DCMAKE_C_FLAGS_RELEASE="$CFLAGS" \
	-DCMAKE_TOOLCHAIN_FILE="$ANDROID_NDK/build/cmake/android.toolchain.cmake"

cmake --build . -j

make DESTDIR=$PWD/../../../../libjpeg install

# update `include` folder
rm -rf ../../../../libjpeg/include
mv ../../../../libjpeg/opt/libjpeg-turbo/include ../../../../libjpeg/include
# update lib
rm -rf ../../../../libjpeg/clang/$TARGET_ABI/libjpeg.a
mv ../../../../libjpeg/opt/libjpeg-turbo/lib*/libjpeg.a ../../../../libjpeg/clang/$TARGET_ABI/libjpeg.a

# cleanup
rm -rf ../../../../libjpeg/opt/

echo "libjpeg build successful"
