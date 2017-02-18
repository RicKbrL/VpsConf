#!/bin/bash
echo "#!/bin/bash
if [ "'$1'" == start ]
then
badvpn-udpgw --listen-addr 127.0.0.1:7300 > /dev/null &
echo 'Badvpn rodando na porta 7300'
fi
if [ "'$1'" == stop ]
then
badvpnpid="'$(ps x |grep badvpn |grep -v grep |awk '"{'"'print $1'"'})
killall badvpn-udpgw"' >/dev/null 2>/dev/null'"
fi" > /bin/badvpn
chmod +x /bin/badvpn
if [ -f /usr/local/bin/badvpn-udpgw ]; then
echo -e "\033[1;32mBadvpn ja esta instalado\033[0m"
else
clear
fi
echo -e "\033[1;31m           Instalador Badvpn\n\033[1;37mInstalando gcc Cmake make g++ openssl e wget..."
yum update -y >/dev/null 2>/dev/null
yum install -y openssl > /dev/null 2>/dev/null
yum install -y gcc >/dev/null 2>/dev/null
yum install -y g++ >/dev/null 2>/dev/null
yum install -y make >/dev/null 2>/dev/null
yum install -y build-essential >/dev/null 2>/dev/null
apt-get update 1> /dev/null 2>/dev/null
apt-get install -y gcc >/dev/null 2>/dev/null
apt-get install -y make >/dev/null 2>/dev/null
apt-get install -y g++ >/dev/null 2>/dev/null
apt-get install -y openssl >/dev/null 2>/dev/null
apt-get install -y build-essential >/dev/null 2>/dev/null
cd
wget http://www.cmake.org/files/v2.8/cmake-2.8.3.tar.gz -o /dev/null
tar -xf cmake-2.8.3.tar.gz
cd cmake-2.8.3/
./configure --prefix=/usr/
make
make install
cd ; rm -rf cmake-2.8.3.tar.gz cmake-2.8.3 >/dev/null 2>/dev/null
echo -e "Fazendo download do Badvpn"
wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/badvpn/badvpn-1.999.128.tar.bz2 -o /dev/null
echo -e "Descompactando Badvpn"
tar -xf badvpn-1.999.128.tar.bz2
echo -e "Iniciando configurações"
mkdir /etc/badvpn-install
cd /etc/badvpn-install
cmake ~/badvpn-1.999.128 -DBUILD_NOTHING_BY_DEFAULT=1 -DBUILD_UDPGW=1 >/dev/null 2>/dev/null
echo -e "Compilando badvpn\033[0m"
make install
clear
echo -e "\033[1;32m             Instalação completa\033[0m" 
echo -e "\033[1;37mComandos:\n\033[1;31mbadvpn start\033[1;37m para iniciar o badvpn"
echo -e "\033[1;31mbadvpn stop \033[1;37m para parar o badvpn\033[0m"
rm -rf /etc/badvpn-install
cd ; rm -rf badvpn.sh badvpn-1.999.128/ badvpn-1.999.128.tar.bz2 >/dev/null 2>/dev/null
