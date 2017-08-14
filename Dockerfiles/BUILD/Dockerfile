#
# RSK Reproducible Build environment
#
FROM ubuntu:16.04

RUN apt-get update -y && \
    apt-get install -y git curl gnupg-curl openjdk-8-jdk=8u131-b11-2ubuntu1.16.04.3 && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get autoremove -y && \
    apt-get clean
