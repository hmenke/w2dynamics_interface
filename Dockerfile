# See ../triqs/packaging for other options
FROM flatironinstitute/triqs:master-ubuntu-clang

RUN apt-get install -y libnfft3-dev || yum install -y nfft-devel
RUN apt-get install -y python-configobj || yum install -y python-configobj

ARG APPNAME=w2dynamics_interface
COPY . $SRC/$APPNAME
WORKDIR $BUILD/$APPNAME
RUN chown build .
USER build
ARG BUILD_DOC=0
RUN cmake $SRC/$APPNAME -DTRIQS_ROOT=${INSTALL} -DBuild_Documentation=${BUILD_DOC} && make -j1 && make test CTEST_OUTPUT_ON_FAILURE=1
USER root
RUN make install
