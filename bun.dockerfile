FROM alpine:latest

RUN apk add --no-cache \
    llvm clang llvm-static llvm-dev && \
    apk add --no-cache \
    --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing \
    build-base cmake make nodejs-current npm \
    go libtool autoconf pkgconfig automake ninja \
    tcc esbuild tar curl bash xz \
    git linux-headers rust cargo \
    ruby icu-dev lld

ARG ZIG_VERSION=0.10.0-dev.2822+b79884eaf
RUN curl -LO https://ziglang.org/builds/zig-linux-x86_64-${ZIG_VERSION}.tar.xz && \
    tar -xvf zig-linux-x86_64-${ZIG_VERSION}.tar.xz && \
    mv zig-linux-x86_64-${ZIG_VERSION} /zig

ENV PATH=${PATH}:/zig

RUN zig version

ENV JSC_BASE_DIR=/webkit
ENV WEBKIT_DIR=/webkit
ENV LIB_ICU_PATH=/webkit/lib
ENV STATIC_MUSL_FLAG=-static
ENV MIMALLOC_OVERRIDE_FLAG="-DMI_OVERRIDE=OFF"

COPY ./build.sh /build.sh

WORKDIR /bun

CMD ["/bin/bash"]
