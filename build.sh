#!/bin/bash
set -ex

make sqlite
make vendor identifier-cache jsc dev

echo "[DONE]"

