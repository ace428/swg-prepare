#!/bin/bash

#Install the dependencies
apt-get install alien autoconf automake autotools-dev binutils build-essential bzip2 elfutils expat g++ g++-multilib gawk gcc gcc-multilib ksh less lib32ncurses5 lib32z1 libaio-dev libc6 libc6-dev libc6-dev-i386 libc6-i386 libelf-dev libltdl-dev libmotif-common libmrm4 libmrm4:i386 libodbcinstq4-1 libpth-dev libpthread-stubs0-dev libstdc++5 libuil4 libuil4:i386 libxm4 libxm4:i386 rlwrap rpm sysstat unixodbc unixodbc-dev unzip zenity zlibc -y

#Setup groups and an oracle user
groupadd oinstall
groupadd dba
groupadd oper
groupadd nobody
groupadd asmadmin
useradd -g oinstall -G dba,asmadmin,oper -s /bin/bash -m oracle
echo "oracle:swg" | chpasswd

#Edit Parameters
echo '#### Oracle Kernel Parameters ####' | tee -a /etc/sysctl.conf
echo 'fs.suid_dumpable = 1' | tee -a /etc/sysctl.conf
echo 'fs.aio-max-nr = 1048576' | tee -a /etc/sysctl.conf
echo 'fs.file-max = 6815744' | tee -a /etc/sysctl.conf
echo 'kernel.shmall = 818227' | tee -a /etc/sysctl.conf
echo 'kernel.shmmax = 4189323264' | tee -a /etc/sysctl.conf
echo 'kernel.shmmni = 4096' | tee -a /etc/sysctl.conf
echo 'kernel.panic_on_oops = 1' | tee -a /etc/sysctl.conf
echo 'kernel.sem = 250 32000 100 128' | tee -a /etc/sysctl.conf
echo 'net.ipv4.ip_local_port_range = 9000 65500' | tee -a /etc/sysctl.conf
echo 'net.core.rmem_default=262144' | tee -a /etc/sysctl.conf
echo 'net.core.rmem_max=4194304' | tee -a /etc/sysctl.conf
echo 'net.core.wmem_default=262144' | tee -a /etc/sysctl.conf
echo 'net.core.wmem_max=1048576' | tee -a /etc/sysctl.conf

echo '#### Oracle User Settings ####' | tee -a /etc/security/limits.conf
echo 'oracle       soft  nproc  2047' | tee -a /etc/security/limits.conf
echo 'oracle       hard  nproc  16384' | tee -a /etc/security/limits.conf
echo 'oracle       soft  nofile 1024' | tee -a /etc/security/limits.conf
echo 'oracle       hard  nofile 65536' | tee -a /etc/security/limits.conf
echo 'oracle       soft  stack  10240' | tee -a /etc/security/limits.conf

/sbin/sysctl -p

#Set symlinks
ln -s /usr/bin/awk /bin/awk
ln -s /usr/bin/rpm /bin/rpm
ln -s /usr/bin/basename /bin/basename
ln -s /usr/lib/x86_64-linux-gnu /usr/lib64
ln -s /lib/libgcc_s.so.1 /lib/libgcc_s.so
ln -s /lib/x86_64-linux-gnu/libgcc_s.so.1 /lib64/libgcc_s.so.1
ln -sf /bin/bash /bin/sh

#Set Paths in Oracle bashrc
echo '# Oracle Settings' | tee -a /home/oracle/.bashrc
echo 'export TMP=/tmp;' | tee -a /home/oracle/.bashrc
echo 'export TMPDIR=$TMP;' | tee -a /home/oracle/.bashrc
echo 'export ORACLE_HOSTNAME=swg;' | tee -a /home/oracle/.bashrc
echo 'export ORACLE_BASE=/u01/app/oracle;' | tee -a /home/oracle/.bashrc
echo 'export ORACLE_HOME=$ORACLE_BASE/product/18/dbhome_1;' | tee -a /home/oracle/.bashrc
echo 'export ORACLE_SID=swg;' | tee -a /home/oracle/.bashrc
echo 'export ORACLE_UNQNAME=$ORACLE_SID;' | tee -a /home/oracle/.bashrc
echo 'export PATH=/usr/sbin:$ORACLE_HOME/bin:$PATH;' | tee -a /home/oracle/.bashrc
echo 'export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib:/usr/lib64;' | tee -a /home/oracle/.bashrc
echo 'export CLASSPATH=$ORACLE_HOME/JRE:$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib;' | tee -a /home/oracle/.bashrc

#let's download and unpack the binary
wget https://github.com/tekaohswg/gdown.pl/archive/v1.4.zip
unzip v1.4.zip
rm v1.4.zip
./gdown.pl-1.4/gdown.pl 'https://drive.google.com/open?id=17wfbfZuL90z4Z_FZPHK7l8FecepZ3dyP' 'LINUX.X64_180000_db_home.zip'
./gdown.pl-1.4/gdown.pl 'https://drive.google.com/open?id=1xb0S2cYAmXZurIkzuUuVOPDw-CcjDioL' 'oracle-instantclient12.2-basiclite-12.2.0.1.0-1.i386.rpm'
./gdown.pl-1.4/gdown.pl 'https://drive.google.com/open?id=15s_e_Z4BMxpAqsIUFwyO1tbM9SS1XFVZ' 'oracle-instantclient12.2-devel-12.2.0.1.0-1.i386.rpm'
./gdown.pl-1.4/gdown.pl 'https://drive.google.com/open?id=1FUVe89ZObP_LQN63xD1kQEpBgTmV3wbX' 'oracle-instantclient12.2-sqlplus-12.2.0.1.0-1.i386.rpm'
rm -r gdown.pl-1.4
mkdir -p /u01/app/oracle/product/18/dbhome_1
unzip -d /u01/app/oracle/product/18/dbhome_1/ LINUX.X64_180000_db_home.zip
chown -R oracle:oinstall /u01
chmod -R 775 /u01
