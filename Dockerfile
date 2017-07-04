FROM ubuntu:16.04
MAINTAINER Hyan Mandian <hyanmandian@hotmail.com>

RUN apt-get update && \ 
    apt-get install \
    apt-transport-https \
    curl \
    libbsd-dev \
    libedit-dev \
    libevent-core-2.0-5 \
    libevent-dev \
    libevent-extra-2.0-5 \
    libevent-openssl-2.0-5 \
    libevent-pthreads-2.0-5 \
    libgmp-dev \
    libgmpxx4ldbl \
    libssl-dev \
    libxml2-dev \
    libyaml-dev \
    libreadline-dev \
    automake \
    libtool \
    git \
    llvm \
    libpcre3-dev \
    build-essential -y && \
    apt-key adv --keyserver keys.gnupg.net --recv-keys A4EBAC6667697DD2 && \
    echo "deb https://dist.crystal-lang.org/apt crystal main" > /etc/apt/sources.list.d/crystal.list && \
    apt-get update && \
    apt-get install crystal