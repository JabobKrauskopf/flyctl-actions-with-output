#!/bin/sh -l

# Most of this file has been copied from https://github.com/superfly/flyctl-actions/blob/master/LICENSE

if [ -n "$FLY_PROJECT_PATH" ]; then
  PREV_PATH=$(pwd)
  # Allow user to change directories in which to run Fly commands
  cd "$FLY_PROJECT_PATH" || exit
fi
sh -c "flyctl $*"

exec 5>&1
STDOUT=$(sh -c "flyctl $*"|tee >(cat - >&5))
STDOUT="${STDOUT//'%'/'%25'}"
STDOUT="${STDOUT//$'\n'/'%0A'}"
STDOUT="${STDOUT//$'\r'/'%0D'}"

echo ::set-output name=stdout::$STDOUT

ACTUAL_EXIT="$?"

if [ -n "$PREV_PATH" ]; then
  # If we changed directories before, we should go back to where we were.
  cd "$PREV_PATH" || exit
fi

exit $ACTUAL_EXIT
