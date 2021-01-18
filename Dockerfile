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

RUN echo "export PATH=$PATH" > /etc/environment

RUN apt install -y curl && \
        curl -sSL https://get.haskellstack.org/ | sh


COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/bin/bash"]
