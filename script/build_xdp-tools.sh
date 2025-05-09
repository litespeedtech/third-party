
cd `dirname "$0"`
cd ..
PREFIX=`pwd`
cd src


if [ ! -d "xdp-tools" ]; then
    git clone https://github.com/xdp-project/xdp-tools.git
fi
cd xdp-tools
./configure
make
if [ ! -d "../../include/bpf" ]; then
    mkdir "../../include/bpf"
fi
cp headers/xdp/* ../../include/
cp lib/libbpf/src/*.h ../../include/
cp lib/libbpf/src/root/include/bpf/* ../../include/bpf/
cp lib/libbpf/src/libbpf.a ../../lib/
cp lib/libxdp/libxdp.a ../../lib/
