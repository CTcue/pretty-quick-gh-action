#!/bin/sh
# e is for exiting the script automatically if a command fails, u is for exiting if a variable is not set
# x would be for showing the commands before they are executed
set -eu

# PROGRAM
echo "Installing prettier..."
if [ -z "$INPUT_PRETTIER_VERSION" ]; then
  npm install --silent --global prettier
else
  npm install --silent --global prettier@$INPUT_PRETTIER_VERSION
fi

echo "Installing pretty-quick..."
if [ -z "$INPUT_PRETTY_QUICK_VERSION" ]; then
  npm install --silent --global pretty-quick
else
  npm install --silent --global pretty-quick@$INPUT_PRETTY_QUICK_VERSION
fi

cd $INPUT_ROOT
echo "Working directory: ${PWD}"

echo "Testing prettier"
pretty-quick $INPUT_PRETTY_QUICK_OPTIONS
