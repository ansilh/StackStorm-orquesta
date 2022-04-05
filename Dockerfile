FROM ubuntu:xenial

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update \
    && apt-get install -y \
      python \
      python-dev \
      build-essential \
      libffi6 \
      libffi-dev \
      libssl-dev \
      curl \
      bash-completion \
      vim \
      git \
      graphviz \
      libgraphviz-dev \
      pkg-config
RUN curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py && python2 get-pip.py
COPY requirements.txt /requirements.txt
RUN pip install -r requirements.txt

RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt-get install -y nodejs

COPY web /web
WORKDIR /web
RUN npm install

COPY orquesta /orquesta
WORKDIR /orquesta
RUN pip install -e .

WORKDIR /web
COPY bin/docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
