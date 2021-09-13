FROM mcr.microsoft.com/vscode/devcontainers/java:11

# Install Maven
ARG INSTALL_MAVEN="true"
ARG MAVEN_VERSION=3.6.3
RUN if [ "${INSTALL_MAVEN}" = "true" ]; then su vscode -c "source /usr/local/sdkman/bin/sdkman-init.sh && sdk install maven \"${MAVEN_VERSION}\""; fi \
    && if [ "${INSTALL_GRADLE}" = "true" ]; then su vscode -c "source /usr/local/sdkman/bin/sdkman-init.sh && sdk install gradle \"${GRADLE_VERSION}\""; fi

# Install a version of Node.js using nvm for front end dev
ARG INSTALL_NODE="true"
ARG NODE_VERSION="lts/*"
RUN if [ "${INSTALL_NODE}" = "true" ]; then su vscode -c "source /usr/local/share/nvm/nvm.sh && nvm install ${NODE_VERSION} 2>&1"; fi

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>

# [Optional] Uncomment this line to install global node packages.
# RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && npm install -g <your-package-here>" 2>&1

# Install dev tools
## Azure cli
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
RUN sudo apt-get update
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

## Wildfly  (https://github.com/jboss-dockerfiles/wildfly/blob/master/Dockerfile)
ENV WILDFLY_VERSION 24.0.1.Final
ENV JBOSS_HOME /opt/jboss/wildfly
ENV WILDFLY_SHA1 751e3ff9128a6fbe72016552a9b864f729a710cc
ENV LAUNCH_JBOSS_IN_BACKGROUND true

USER root

# RUN mkdir -p ${JBOSS_HOME}
# RUN cd $HOME \
#     && curl -O https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz \
#     && sha1sum wildfly-$WILDFLY_VERSION.tar.gz | grep $WILDFLY_SHA1 \
#     && tar xf wildfly-$WILDFLY_VERSION.tar.gz \
#     && mv $HOME/wildfly-$WILDFLY_VERSION $JBOSS_HOME \
#     && rm wildfly-$WILDFLY_VERSION.tar.gz \
#     && chown -R vscode:0 ${JBOSS_HOME} \
#     && chmod -R g+rw ${JBOSS_HOME}

USER vscode

## psql
RUN sudo apt-get update && sudo apt-get -y install postgresql-client

# Set the default command to run on boot
# This will boot WildFly in standalone mode and bind to all interfaces
# CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0"]
CMD [ "sleep", "infinity" ]