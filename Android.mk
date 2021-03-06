#
# Copyright (C) 2014 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

LOCAL_PATH := $(call my-dir)

LLVM_UNWIND_SRC_FILES := \
    src/libunwind.cpp \
    src/Unwind-EHABI.cpp \
    src/Unwind-sjlj.c \
    src/UnwindLevel1-gcc-ext.c \
    src/UnwindLevel1.c \
    src/UnwindRegistersSave.S \
    src/UnwindRegistersRestore.S \

LIBCXXABI_INCLUDES := \
    $(LOCAL_PATH)/include/ \
    external/libcxx/include/ \

LIBCXXABI_RTTI_FLAG := -frtti
LIBCXXABI_CPPFLAGS := \
    -std=c++11 \
    -fexceptions \
    -Wall \
    -Wextra \
    -Wno-unused-function \

include $(CLEAR_VARS)
LOCAL_MODULE := libunwind_llvm
LOCAL_CLANG := true
LOCAL_SRC_FILES_arm := $(LLVM_UNWIND_SRC_FILES)
LOCAL_C_INCLUDES := $(LIBCXXABI_INCLUDES)
LOCAL_CPPFLAGS := $(LIBCXXABI_CPPFLAGS)
LOCAL_CXX_STL := none
# src/Unwind/UnwindRegistersSave.S does not compile.
LOCAL_CLANG_ASFLAGS_arm += -no-integrated-as
LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/Android.mk
include $(BUILD_STATIC_LIBRARY)
