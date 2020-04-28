#!/bin/sh
# e is for exiting the script automatically if a command fails, u is for exiting if a variable is not set
# x would be for showing the commands before they are executed
set -eu

# PROGRAM
echo "Installing prettier..."
if "$INPUT_PRETTIER_VERSION"; then
  npm install --silent --global prettier@$INPUT_PRETTIER_VERSION
else
  npm install --silent --global prettier
fi
echo "Installing pretty-quick..."
if "$INPUT_PRETTIER_VERSION"; then
  npm install --silent --global pretty-quick@$INPUT_PRETTY_QUICK_VERSION
else
  npm install --silent --global pretty-quick
fi

cd $INPUT_ROOT
echo "Working directory: ${INPUT_ROOT}"

echo "Prettifing files..."
pretty-quick $INPUT_PRETTY_QUICK_OPTIONS
