FROM tjhei/dealii:v9.0.1-full-v9.0.1-r4

LABEL maintainer <dan.sandiford@utas.edu.au>

# Build aspect
RUN git clone https://github.com/geodynamics/aspect.git ./aspect && \
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
