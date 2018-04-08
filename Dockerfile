FROM openjdk:8-jdk

USER root

RUN apt-get update && apt-get install -y nano  libxml-xpath-perl openssh-server sudo ruby-dev rubygems rsync zip  libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1 gcc build-essential make   libcairo2-dev libjpeg62-turbo-dev libpango1.0-dev libgif-dev build-essential g++ imagemagick graphicsmagick  && rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash jenkins
USER jenkins
WORKDIR /home/jenkins

# env for scripts
env PATH /var/jenkins_home/scripts:$PATH

# install node stuff
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs

RUN npm install -g bower
RUN npm install -g grunt-cli
RUN npm install -g n
RUN npm install -g yarn
RUN npm install -g webpack
RUN npm install -g ionic cordova
RUN npm install -g mocha mochawesome
RUN npm install -g brunch
RUN gem update --system
RUN gem install compass

# allow jenkins to use n
RUN echo "jenkins ALL = (root) NOPASSWD: /usr/bin/n" >> /etc/sudoers
RUN echo "jenkins ALL = (root) NOPASSWD: /usr/local/bin/npm" >> /etc/sudoers
RUN echo "jenkins ALL = (root) NOPASSWD: /usr/bin/apt" >> /etc/sudoers

# install mvn 3.5.0
WORKDIR /opt
RUN wget http://apache.mirror.iphh.net//maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.zip
RUN unzip apache-maven-3.5.2-bin.zip
RUN ln -s /opt/apache-maven-3.5.2/bin/mvn /usr/bin/

# install gradle
RUN mkdir /opt/gradle
RUN cd /tmp && wget https://services.gradle.org/distributions/gradle-4.0-bin.zip
RUN cd /tmp  && unzip -d /opt/gradle gradle-4.0-bin.zip
RUN ls /opt/gradle/gradle-4.0


USER jenkins
WORKDIR /home/jenkins
