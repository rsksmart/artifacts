#
# RSK Reproducible Build environment
#
FROM ubuntu:16.04

RUN apt-get update -y && \
    apt-get install -y git curl gnupg-curl openjdk-8-jdk=8u181-b13-1ubuntu0.16.04.1 && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get autoremove -y && \
    apt-get clean
