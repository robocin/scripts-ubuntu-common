#!/bin/bash

# PS: this script assumes a 64-bit Linux Ubuntu system with pip3 installed.

# install "C/C++" vs code extension
wget https://github.com/microsoft/vscode-cpptools/releases/download/1.2.1/cpptools-linux.vsix
code --install-extension cpptools-linux.vsix
rm cpptools-linux.vsix
# PS: if this is not working, check if the default formatter is set to "C/C++" by doing a right click > "format document with..." > "C/C++"

# install "C/C++ Advanced Lint" vs code extension
apt-get install clang cppcheck -y
pip3 install flawfinder
pip3 install lizard
wget https://github.com/jbenden/vscode-c-cpp-flylint/releases/download/v1.8.2/c-cpp-flylint-1.8.2.vsix
code --install-extension c-cpp-flylint-1.8.2.vsix
rm c-cpp-flylint-1.8.2.vsix

# install "Open in External App" vs code extension
wget https://github.com/tjx666/open-in-external-app/releases/download/V0.1.0/open-in-external-app-0.1.0.vsix
code --install-extension open-in-external-app-0.1.0.vsix
rm open-in-external-app-0.1.0.vsix

echo "

	Done!

	To enable automatic formatting on save:
	1 - right click on the code > 'format document with...' > 'C/C++'.
	2 - inside vs code options, search for 'format on save' and make sure the checkbox is enabled.

	Happy Coding!

"
