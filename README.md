# CS3203T05_Fedora_Docker
The docker setup for build and testing on fedora using cmake.

# Dependency
Install docker at https://docs.docker.com/get-docker/

# How to use
Suppose you have downloaded the [spa-cp.zip](https://github.com/nus-cs3203/project-wiki/raw/main/archive/spa-cp-2022-Jan-07.zip) and unzipped it at ./spa-cp. Copy Dockerfile and entrypoint.sh to ./spa-cp/Team00/

Your directory structure should be like
```
spa-cp/
  Team00/
    Code00/
    Tests00/
    Dockerfile
    entrypoint.sh
  README.md
  check-submission.py
```

Go into ./spa-cp/Team00/ folder, and run the following commands.
```bash
docker build . -t cs3203t05
docker run --rm -v $(pwd):/Team05 cs3203t05
```
The first command only needs to be run once when you just set up with docker. After you make changes to the code and wants to build and test the code on fedora, you just need to run the following command
```bash
docker run --rm -v $(pwd):/Team05 cs3203t05
```
