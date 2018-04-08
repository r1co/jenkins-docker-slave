FROM ubuntu

RUN apt-get update && apt-get install openssh-server 

RUN slave -ms /bin/bash slave

USER slave
WORKDIR /home/slave


EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]