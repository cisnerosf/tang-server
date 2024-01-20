FROM alpine:3.19 AS build

ARG TANG_TAG=v14

RUN set -eux && \
    apk add --no-cache \
        git g++ ninja meson \
        jose-dev http-parser-dev jansson-dev socat && \
    git clone https://github.com/latchset/tang.git && \
    cd tang && \
    git fetch --all --tags && \
    git checkout ${TANG_TAG} -b ${TANG_TAG} && \
    mkdir build && \
    cd build && \
    meson setup .. --prefix=/tang-install && \
    ninja && \
    ninja install

FROM alpine:3.19

COPY --from=build \
    /tang-install/libexec \
    /tang-install/bin \
    /usr/bin/

COPY ./docker-entrypoint ./run-app /usr/bin/

RUN set -eux && \
    apk add --no-cache su-exec curl http-parser jansson jose

EXPOSE 8000
VOLUME [ "/data" ]

ENV PUID=1000
ENV PGID=1000
ENV TANG_DB=/data
ENV TANG_PORT=8000

ENTRYPOINT ["docker-entrypoint"]
CMD ["daemon"]
