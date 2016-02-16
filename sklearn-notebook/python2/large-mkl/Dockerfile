# Usage:

# docker build -t andaag/large_notebook2_mkl .

## This requires license_mkl_*. To get one signup for continium and go to addons, ref http://docs.continuum.io/advanced-installation

FROM andaag/large_notebook2 

RUN mkdir -p /home/ml/.continuum /root/.continuum
ADD license_mkl_1449574630.txt /home/ml/.continuum/
ADD license_mkl_1449574630.txt /root/.continuum/
RUN chown ml:ml /home/ml -R
RUN conda install -y accelerate

EXPOSE 8888
CMD chown ml:ml /ml /nltk_data && sudo -s -E -H -u ml -- env PATH="/opt/miniconda/bin:$PATH" bash /home/ml/start.sh

