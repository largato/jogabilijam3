#! /bin/bash
cd /tmp
git clone https://aur.archlinux.org/dpkg.git
cd dpkg
yes | makepkg -s
yes | sudo pacman -U dpkg-1.18.25-1-x86_64.pkg.tar.xz
cd /jogabilijam3

