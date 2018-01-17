FROM ubuntu:artful-20171019

MAINTAINER Jeremiah H. Savage <jeremiahsavage@gmail.com>

ENV version 0.27

RUN apt-get update \
    && apt-get install -y \
       python3-pandas \
       python3-pip \
       python3-sqlalchemy \
    && apt-get clean \
    && pip3 install readgroup_json_db \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*