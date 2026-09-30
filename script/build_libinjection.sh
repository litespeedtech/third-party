
cd `dirname "$0"`
cd ..
PREFIX=`pwd`

if [ -d ".git/modules/src/libinjection" ]; then

git submodule deinit -f src/libinjection
git rm -f src/libinjection
rm -rf .git/modules/src/libinjection

if 

cd src
if [ ! -d "libinjection" ]; then
    git clone https://github.com/libinjection/libinjection
fi
cd libinjection

git reset --hard
git checkout main
git checkout v4.0.0

./autogen.sh
CPPFLAGS="-I../../include -fPIC" ./configure --prefix=$PREFIX 
make install

