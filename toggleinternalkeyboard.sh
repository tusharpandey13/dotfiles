#!/bin/bash
#/home/me/bin/toggle-keyboard

kb_name='AT Translated Set 2 keyboard'

if xinput list "$kb_name" | grep -i --quiet disable; then
	xinput enable "$kb_name"
	echo "Internal keyboard is now enabled"
else
	xinput disable "$kb_name"
	echo "Internal keyboard is now disabled"
fi
