# Aspect Docker images based on MPICH for shifter

### Overview

This repository contains Dockerfiles for ASPECT using an MPICH-based dealii.

This allows ASPECT to run via shifter on HPC systems (specifically PAWSEY/Magnus).  The MPICH-based dealii image is built on the dockerfiles available here:  https://github.com/dansand/docker-files.git

### Docker

To download the image run:

`docker pull dansand/aspect`

To launch a container use:

`docker run --rm -it -v "$(pwd):/home/models" dansand/aspect  bash`

Docker help provides a brief description of these flags:

```
$ docker help run
Usage:	docker run [OPTIONS] IMAGE [COMMAND] [ARG...]

Run a command in a new container

  -i, --interactive=false         Keep STDIN open even if not attached
  --rm=false                      Automatically remove the container when it exits
  -t, --tty=false                 Allocate a pseudo-TTY
  -v, --volume=[]                 Bind mount a volume
```

`-v  "$(pwd):/home/models"` links the current working directory (where the container is launched from) to `home/models` on the container, where our user docker can write to.

The `bash` command at the end of the Docker run is optional, as this is also the default command specified in the image.

The Aspect binary is in the container PATH, so you will be able to run a model using something like. Assuming the container was launched from your local copy of this github repository, you could run

`aspect test_model/convection-box.prm`

Or to run on N processors:

`mpirun -np N test_model/convection-box.prm`

### Shifter (HPC)


There are two steps involved in running the Aspect Docker images on Magnus. First you need access to the image.

To check whether the image already exists in your Project run:

```
module load shifter
shifter images       #lists available images
```
If the image `dansand/aspect` is already downloaded, you will see it in the list of images.

If not download the image from dockerhub:

```
module load shifter
shifter pull dansand/aspect
```

(if this command fails for some reason, be sure you have enough space in your portion of the Group directory).

Then launch a normal slurm jobscript that runs the image. Assuming you have cloned this github repository onto your account at MAGNUS you could run:

```
cd aspect_docker
sbatch magnus_sample_scipt.pbs
```

The example slurm jobscript (magnus_sample_scipt.pbs) will call the Aspect input file `model_input/convection-box.prm`, which is taken from the ASPECT cookbooks.
