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

RUN apt-get -y install build-essential gfortran wget libyaml-dev libfreetype6-dev libpng-dev pkg-config lib32ncurses5-dev && apt-get clean -y
RUN apt-get -y install ttf-bitstream-vera git-core && apt-get clean -y
RUN apt-get -y install python3.4-dev && apt-get clean -y && ln -s /usr/bin/python3.4 /usr/bin/python3
RUN wget https://bootstrap.pypa.io/get-pip.py && LC_ALL=C python3 get-pip.py

RUN pip3 install cython && rm -rf /root/.cache
RUN pip3 install pyreadline==2.0 && rm -rf /root/.cache
RUN pip3 install ipython[all] && rm -rf /root/.cache
RUN pip3 install numpy && rm -rf /root/.cache
RUN pip3 install numexpr && rm -rf /root/.cache #performance
RUN pip3 install bottleneck && rm -rf /root/.cache #performance
RUN pip3 install scipy && rm -rf /root/.cache
RUN pip3 install matplotlib && rm -rf /root/.cache
RUN pip3 install pandas && rm -rf /root/.cache
RUN pip3 install git+git://github.com/statsmodels/statsmodels && rm -rf /root/.cache
RUN pip3 install seaborn && rm -rf /root/.cache
RUN pip3 install git+git://github.com/scikit-learn/scikit-learn.git@0.16.X && rm -rf /root/.cache
RUN apt-get -y install sudo

VOLUME /ml
WORKDIR /ml

EXPOSE 8888
ENV PYTHONUNBUFFERED=1
CMD ipython notebook --no-browser --script --ip=0.0.0.0 --port 8888
