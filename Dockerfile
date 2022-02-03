FROM fedora:34 
# install dependencies
RUN dnf -y update && dnf -y install make cmake automake gcc-c++ gcc zip gdb

#WORKDIR /Team05

#ADD ./entrypoint.sh /Team05 

#ENTRYPOINT ["/Team05/entrypoint.sh"]

