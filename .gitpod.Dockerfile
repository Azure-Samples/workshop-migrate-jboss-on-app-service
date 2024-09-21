FROM gitpod/workspace-full:latest

# USER gitpod

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

ENV JBOSS_HOME /opt/jboss/wildfly/wildfly-${WILDFLY_VERSION}

RUN chown -R gitpod:0 ${JBOSS_HOME} \
    && chmod -R g+rw ${JBOSS_HOME}

USER gitpod
