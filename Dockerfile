FROM ubuntu:18.04

RUN echo "Updating Ubuntu"
RUN apt-get update --fix-missing && \
        apt-get upgrade -y && \
        apt-get install -y software-properties-common && \
        apt-get update --fix-missing

RUN echo "Installing dependencies..."
RUN apt install -y \
        git \
        x11-apps \
        gosu

RUN apt install -y \
        haskell-platform \
        haskell-stack

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/bin/bash"]
