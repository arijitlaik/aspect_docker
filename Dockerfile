FROM pawsey/mpi-base
FROM dealii/dealii:v8.5.1-gcc-mpi-fulldepscandi-debugrelease


LABEL maintainer <dan.sandiford@utas.edu.au>

# Build aspect
RUN git clone https://github.com/geodynamics/aspect.git ./aspect && \
    mkdir aspect/build-release && \
    cd aspect/build-release && \
    cmake -DCMAKE_BUILD_TYPE=Release \
          -DDEAL_II_DIR=$HOME/deal.II-install \
          .. && \
    make -j2 && \
    mv aspect ../aspect && \
    make clean

ENV ASPECT_DIR /home/dealii/aspect/build-release

WORKDIR /home/dealii/aspect
