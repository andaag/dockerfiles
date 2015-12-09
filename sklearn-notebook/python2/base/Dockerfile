# Usage:
# docker build -t andaag/sklearn_notebook2 .
# mkdir ml
# docker run -v $(pwd)/ml:/ml -t andaag/sklearn_notebook2

FROM ubuntu:15.04
ENV DEBIAN_FRONTEND noninteractive
ENV JOBLIB_TEMP_FOLDER /tmp
RUN apt-get update
RUN apt-get upgrade -y && apt-get clean -y

RUN mkdir /ml && chmod 755 /ml
RUN locale-gen en_US en_US.UTF-8

RUN apt-get -y install git-core curl bzip2 && apt-get clean -y
RUN curl -L http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh > /tmp/miniconda.sh && bash /tmp/miniconda.sh -p /opt/miniconda -b && rm /tmp/miniconda.sh
ENV PATH=/opt/miniconda/bin:${PATH}

RUN conda update -y conda && conda install -y cython numpy numexpr bottleneck scipy matplotlib pandas statsmodels scikit-learn jupyter libgfortran psutil

VOLUME /ml
WORKDIR /ml

EXPOSE 8888
ENV PYTHONUNBUFFERED=1
CMD jupyter notebook --no-browser --script --ip=0.0.0.0 --port 8888
