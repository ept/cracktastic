#!/bin/sh

# This script bootstraps the demo project, creating it from scratch using
# Rails generators. To run it, you must have a git clone of the invoicing-demo
# repository, and you must be currently at the head of the master branch.
# Then type:
#   ./setup.sh
#
# To see what's going on, simply run the commands one by one and review the
# results.

# Create a new git branch to which we will commit the auto-generated webapp
git checkout -b generated

# Generate skeleton
rails --database=mysql .
