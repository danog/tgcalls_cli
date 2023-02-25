cmake_minimum_required(VERSION 3.10.2 FATAL_ERROR)
project(tgcalls_cli)

EXECUTE_PROCESS( COMMAND uname -m COMMAND tr -d '\n' OUTPUT_VARIABLE ARCHITECTURE )
set(THIRDPARTY_DIR "${CMAKE_HOME_DIRECTORY}/third_party")

include("${CMAKE_HOME_DIRECTORY}/cmake/ReadVariables.cmake")
include("${CMAKE_HOME_DIRECTORY}/cmake/Prefix.cmake")
include("${CMAKE_HOME_DIRECTORY}/cmake/Join.cmake")

set(SSL_DIR "${THIRDPARTY_DIR}/boringssl")
set(SSL_LIB_PATH "${SSL_DIR}/build/${ANDROID_ABI}/ssl/libssl.a")
set(CRYPTO_LIB_PATH "${SSL_DIR}/build/${ANDROID_ABI}/crypto/libcrypto.a")

# crypto
add_library(crypto STATIC IMPORTED)
set_target_properties(crypto PROPERTIES IMPORTED_LOCATION "${CRYPTO_LIB_PATH}")

# ssl
add_library(ssl STATIC IMPORTED)
set_target_properties(ssl PROPERTIES IMPORTED_LOCATION "${SSL_LIB_PATH}")
target_include_directories(ssl INTERFACE "${SSL_DIR}/include")

# libtgvoip
include("${CMAKE_HOME_DIRECTORY}/BuildTelegramVoIP.cmake")

# usrsctp
include("${CMAKE_HOME_DIRECTORY}/BuildUsrSCTP.cmake")

# srtp
include("${CMAKE_HOME_DIRECTORY}/BuildLibSRTP.cmake")

# openh264
include("${CMAKE_HOME_DIRECTORY}/BuildOpenH264.cmake")

# absl
include("${CMAKE_HOME_DIRECTORY}/BuildAbsl.cmake")

# webrtc
include("${CMAKE_HOME_DIRECTORY}/BuildWebRTC.cmake")

# tgcalls
include("${CMAKE_HOME_DIRECTORY}/BuildTgCalls.cmake")

# yuv
include("${CMAKE_HOME_DIRECTORY}/BuildYuv.cmake")

# opus
include("${CMAKE_HOME_DIRECTORY}/BuildOpus.cmake")

# == Linking dependencies ==
