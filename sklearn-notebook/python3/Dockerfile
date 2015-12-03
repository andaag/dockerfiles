# Usage:
# docker build -t andaag/sklearn_notebook3 .
# mkdir ml
# docker run -v $(pwd)/ml:/ml -t andaag/sklearn_notebook3

FROM ubuntu:15.04
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get upgrade -y && apt-get clean -y

RUN mkdir /ml && chmod 755 /ml
RUN locale-gen en_US en_US.UTF-8

RUN apt-get -y remove libatlas3gf-base libatlas-dev
RUN apt-get -y install libopenblas-base libopenblas-dev liblapack-dev && apt-get clean -y
RUN update-alternatives  --set libblas.so.3 /usr/lib/openblas-base/libblas.so.3
RUN update-alternatives --set liblapack.so.3 /usr/lib/lapack/liblapack.so.3

RUN apt-get -y install build-essential sudo gfortran wget libyaml-dev libfreetype6-dev libpng-dev pkg-config lib32ncurses5-dev && apt-get clean -y
RUN apt-get -y install ttf-bitstream-vera git-core && apt-get clean -y
RUN apt-get -y install python3.4-dev && apt-get clean -y && ln -s /usr/bin/python3.4 /usr/bin/python3
RUN wget https://bootstrap.pypa.io/get-pip.py && LC_ALL=C python3 get-pip.py

COPY requirements.txt /tmp/requirements.txt
RUN for i in $(cat /tmp/requirements.txt); do pip3 install $i; done && rm /tmp/requirements.txt && rm -rf /root/.cache

VOLUME /ml
WORKDIR /ml

EXPOSE 8888
ENV PYTHONUNBUFFERED=1
CMD jupyter notebook --no-browser --script --ip=0.0.0.0 --port 8888
