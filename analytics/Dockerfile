# Centos7 / Py3 / Jupyter
# name analytics

FROM centos:7

# Patch and install deps
RUN yum update  -y  && \
    yum install -y \
        epel-release && \
    yum clean all && \
    yum install -y \
        bzip2 \
        bzip2-devel \
        gcc \
        gcc-c++ \
        git \
        java-1.8.0-openjdk-devel \
        libcurl-devel \
        libpng-devel \
        libxml2-devel \
        make \
        mesa-libGLU-devel \
        openssl-devel  \
        postgresql-devel \
        readline-devel \
        sqlite-devel \
        texlive \
        texlive-latex \
        texlive-xetex \
        texlive-collection-latex \
        texlive-collection-latexrecommended \
        texlive-xetex-def \
        texlive-collection-xetex \
        texlive-adjustbox \
        texlive-upquote \
        unzip  \
        xz-devel \
        zlib-devel \
    yum clean all && \
    rm -fr  /var/cache/yum



# install miniconda
RUN curl -sSL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh  \
  -o /tmp/Miniconda.sh 
RUN /bin/sh  /tmp/Miniconda.sh -bfp /usr/local

# update conda
RUN conda update conda  -y 
RUN conda install conda-build CacheControl lockfile

# install packages available in r-repo
RUN conda install -c r r-base r-caret r-snowballc r-dplyr r-tm r-kernlab r-ggplot2 r-rserve \
    jupyter lockfile matplotlib numpy pandas pandoc 

# install packages available in conda-forge
RUN conda install -c conda-forge tweepy wordcloud xgboost 
    

# build packages not available in conda repo
RUN conda skeleton cran Boruta NbClust ClickClust clickstream \
  party binr stepPlr smbinning doParallel dummies pROC ROCR RTextTools && \
    conda build Boruta NbClust ClickClust clickstream party binr stepPlr smbinning \
    doParallel dummies pROC ROCR RTextTools 

