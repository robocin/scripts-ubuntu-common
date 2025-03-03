#!/bin/bash






if [ -z "$(which code)" ]; then


  echo -e "\x1B[31m[ERROR] This script requires Visual Studio Code installed.\n"


  echo -e "\033[0mYou can install using snap with the following command:\n"


  echo -e "\x1B[01;93m   $ snap install --classic code\n"


else


  code --install-extension xaver.clang-format --force


  code --install-extension ms-vscode.cpptools --force


  code --install-extension ms-vscode.cpptools-extension-pack --force


  code --install-extension llvm-vs-code-extensions.vscode-clangd --force


  code --install-extension streetsidesoftware.code-spell-checker --force


  code --install-extension eamodio.gitlens --force


  code --install-extension wayou.vscode-todo-highlight --force


  code --install-extension cschlosser.doxdocgen --force


  code --install-extension akiramiyakoda.cppincludeguard --force


  code --install-extension tdennis4496.cmantic --force


  code --install-extension tonka3000.qtvsctools --force


  code --install-extension zxh404.vscode-proto3 --force


  # todo: new class template


  # todo: static check


fi
