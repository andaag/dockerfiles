my personal docker files

Trusted builds:
https://hub.docker.com/u/andaag/

Currently built on docker hub:
python3/base - sklearn_notebook3
python3/large - large_notebook3

base - basic python(2/3) sklearn
large - large base sklearn, adds a lot of extra libraries like seaborn/gensim/ipywidgets/ggplot/nltk/xgboost
large-mkl - Large images with intels Math Kernel Library - requires license (can be obtained for up to 4 nodes for free from anaconda cloud addons page)

python2 specific:
caffe - caffe+cudnn+gpu - built on top of andaag/large_notebook_mkl (can also be built on andaag/large_notebook). Requires cudnn download from nvidia.


All images have a /ml volume, the default volume to start notebooks in
Large images have a /nltk_data volume - the nltk data directory. You can use 
# import nltk
# nltk.download("all", download_dir="/nltk_data")
# To populate this directory


If you are building docker containers on this requiring nltk use this in the Dockerfile:
RUN python -m nltk.downloader -q all && rm -rf /nltk_data && mv /root/nltk_data /

JOBLIB_TEMP_FOLDER

/home/neuron/src/ml/nltk/tmp:/nltk_data
