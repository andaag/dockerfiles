my personal docker files. Scikit learn++ containers + some cuda stuff.

### Trusted builds:

https://hub.docker.com/u/andaag/


### Starting the large container:
```
docker run -v /directory/with/your/files:/ml -p 8888:8888 -ti andaag/large_notebook3
```
For more advanced startup see https://github.com/andaag/dockerfiles/blob/master/sklearn-notebook/pynotebook.sh


### Currently built on docker hub:

```
python3/base - andaag/sklearn_notebook3
python3/large - andaag/large_notebook3
```

### Structure in git repo:

```
base - basic python(2/3) sklearn
large - large base sklearn, adds a lot of extra libraries like seaborn/gensim/ipywidgets/ggplot/nltk/xgboost
large-mkl - Large images with intels Math Kernel Library - requires license (can be obtained for up to 4 nodes for free from anaconda cloud addons page)

python2 specific:
caffe - caffe+cudnn+gpu - built on top of andaag/large_notebook_mkl (can also be built on andaag/large_notebook). Requires cudnn download from nvidia.
```

#### NLTK note:

All images have a /ml volume, the default volume to start notebooks in
Large images have a /nltk_data volume - the nltk data directory. You can use 

```
import nltk
nltk.download("all", download_dir="/nltk_data")
```
This will populate the /nltk_data volume. You only need to run this once.

If you are building docker containers on this requiring nltk use this in the Dockerfile:
```
RUN python -m nltk.downloader -q all && rm -rf /nltk_data && mv /root/nltk_data /
```
