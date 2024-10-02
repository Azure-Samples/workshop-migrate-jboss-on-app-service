FROM gitpod/workspace-full:latest

RUN bash -c ". /home/gitpod/.sdkman/bin/sdkman-init.sh && \
    sdk install java 17.0.12-tem && \
    sdk default java 17.0.12-tem"

USER root

# Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# postgres CLI
RUN install-packages postgresql-client

# Wildfly  (https://github.com/jboss-dockerfiles/wildfly/blob/master/Dockerfile)
ENV WILDFLY_VERSION 33.0.1.Final
# ENV WILDFLY_VERSION 25.0.0.Final
ENV JBOSS_HOME /opt/jboss/wildfly
ENV DEPLOYMENT_DIR /workspace/deployments
ENV WILDFLY_SHA1 943ec801bf65bb42de27ef78c85d325180dcab0d
# ENV WILDFLY_SHA1 238e67f48f1bd1e79f2d845cba9194dcd54b4d89
ENV LAUNCH_JBOSS_IN_BACKGROUND true

RUN mkdir -p ${JBOSS_HOME}

ENV SETUP_DIR /workspace/workshop-migrate-jboss-on-app-service/setup

RUN cd $HOME \
    && curl -L -O https://github.com/wildfly/wildfly/releases/download/${WILDFLY_VERSION}/wildfly-${WILDFLY_VERSION}.tar.gz \
    && sha1sum wildfly-${WILDFLY_VERSION}.tar.gz | grep $WILDFLY_SHA1 \
    && tar xf wildfly-${WILDFLY_VERSION}.tar.gz \
    && mv $HOME/wildfly-${WILDFLY_VERSION}/ $JBOSS_HOME \
    && rm wildfly-${WILDFLY_VERSION}.tar.gz

ENV JBOSS_HOME /opt/jboss/wildfly/wildfly-${WILDFLY_VERSION}

RUN chown -R gitpod:0 ${JBOSS_HOME} \
    && chmod -R g+rw ${JBOSS_HOME}

USER gitpod
