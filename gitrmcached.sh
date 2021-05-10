#!/bin/bash

git rm --cached $(git status | grep deleted | sed 's#^.*:##')
