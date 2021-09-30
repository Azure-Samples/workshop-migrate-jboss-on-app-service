#!/usr/bin/env bash

export SETUP_DIR=/home/site/libs
$JBOSS_HOME/bin/jboss-cli.sh --echo-command --connect --file=${SETUP_DIR}/jboss-cli-commands.cli

