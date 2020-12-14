FROM balenalib/rpi-debian:build as builder
LABEL maintainer michel.promonet@free.fr
WORKDIR /build
COPY . /build

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates g++ autoconf automake libtool xz-utils cmake make pkg-config git wget libx264-dev libx265-dev libjpeg8-dev libvpx-dev \
    && make install && apt-get clean && rm -rf /var/lib/apt/lists/

FROM balenalib/rpi-debian:run
WORKDIR /usr/local/share/v4l2tools
COPY --from=builder /usr/local/bin/ /usr/local/bin/

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates x264 x265 libjpeg8 libvpx5 \
    && apt-get clean && rm -rf /var/lib/apt/lists/

# [ "/usr/local/bin/v4l2compress" ]
CMD [ "" ]
