FROM gitpod/workspace-full:latest

USER gitpod

# Install custom tools, runtime, etc.
RUN brew install az openjdk@11

ENV JAVA_HOME="/home/linuxbrew/.linuxbrew/opt/openjdk@11"
ENV PATH="$JAVA_HOME/bin:$PATH"

RUN wget -O /tmp/openjdk-11+28_linux-x64_bin.tar.gz https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_linux-x64_bin.tar.gz && rm -rf /home/gitpod/.sdkman/candidates/java/11.0.12.fx-zulu/* && cd /home/gitpod/.sdkman/candidates/java/11.0.12.fx-zulu/ && tar -xzvf /tmp/openjdk-11+28_linux-x64_bin.tar.gz && mv jdk-11/* . && rm -rf jdk-11/ /tmp/openjdk-11+28_linux-x64_bin.tar.gz 

RUN curl -Ls https://sh.jbang.dev | bash -s - app install --fresh --force quarkus@quarkusio
ENV PATH="$HOME/.jbang/bin:$PATH"
RUN quarkus completion > $HOME/.bash_completion

## Wildfly  (https://github.com/jboss-dockerfiles/wildfly/blob/master/Dockerfile)
ENV WILDFLY_VERSION 24.0.1.Final
ENV JBOSS_HOME /opt/jboss/wildfly
ENV WILDFLY_SHA1 751e3ff9128a6fbe72016552a9b864f729a710cc
ENV LAUNCH_JBOSS_IN_BACKGROUND true

USER root

RUN mkdir -p ${JBOSS_HOME}
RUN cd $HOME \
    && curl -O https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz \
    && sha1sum wildfly-$WILDFLY_VERSION.tar.gz | grep $WILDFLY_SHA1 \
    && tar xf wildfly-$WILDFLY_VERSION.tar.gz \
    && mv $HOME/wildfly-$WILDFLY_VERSION/* $JBOSS_HOME/ \
    && rm wildfly-$WILDFLY_VERSION.tar.gz \
    && chown -R gitpod:0 ${JBOSS_HOME} \
    && chmod -R g+rw ${JBOSS_HOME}

USER gitpod