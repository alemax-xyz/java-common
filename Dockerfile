FROM library/ubuntu:bionic AS build

ENV LANG=C.UTF-8
RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get install -y \
        software-properties-common \
        apt-utils

RUN mkdir -p /build /rootfs
WORKDIR /build
RUN apt-get download \
        libgif7 \
        libjpeg-turbo8 \
        libpng16-16 \
        liblcms2-2 \
        libpcsclite1 \
        libexpat1 \
        libfreetype6 \
        libfontconfig1 \
        libasound2 \
        libnspr4 \
        libsqlite3-0 \
        libnss3 \
        liblz4-1 \
        liblzma5 \
        libgpg-error0 \
        libgcrypt20 \
        libsystemd0 \
        libdbus-1-3 \
        libavahi-common3 \
        libavahi-client3 \
        libgmp10 \
        libnettle6 \
        libhogweed4 \
        libunistring2 \
        libidn2-0 \
        libffi6 \
        libp11-kit0 \
        libtasn1-6 \
        libgnutls30 \
        libcom-err2 \
        libkrb5support0 \
        libk5crypto3 \
        libkeyutils1 \
        libkrb5-3 \
        libgssapi-krb5-2 \
        libcups2 \
        libbsd0 \
        libxau6 \
        libxdmcp6 \
        libxcb1 \
        libx11-data \
        libx11-6 \
        libxext6 \
        libxrender1 \
        libxi6 \
        libxtst6 \
        libglvnd0 \
        libdrm2 \
        libglapi-mesa \
        libxcb-dri2-0 \
        libxcb-dri3-0 \
        libxcb-glx0 \
        libxcb-present0 \
        libxcb-sync1 \
        libxcb-damage0 \
        libxfixes3 \
        libxshmfence1 \
        libxxf86vm1 \
        libelf1 \
        libedit2 \
        libllvm8 \
        libsensors4 \
        libglx-mesa0 \
        libglx0 \
        libgl1 \
        ca-certificates-java

RUN find *.deb | xargs -I % dpkg-deb -x % /rootfs

WORKDIR /rootfs
RUN rm -rf \
        etc/ca-certificates \
        etc/default \
        usr/share/bug \
        usr/share/doc* \
        usr/share/lintian \
        usr/share/man

COPY init/ etc/init/

WORKDIR /


FROM clover/common

ENV LANG=C.UTF-8

COPY --from=build /rootfs /
