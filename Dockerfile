# Use nvidia/cuda version matches your server
FROM nvidia/cuda:11.4.3-base-ubuntu20.04

# Install ubuntu apt packages. Do not remove default packages.
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    apt-utils \
    build-essential \
    ca-certificates \
    curl \
    git \
    htop \
    sudo \
    vim \
    wget \
    python3-dev \
    python3-pip \
    tmux \
    && rm -rf /var/lib/apt/lists/*

# Install python packages
RUN pip3 --no-cache-dir install --upgrade \
    pip \
    setuptools \
    ipython \
    ipdb \
    matplotlib \
    pandas \
    scipy \
    jupyter \
    slacker \
    tqdm

RUN pip3 --no-cache-dir install torch==1.12.1+cu113 torchvision==0.13.1+cu113 torchaudio==0.12.1 --extra-index-url https://download.pytorch.org/whl/cu113


ARG UNAME
ARG UID
ARG GID

RUN addgroup --gid ${GID} ${UNAME}
RUN useradd -m -u ${UID} -g ${GID} -s /bin/bash -p ${UNAME} ${UNAME}
RUN echo "${UNAME}:${UNAME}" | chpasswd
RUN adduser ${UNAME} sudo
RUN usermod -aG sudo ${UNAME}
RUN gpasswd -a ${UNAME} sudo

USER ${UNAME}
WORKDIR /home/${UNAME}
