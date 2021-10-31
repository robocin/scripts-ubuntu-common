#!/bin/bash

if [ -z $(which codea) ]; then
	echo -e "\x1B[31m[ERROR] This script requires Visual Studio Code installed.\n"
	echo -e "\033[0mYou can install using snap with the following command:\n"
  echo -e "\x1B[01;93m   $ sudo snap install --classic code\n"
else
	# todo: static check
	# todo: new class template
	code --install-extension xaver.clang-format --force
	code --install-extension ms-vscode.cpptools --force
	code --install-extension ms-vscode.cpptools-extension-pack --force
	code --install-extension llvm-vs-code-extensions.vscode-clangd --force
	code --install-extension streetsidesoftware.code-spell-checker --force
	code --install-extension eamodio.gitlens --force
fi