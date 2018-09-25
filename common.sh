#!/bin/bash

# find all modified in last 30 days and zip it
find . -mtime -30 | xargs tar --no-recursion -czf myfile.tgz
