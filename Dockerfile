FROM alpine:latest
LABEL maintainer "Muhammad Fahrizal Rahman m[dot]fahrizal[at]intispace[dot]com"

# System dependencies
RUN apk update && \
    apk add --virtual rizalpack libc6-compat curl net-tools wget util-linux gcc bash
    # apk add --no-cache libc6-compat curl net-tools wget util-linux gcc bash
RUN curl https://getcaddy.com | bash -s personal http.cors,http.expires,http.forwardproxy,http.ipfilter,http.login,http.minify,http.nobots,http.proxyprotocol,http.ratelimit,http.realip,http.reauth,http.cache
#Remove build devs
RUN apk del rizalpack
