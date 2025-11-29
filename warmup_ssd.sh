#!/bin/bash

# should run on ssds once per 6 months to prevent loss of the data
sudo dd if=/dev/sda of=/dev/null status=progress
