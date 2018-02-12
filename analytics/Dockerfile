# Centos7 / Py3 / Jupyter
# name analytics

FROM centos:7

# Patch and install deps
RUN yum update  -y  && \
    yum install -y \
        epel-release && \
    yum clean all && \
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
        unzip \
        mesa-libGLU-devel \
        postgresql-devel \
        libxml2-devel \
        gcc-c++ \
        unzip  \
        texlive \
        texlive-latex \
        texlive-xetex \
        texlive-collection-latex \
        texlive-collection-latexrecommended \
        texlive-xetex-def \
        texlive-collection-xetex \
        texlive-adjustbox \
        texlive-upquote \
    yum clean all && \
    rm -fr  /var/cache/yum



# install miniconda
RUN curl -sSL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh  \
  -o /tmp/Miniconda.sh 
RUN /bin/sh  /tmp/Miniconda.sh -bfp /usr/local
RUN conda update conda  -y 
RUN conda install conda-build CacheControl
RUN conda install -c r r-base r-caret r-snowballc r-dplyr r-tm r-kernlab \
    numpy matplotlib jupyter pandoc pandas r-rserve r-ggplot2 
RUN conda install -c conda-forge tweepy wordcloud xgboost
RUN conda skeleton cran Boruta && conda build Boruta
RUN conda skeleton NbClust && conda build NbClust

# r-drr and r-party conflict

