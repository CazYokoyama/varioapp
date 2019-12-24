# varioapp
This is the copy of http://git-ro.openvario.org/varioapp.git. As its URL indicates, this is a daemon of openvario which receives
sensor information include static pressure, dynamic pressure, i.e. pitot pressure and Total energy pressure.In addition, it also
receive power voltage.
It drives a speaker as a audio vario from total energy pressure. 
In Armbian,
# pick armbian branch
make
sudo make install
sudo systemctl enable variod
