FROM ubuntu:16.04

COPY entrypoint.sh /entrypoint.sh
RUN apt-get update && \
    apt-get install -y \
        python3 \
        python3-pip \
        python3-setuptools \
        groff \
        less \
    && pip3 install --upgrade pip \
    && apt-get clean

RUN python3 -m pip --no-cache-dir install --upgrade awscli

ENTRYPOINT ["/entrypoint.sh"]
