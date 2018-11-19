#!/bin/bash
alias dockerclean='docker rmi -f $(docker images | grep "<none>" | awk "{print \$3}")'

alias docker-tree='docker run --rm -v /var/run/docker.sock:/var/run/docker.sock nate/dockviz images -t'
