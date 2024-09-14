FROM gitpod/workspace-full:latest

USER gitpod

RUN bash -c ". /home/gitpod/.sdkman/bin/sdkman-init.sh && \
    sdk install java 17.0.12.fx-zulu && \
    sdk default java 17.0.12.fx-zulu"

RUN echo $JAVA_HOME 

### Java ###
## Place '.gradle' and 'm2-repository' in /workspace because (1) that's a fast volume, (2) it survives workspace-restarts and (3) it can be warmed-up by pre-builds.
# RUN bash -c "mkdir /home/gitpod/.m2 \
#              && printf '<settings>\n  <localRepository>/workspace/m2-repository/</localRepository>\n</settings>\n' > /home/gitpod/.m2/settings.xml"


# ENV JAVA_DIST="https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.9%2B9/OpenJDK17U-jdk_x64_linux_hotspot_17.0.9_9.tar.gz" 

USER root

# RUN wget -q -O /tmp/jdk.tar.gz $JAVA_DIST && \
#   cd /usr/local && \
#   tar -xzvf /tmp/jdk.tar.gz && \
#   rm -rf /tmp/jdk.tar.gz

# ENV JAVA_HOME=/usr/local/jdk-17.0.9+9
# ENV PATH=$JAVA_HOME/bin:$PATH

# maven
# ENV MVN_DIST=https://dlcdn.apache.org/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.tar.gz

# RUN wget -q -O /tmp/maven.tar.gz $MVN_DIST
#  && \
#     cd /usr/local && \
#     tar -xvzf /tmp/maven.tar.gz && \
#     rm -rf /tmp/maven.tar.gz

# ENV PATH=/usr/local/apache-maven-3.9.9/bin:$PATH

# docker
# RUN curl -o /var/lib/apt/dazzle-marks/docker.gpg -fsSL https://download.docker.com/linux/ubuntu/gpg \
#     && apt-key add /var/lib/apt/dazzle-marks/docker.gpg \
#     && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
#     && install-packages docker-ce containerd.io

# RUN curl -o /usr/bin/slirp4netns -fsSL https://github.com/rootless-containers/slirp4netns/releases/download/v1.1.12/slirp4netns-$(uname -m) \
#     && chmod +x /usr/bin/slirp4netns

# Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# postgres CLI
RUN install-packages postgresql-client

# Wildfly  (https://github.com/jboss-dockerfiles/wildfly/blob/master/Dockerfile)
ENV WILDFLY_VERSION 33.0.1.Final
ENV JBOSS_HOME /opt/jboss/wildfly
ENV DEPLOYMENT_DIR /workspace/deployments
ENV WILDFLY_SHA1 943ec801bf65bb42de27ef78c85d325180dcab0d
ENV LAUNCH_JBOSS_IN_BACKGROUND true

RUN mkdir -p ${JBOSS_HOME}

RUN wget -O /tmp/postgresql.jar https://jdbc.postgresql.org/download/postgresql-42.2.24.jar
COPY ./setup /tmp/
ENV SETUP_DIR /tmp

RUN cd $HOME \
    && curl -L -O https://github.com/wildfly/wildfly/releases/download/${WILDFLY_VERSION}/wildfly-${WILDFLY_VERSION}.tar.gz \
    && sha1sum wildfly-${WILDFLY_VERSION}.tar.gz | grep $WILDFLY_SHA1 \
    && tar xf wildfly-${WILDFLY_VERSION}.tar.gz \
    && mv $HOME/wildfly-${WILDFLY_VERSION}/ $JBOSS_HOME \
    && rm wildfly-${WILDFLY_VERSION}.tar.gz

RUN cat ${SETUP_DIR}/jboss-cli-docker.cli ${SETUP_DIR}/jboss-cli-commands.cli > ${SETUP_DIR}/config.cli
RUN cat ${SETUP_DIR}/config.cli

ENV JBOSS_HOME /opt/jboss/wildfly/wildfly-${WILDFLY_VERSION}

RUN chown -R gitpod:0 ${JBOSS_HOME} \
    && chmod -R g+rw ${JBOSS_HOME}

USER gitpod

# RUN $JBOSS_HOME/bin/jboss-cli.sh --echo-command --file=${SETUP_DIR}/config.cli

# RUN rm -rf $JBOSS_HOME/standalone/configuration/standalone_xml_history