FROM dealii/dealii:v8.5.1-gcc-mpi-fulldepscandi-debugrelease

LABEL maintainer <rene.gassmoeller@mailbox.org>

# Build aspect
RUN git clone https://github.com/dansand/aspect.git ./aspect && \
    mkdir aspect/build-release && \
    cd aspect/build-release && \
    cmake -DCMAKE_BUILD_TYPE=Release -DDEAL_II_DIR=$HOME/deal.II-install ..

RUN cd aspect/build-release && echo "$PWD"
RUN cd aspect/build-release && make
RUN cd aspect/build-release && mv aspect ../aspect-release && \
    make clean

ENV ASPECT_DIR /home/dealii/aspect/build-debug

WORKDIR /home/dealii/aspect
