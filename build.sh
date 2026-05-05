#!/bin/bash
set -e
swift build -c release
mkdir -p bin
cp .build/release/fledge-plugin-morse bin/fledge-plugin-morse
echo "Built bin/fledge-plugin-morse"
