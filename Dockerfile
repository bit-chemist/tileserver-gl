FROM ubuntu:18.04 as builder

WORKDIR /root

RUN rm /bin/sh \
&& ln -s /bin/bash /bin/sh \
&& apt-get -qq update \
&& DEBIAN_FRONTEND=noninteractive apt-get -y install \
    apt-transport-https \
    curl \
    wget \
    unzip \
    build-essential \
    python \
    libcairo2-dev \
    libgles2-mesa-dev \
    libgbm-dev \
    libllvm3.9 \
    libprotobuf-dev \
    libxxf86vm-dev \
    xvfb \
    git \
&& apt-get clean

COPY / /root/

# initialize the submodules
RUN cd $HOME \
&& git submodule init \
&& git submodule update \
&& mkdir /root/.nvm

ENV NODE_VERSION 6.15.1
ENV NVM_DIR /root/.nvm

RUN cd $HOME \
&& curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash \
&& source $NVM_DIR/nvm.sh \
&& nvm alias default $NODE_VERSION \
&& nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

RUN cd /root && npm install --production

# install tileserver-gl-styles
RUN cd $HOME/tileserver-gl-styles \
&& git checkout master && git pull && node publish.js \
&& cd $HOME \
&& mv tileserver-gl-styles/ $HOME/node_modules/

RUN rm -rf .git


FROM ubuntu:18.04

ENV NODE_ENV="production"
ENV NODE_VERSION 6.15.1
VOLUME /data
WORKDIR /data
EXPOSE 8080
ENTRYPOINT ["/bin/bash", "-i", "/usr/src/app/run.sh"]

RUN rm /bin/sh \
&& ln -s /bin/bash /bin/sh \
&& mkdir -p /usr/src \
&& apt-get -qq update \
&& DEBIAN_FRONTEND=noninteractive apt-get -y install \
    apt-transport-https \
    curl \
    unzip \
#    build-essential \
    python \
#    libcairo2-dev \
    libgles2-mesa-dev \
#    libgbm-dev \
    libllvm3.9 \
#    libprotobuf-dev \
#    libxxf86vm-dev \
    xvfb \
    x11-utils \
&& apt-get clean

COPY --from=builder /root /usr/src/app

ENV NVM_DIR /usr/src/app/.nvm
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
