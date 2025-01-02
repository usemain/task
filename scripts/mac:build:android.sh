#!/bin/bash

set -e

PROJECT_PATH="/Users/yu/Code"

DEBUG_INFO_PATH="$PROJECT_PATH/debug-code/android"

mkdir -p "$DEBUG_INFO_PATH"

echo "开始构建 Android APK..."
flutter build apk --obfuscate --split-debug-info="$DEBUG_INFO_PATH"

echo "构建完成! APK混淆调试串存储在: $DEBUG_INFO_PATH"

open "../build/app/outputs/apk/release/"