#!/bin/bash
export CCACHE_DIR=".cache/ccache"

mkdir -p out
mkdir -p .cache/ccache

cmake --preset linux-debug -B out \
    && cmake --build out \
    && out/bin/canary-debug
