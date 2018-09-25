#!/bin/bash

# find all modified in last 30 days and zip it
tar czvf 30days.tgz `find . -mtime -30 -type f`
