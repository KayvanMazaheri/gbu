#!/bin/bash

main() {
  # Use colors, but only if connected to a terminal, and that terminal
  # supports them.
  if which tput >/dev/null 2>&1; then
      ncolors=$(tput colors)
  fi
  if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    BOLD="$(tput bold)"
    NORMAL="$(tput sgr0)"
  else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    NORMAL=""
  fi

  # Only enable exit-on-error after the non-critical colorization stuff,
  # which may fail on systems lacking tput or terminfo
  set -e

  printf "${BLUE}Cloning GBU...${NORMAL}\n"
  hash git >/dev/null 2>&1 || {
    echo "Error: git is not installed"
    exit 1
  }
  # The Windows (MSYS) Git is not compatible with normal use on cygwin
  if [ "$OSTYPE" = cygwin ]; then
    if git --version | grep msysgit > /dev/null; then
      echo "Error: Windows/MSYS Git is not supported on Cygwin"
      echo "Error: Make sure the Cygwin git package is installed and is first on the path"
      exit 1
    fi
  fi

  # Create a temp dir and clone the gbu repository into it
  TEMP_DIRECTORY=`mktemp -d 2>/dev/null || mktemp -d -t 'gbu.repo'`
  env git clone --depth=1 https://github.com/KayvanMazaheri/gbu.git $TEMP_DIRECTORY || {
    printf "Error: git clone of gbu repo failed\n"
    exit 1
  }

  # Add GBU to global list of commands
  DEST_DIRECTORY='/usr/local/bin/'
  GBU_EXEC=$TEMP_DIRECTORY/gbu.sh
  echo 'Copying GBU into' $DEST_DIRECTORY
  sudo cp $GBU_EXEC $DEST_DIRECTORY/gbu
  rm -rdf $TEMP_DIRECTORY

  printf "${GREEN}"
  echo '                                                                   '
  echo '        _____              ______  ______         ______   _____   '
  echo '   _____\    \_           \     \|\     \       \     \  \    \    '
  echo '  /     /|     |           |     |\|     |       \    |  |    |    '
  echo ' /     / /____/|           |     |/____ /         |   |  |    |    '
  echo '|     | |_____|/           |     |\     \         |    \_/   /|    '
  echo '|     | |_________         |     | |     |        |\         \|    '
  echo '|\     \|\        \        |     | |     |        | \         \__  '
  echo '| \_____\|    |\__/|      /_____/|/_____/|         \ \_____/\    \ '
  echo '| |     /____/| | ||      |    |||     | |          \ |    |/___/| '
  echo ' \|_____|     |\|_|/      |____|/|_____|/            \|____|   | | '
  echo '        |____/                                              |___|/  '
  echo '                                                                     ....is now installed!'
  echo ''
  echo ''
  echo 'You can run it by typing gbu in any directory.'
  echo ''
  echo 'p.s. Please star the project on GitHub if it helped you or you liked it.'
  echo ''
  echo 'https://github.com/KayvanMazaheri/gbu'
  echo ''
  printf "${NORMAL}"
  
}

main