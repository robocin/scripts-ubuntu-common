#!/bin/bash

sudo apt-get install clangd-12 -y

sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-12 100
