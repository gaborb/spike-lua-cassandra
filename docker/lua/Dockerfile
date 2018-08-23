FROM alpine:latest

RUN apk add --no-cache --update \
    bash \
    build-base \
    curl \
    linux-headers \
    make \
    perl \
    unzip \
    git \
    openssl-dev \
    lua5.1 \
    lua5.1-dev \
    luarocks5.1 \
    && rm -rf /var/cache/apk/*

RUN ln -s /usr/bin/luarocks-5.1 /usr/bin/luarocks

RUN addgroup -g 1000 -S app \
    && adduser -u 1000 -S app -G app

USER app

WORKDIR /home/app

ENV ENV="\$HOME/.shinit"

RUN luarocks path >> ~/.shinit

RUN luarocks --local install luasocket \
    && luarocks --local install luasec \
    && luarocks --local install luabitop \
    && luarocks --local install lua-cassandra \
    && luarocks --local install lua-resty-jit-uuid \
    && luarocks --local install penlight
