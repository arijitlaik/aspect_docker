FROM dealii/dealii:v8.5.1-gcc-mpi-fulldepscandi-debugrelease


LABEL maintainer <dan.sandiford@utas.edu.au>

# Build aspect
RUN git clone https://github.com/ane-glerum/aspect.git ./aspect && \
    git checkout obliqe_mor && \
    mkdir aspect/build-release && \
    cd aspect/build-release && \
    cmake -DCMAKE_BUILD_TYPE=Release \
          -DDEAL_II_DIR=$HOME/deal.II-install \
          .. && \
    make -j2 && \
    mv aspect ../aspect-release && \
    make clean

ENV ASPECT_DIR /home/dealii/aspect/build-debug

WORKDIR /home/dealii/aspect
