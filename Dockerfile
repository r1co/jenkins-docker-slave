FROM openjdk:8-jdk


RUN useradd -ms /bin/bash jenkins
USER jenkins
WORKDIR /home/jenkins

