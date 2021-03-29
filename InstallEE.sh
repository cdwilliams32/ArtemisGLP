#!/bin/bash
EE_BUILD_HOME=`pwd`
EE_BUILD_EE="${EE_BUILD_HOME}/EmptyEpsilon"
EE_BUILD_EE_LINUX="${EE_BUILD_EE}/_build_linux"

echo "Installing ${EE_BUILD_EE_LINUX}/EmptyEpsilon.deb"
sudo dpkg -i ${EE_BUILD_EE_LINUX}/EmptyEpsilon.deb

echo "Ensuring dependices are met"
sudo apt --fix-broken install -y

echo "Empty Epsilon installed. Run 'EmptyEpsilon'"