# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x

sh ceres.sh
sudo apt install -y libgoogle-glog-dev libopenblas-dev libtbb-dev #libboost-all-dev

echo "HACK TO GET AROUND CMAKE BUILD ERROR IN UBUNTU 16.04:"
echo "sudo ln -s /usr/lib/x86_64-linux-gnu/libglog.so /usr/local/lib/"
# sudo ln -s /usr/lib/x86_64-linux-gnu/libglog.so /usr/local/lib/

cd ~/src

if [ ! -d ~/src/camodocal ]
then
    git clone https://github.com/hengli/camodocal.git
fi

cd ~/src/camodocal
git pull

if [ ! -d build ]
then
    mkdir build
fi

cd build
cmake ..
make -j16 && sudo make install


cd $DIR
