#-#-#FROM tjhei/dealii:v9.0.1-full-v9.0.1-r4
#FROM alexisespinosa/dealii:v9.1.0-pre-gcc-mpichpawsey-fulldepsmanual
FROM dansand/dealii:v9.1.0-pre-gcc-mpichpawsey-fulldepsmanual

#-#-#LABEL maintainer <dan.sandiford@utas.edu.au>

ARG SOFTDIR=/software
WORKDIR $SOFTDIR

# Build aspect
RUN git clone https://github.com/geodynamics/aspect.git ./aspect && \
    cd aspect && git checkout master && \
    mkdir build-release && \
    cd build-release && \
    cmake -DCMAKE_BUILD_TYPE=Release \
#-#-#          -DDEAL_II_DIR=$HOME/deal.II-install \
#::AEG::Installing in $SOFTDIR instead of $HOME
          -DDEAL_II_DIR=$SOFTDIR/deal.II-install \
          .. && \
    make -j4 && \
    mv aspect ../aspect && \
    make clean



#-#-#ENV ASPECT_DIR /home/dealii/aspect/build-debug
#::AEG:: Same thing
ENV ASPECT_DIR $SOFTDIR/aspect/build-debug

ENV PATH "$PATH:/software/aspect"

WORKDIR /home/models
