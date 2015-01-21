#!/bin/sh
#This command is really noisy, so piping to nowhere.
(Xvfb -ac :99 > /dev/null 2>&1) &
