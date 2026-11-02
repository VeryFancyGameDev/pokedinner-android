#!/bin/sh -e

# SPDX-FileCopyrightText: Copyright 2026 Eden Emulator Project
# SPDX-License-Identifier: GPL-3.0-or-later

# Builds the Android APK into artifacts/. Arguments are passed to .ci/android/build.sh
# (see its --help), for example: ./build-android.sh -t legacy -b Debug

cd "$(dirname "$0")"

if [ -z "${ANDROID_HOME:-$ANDROID_SDK_ROOT}" ] && [ ! -f src/android/local.properties ]; then
    echo "-- ! Set ANDROID_HOME to your Android SDK (it needs NDK 28.2.13676358 and CMake 3.31.5)." >&2
    exit 1
fi

if ! command -v java >/dev/null 2>&1; then
    echo "-- ! JDK 17 or newer is required, but java was not found." >&2
    exit 1
fi

[ "$#" -gt 0 ] || set -- -t standard -b Release -DENABLE_WERROR=OFF

exec .ci/android/build.sh "$@"
