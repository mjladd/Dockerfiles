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
        make \
        unzip && \
    yum clean all && \
    rm -fr  /var/cache/yum


# Centos7 / Py3 / Jupyter

# install miniconda
RUN curl -sSL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \ 
 -o /tmp/Miniconda.sh 
RUN  /bin/sh  /tmp/Miniconda.sh -bfp /usr/local
RUN  conda update conda  -y && \
  conda install r numpy matplotlib jupyter 

# TODO: Need to flesh out conda packages to be installed
  #conda install r numpy matplotlib jupyter r-devel r-java r-java-devel texlive






