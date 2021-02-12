VERSION=${1}
LIBPATH=${2}

if [ -z "${VERSION}" ]; then
  VERSION="1.7.1"
fi

if [ -z "${LIBPATH}" ]; then
  LIBPATH="../../libs"
fi

cd ${LIBPATH} || exit
wget https://download.pytorch.org/libtorch/cpu/libtorch-cxx11-abi-shared-with-deps-${VERSION}%2Bcpu.zip
unzip libtorch-cxx11-abi-shared-with-deps-${VERSION}+cpu.zip

if [ "$(id -u)" -eq "0" ]; then
  chmod -R a+rwx libtorch
fi

rm libtorch-cxx11-abi-shared-with-deps-${VERSION}+cpu.zip
