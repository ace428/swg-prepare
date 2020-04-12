#!/bin/bash

#get some dependencies
apt-get install alien ant bc bison build-essential clang clang-3.9 cmake default-jdk flex g++-6-multilib gcc-6-multilib git-core lib32ncurses5 lib32z1 libaio1 libaio1:i386 libboost-dev libboost-program-options-dev libc6-dbg libc6-dbg:i386 libc6-dev:i386 libc6-i686:i386 libc6:i386 libcurl4-gnutls-dev:i386 libgcc1:i386 libncurses5-dev:i386 libpcre3-dev:i386 libsqlite3-dev libxml2-dev:i386 linux-libc-dev:i386 openjdk-11-jdk:i386 openjdk-11-jdk psmisc python-ply sqlite3 zlib1g-dev:i386 zlib1g:i386 -y

apt-get remove libncurses-dev:amd64 libxml2-dev:amd64 zlib1g-dev:amd64 -y

#install oracle instantclients
alien -i --target=amd64 ~/oracle-instantclient12.2-basiclite-12.2.0.1.0-1.i386.rpm
alien -i --target=amd64 ~/oracle-instantclient12.2-devel-12.2.0.1.0-1.i386.rpm
alien -i --target=amd64 ~/oracle-instantclient12.2-sqlplus-12.2.0.1.0-1.i386.rpm

#set env vars
touch /etc/ld.so.conf.d/oracle.conf
touch /etc/profile.d/oracle.sh
echo "/usr/lib/oracle/12.2/client/lib" | tee -a /etc/ld.so.conf.d/oracle.conf
echo "export ORACLE_HOME=/usr/lib/oracle/12.2/client" | tee -a /etc/profile.d/oracle.sh
echo "export PATH=\$PATH:/usr/lib/oracle/12.2/client/bin" | tee -a /etc/profile.d/oracle.sh
echo "export LD_LIBRARY_PATH=/usr/lib/oracle/12.2/client/lib:/usr/include/oracle/12.2/client" | tee -a /etc/profile.d/oracle.sh
ln -s /usr/include/oracle/12.2/client $ORACLE_HOME/include
ldconfig
touch /etc/profile.d/java.sh
echo "export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64" | tee -a /etc/profile.d/java.sh
