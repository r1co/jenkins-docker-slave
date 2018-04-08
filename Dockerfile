FROM openjdk:8-jdk

RUN apt-get update && apt-get install -y openssh-server   && rm -rf /var/lib/apt/lists/*

RUN mkdir /var/run/sshd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

RUN useradd -ms /bin/bash slave
#USER slave
#WORKDIR /home/slave

ADD start.sh /usr/bin/start-slave
RUN chmod +x /usr/bin/start-slave

EXPOSE 22
CMD /usr/bin/start-slave
