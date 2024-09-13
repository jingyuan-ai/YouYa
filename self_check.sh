#!/bin/bash

set -e
set -x

code_src_dir="src"

# 如果没有安装clang-format，先安装
if ! [ -x "$(command -v clang-format)" ]; then
    sudo apt-get update
    sudo apt-get install clang-format
fi

find ${code_src_dir} -name '*.cpp' -o -name '*.h' | xargs clang-format -i

# 如果没有cpplint，先安装
if ! [ -x "$(command -v cpplint)" ]; then
    pip3 install cpplint
fi

cpplint $(find ${code_src_dir} -name '*.cpp' -o -name '*.h')