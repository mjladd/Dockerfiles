# Centos7 / Py3 / Jupyter
# name py3rjup

FROM centos:7

# Patch and install deps
RUN yum update  -y  && \
    yum install -y \
        git \
        zlib-devel \
        bzip2 \
        bzip2-devel \
        readline-devel \
        sqlite-devel \
        openssl-devel  \
        xz-devel \
        gcc \
        libcurl-devel \
        libpng-devel \
        make \
        libxml2-devel \
        gcc-c++ \
        unzip && \
    yum clean all && \
    rm -fr  /var/cache/yum


# Centos7 / Py3 / Jupyter

# install miniconda
RUN curl -sSL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \ 
 -o /tmp/Miniconda.sh 
RUN  /bin/sh  /tmp/Miniconda.sh -bfp /usr/local
RUN  conda update conda  -y && \
  conda install r r-base r-rjava numpy matplotlib jupyter pandoc pandas \
       r-rserve r-caret

RUN conda install -c conda-forge tweepy
RUN conda install -c r r-caret

# TODO: Need to flesh out conda packages to be installed
  #conda install r numpy matplotlib jupyter r-devel r-java r-java-devel texlive






