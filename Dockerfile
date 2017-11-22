# This is the Dockerfile to run ProvNotebooks on Binder
#

FROM continuumio/anaconda

# install good version of Jupyter notebook
RUN pip install --no-cache-dir notebook==5.*

# install noworkflow
RUN pip install --no-cache-dir noworkflow[all]

# add now user running the jupyter notebook process
ENV NB_USER now
ENV NB_UID 1000
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

# make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

# start Jupyter server in notebooks folder
WORKDIR ${HOME}/notebooks
