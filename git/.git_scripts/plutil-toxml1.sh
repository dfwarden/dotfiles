#!/bin/bash

# TODO: Implement a way of ignoring certain keys we know change
#       all the time, like com.hegenberg.BerttTouchTool's BTTNumberOfStarts

plutil -convert xml1 -o - "$1"
