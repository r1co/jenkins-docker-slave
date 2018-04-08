FROM ubuntu

RUN apt-get update && apt-get install -y openssh-server   && rm -rf /var/lib/apt/lists/*


RUN useradd slave -ms /bin/bash slave

USER slave
WORKDIR /home/slave


EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]