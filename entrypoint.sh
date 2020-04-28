#!/bin/sh
# e is for exiting the script automatically if a command fails, u is for exiting if a variable is not set
# x would be for showing the commands before they are executed
set -eu

# FUNCTIONS
# Function for setting up git env in the docker container (copied from https://github.com/stefanzweifel/git-auto-commit-action/blob/master/entrypoint.sh)
_git_setup ( ) {
    cat <<- EOF > $HOME/.netrc
      machine github.com
      login $GITHUB_ACTOR
      password $GITHUB_TOKEN
      machine api.github.com
      login $GITHUB_ACTOR
      password $GITHUB_TOKEN
EOF
    chmod 600 $HOME/.netrc

    git config --global user.email "actions@github.com"
    git config --global user.name "GitHub Action"
}

# Checks if any files are changed
_git_changed() {
    [[ -n "$(git status -s)" ]]
}

# Pushes to the according upstream (origin or input branch)
_git_push() {
    if [ -z "$INPUT_BRANCH" ]
    then
        git push origin
    else
        git push --set-upstream origin "HEAD:$INPUT_BRANCH"
    fi
}

cd $INPUT_ROOT

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

echo "Prettifing files..."
echo "Files:"
pretty-quick $INPUT_PRETTETTY_QUICK_OPTIONS || echo "Problem running prettier with $INPUT_PRETTIER_OPTIONS"

# To keep runtime good, just continue if something was changed
if _git_changed;
  echo "Prettier found unpretty files!"
  exit 1
else
  echo "Nothing to commit. Exiting."
fi
