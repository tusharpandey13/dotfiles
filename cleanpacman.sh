#!/bin/bash
pacman -Rns $(pacman -Qtdq)
reflector --latest 200 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist
