# docker build -t andaag/tensorflow .
FROM b.gcr.io/tensorflow/tensorflow-devel-gpu
RUN echo "deb http://archive.ubuntu.com/ubuntu/ trusty-security multiverse" >> sources.list && apt-get update
RUN apt-get install -y python-sklearn python-pandas
RUN pip install ggplot seaborn

RUN groupadd ml && useradd ml -m -g ml -u 1000 

RUN sudo -s -H -u ml -- env PATH="/opt/miniconda/bin:$PATH" jupyter notebook --generate-config
RUN sed -i \
        -e "s/^# c.NotebookApp.ip = 'localhost'$/c.NotebookApp.ip = '0.0.0.0'/" \
        -e "s/^# c.NotebookApp.port = 8888$/c.NotebookApp.port = 8888/" \
        -e "s;^# c.NotebookApp.notebook_dir = '/.*'$;c.NotebookApp.notebook_dir = '/ml';" \
        -e "s/^# c.NotebookApp.open_browser = True$/c.NotebookApp.open_browser = False/" \
        -e "s/^# c.IPKernelApp.extensions = \[\]$/c.IPKernelApp.extensions = ['']/" \
        /home/ml/.jupyter/jupyter_notebook_config.py

RUN mkdir -p /home/ml/.config/matplotlib/
RUN echo "backend      : agg" > /home/ml/.config/matplotlib/matplotlibrc
RUN chown ml:ml -R /home/ml/


VOLUME /ml
VOLUME /nltk_data
WORKDIR /ml

CMD chown ml:ml /ml /nltk_data && sudo -s -E -H -u ml -- jupyter notebook