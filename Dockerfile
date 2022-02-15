FROM continuumio/miniconda3

CMD [ "bash" ]

## install apt-get packages

RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

## install conda and python packages

# Use mirror of conda channels
# COPY ./njupt.condarc /root/.condarc
COPY ./tuna.condarc /root/.condarc

RUN conda clean -i \
    && conda install python=3.8 -y \
    && conda install \
        numpy \
        pandas \
        matplotlib \
        seaborn \
        jupyter \
        ta-lib -y \
    && conda clean -a

RUN pip install https://github.com/fmzquant/backtest_python/archive/master.zip

## add fmz-robot executables

RUN mkdir -p /opt/fmz_robot \
    && curl -SLk https://www.fmz.cn/dist/robot_linux_amd64.tar.gz \
    | tar -zxvC /opt/fmz_robot

ENV PATH=/opt/fmz_robot:${PATH}

## copy examples into root

COPY ./examples /

## create /workspace as default workdir

WORKDIR /workspace
