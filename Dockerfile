FROM amazonlinux:2

WORKDIR /tmp
#install the dependencies
RUN yum -y install tar && yum -y install gzip && yum -y install gcc-c++ && yum -y install findutils

RUN touch ~/.bashrc && chmod +x ~/.bashrc

RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.38.0/install.sh | bash

RUN source ~/.bashrc && nvm install v14.0.0

WORKDIR /build
