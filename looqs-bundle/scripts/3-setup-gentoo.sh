#!/bin/bash
# Run me inside gentoo
set -e
mkdir --parents /etc/portage/repos.conf
cp /usr/share/portage/config/repos.conf /etc/portage/repos.conf/gentoo.conf
emerge-webrsync

echo 'USE="X vulkan jpeg png icu cairo -accessibility -debug -dbus"' >> /etc/portage/make.conf
emerge -v --update --newuse --deep @world

emerge -av gentoo-sources
emerge -v dev-util/patchelf

emerge -v qtcore qtgui uchardet
emerge -v qtwidgets qtsql qtnetwork qtconcurrent
emerge -v qtsvg
export USE="minizip qt5"
emerge -v app-text/poppler
emerge -v dev-libs/quazip
emerge -v dev-vcs/git
emerge -v qtchooser
useradd -m -s /bin/bash builder