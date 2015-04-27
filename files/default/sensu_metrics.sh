#!/bin/bash
SENSU_PATH="/opt/sensu-community-plugins"
NETCAT="/bin/nc -q0 -t 127.0.0.1 6008"
CLEAN_OUTPUT="grep ."
SENSU_SCRIPT=$1

shift

if [[ $SENSU_SCRIPT == *".rb" ]]; then
  if [ -a /usr/local/rvm/scripts/rvm ]; then
    . /usr/local/rvm/scripts/rvm
    rvm use system 1> /dev/null
  fi

  # grep is used to remove an empty line emitted after every script runs.
  # It leads to a crash of logstash.
  $SENSU_PATH/embedded/bin/ruby $SENSU_PATH/plugins/$SENSU_SCRIPT $@ | $CLEAN_OUTPUT | $NETCAT
else
  $SENSU_PATH/plugins/$SENSU_SCRIPT | $CLEAN_OUTPUT | $NETCAT
fi
