# Centos7 / Py3 / Jupyter


FROM centos:7

RUN yum update  -y &&
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
        unzip && 
        yum clean all

# install pyenv
#RUN git clone https://github.com/pyenv/pyenv.git  /root/.pyenv &&
#  echo 'export PYENV_ROOT="/root/.pyenv" >> /root/.bashrc && 
#  echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> /root/.bashrc &
#  source /root/.bashrc &&
#  eval  "$(pyenv  init-)" &&
#  source /root/.bashrc &&
#  exec "$SHELL" &&
#  pyenv install 3.6.4 &&
#  pyenv global 3.6.4


# install miniconda
curl -sSL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh  \
  -o /tmp/Miniconda.sh &&
  sh  /tmp/Miniconda.sh -bfp /usr/local &&
  conda update conda  -y &&
  conda install r numpy matplotlib jupyter r-devel r-java r-java-devel texlive




RUN pip3 --no-cache-dir install \
    Pillow \
    h5py \
    ipykernel \
    jupyter \
    matplotlib \
    numpy \
    pandas \
    scipy \
    sklearn \
    cufflinks \
    ipywidgets \
    networkx \
    notebook \
    plotly \
    requests \
    sympy \
    seaborn \
    Cython \
    patsy \
    cloudpickle \
    dill \
    numba \
    bokeh \
    vincent \
    beautifulsoup4 \
&& python3 -m ipykernel.kernelspec



VOLUME /notebooks
ENTRYPOINT /usr/local/bin/jupyter-notebook --no-browser --ip=0.0.0.0 --notebook-dir=/notebooks --allow-root  --NotebookApp.token=''

# TensorBoard
EXPOSE 6006
# IPython
EXPOSE 8888

