#!/bin/bash

gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'de'), ('xkb', 'us')]"
gsettings set org.gnome.desktop.input-sources per-window false
gsettings set org.gnome.desktop.input-sources show-all-sources true
