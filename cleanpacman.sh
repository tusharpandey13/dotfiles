#!/bin/bash
pacman -Rns $(pacman -Qtdq)
reflector -f 10 -n 15 --sort rate --save /etc/pacman.d/mirrorlist
