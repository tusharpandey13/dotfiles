#!/bin/bash
ps cax | grep screenkey > /dev/null
if [ $? -eq 0 ]; then
	pkill screenkey
else
	screenkey
fi
