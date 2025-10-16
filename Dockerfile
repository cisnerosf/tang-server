FROM alpine:3.22 AS build

ARG TANG_TAG=v15

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

FROM alpine:3.22

COPY --from=build \
    /tang-install/libexec \
    /tang-install/bin \
    /usr/bin/

COPY ./entrypoint /usr/bin/
RUN chmod +x /usr/bin/entrypoint

RUN set -eux && \
    apk add --no-cache su-exec curl http-parser jansson jose

# Create user
RUN addgroup -g 1001 tanggroup && adduser -D -u 1001 -G tanggroup tang

USER 1001
EXPOSE 8000
VOLUME ["/data"]

ENTRYPOINT ["entrypoint"]
