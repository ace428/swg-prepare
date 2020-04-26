#!/bin/bash

# Get the dependencies
apt-get update
apt-get install alien php-dev php-pear libaio1 build-essential -y

# Get the instantclients
wget https://github.com/tekaohswg/gdown.pl/archive/v1.4.zip
unzip v1.4.zip
rm v1.4.zip
./gdown.pl-1.4/gdown.pl 'https://drive.google.com/open?id=1PFtRlatlozfairdclfHI-46CwaVGQAb-' 'oracle-instantclient18.5-basic-18.5.0.0.0-3.x86_64.rpm'
./gdown.pl-1.4/gdown.pl 'https://drive.google.com/open?id=15NXyoE2eaOAQoO3c3Ttp87HBR5hWBN4G' 'oracle-instantclient18.5-devel-18.5.0.0.0-3.x86_64.rpm'
rm -r gdown.pl-1.4

# Install the instantclients
alien -i oracle-instantclient18.5-basic-18.5.0.0.0-3.x86_64.rpm
alien -i oracle-instantclient18.5-devel-18.5.0.0.0-3.x86_64.rpm

# Install PHP OCI8
echo "instantclient,/usr/lib/oracle/18.5/client64/lib" | pecl install oci8

# Add some config to PHP and Apache2
echo "extension=oci8.so" >> /etc/php/7.2/cli/php.ini
echo "extension=oci8.so" >> /etc/php/7.2/apache2/php.ini
echo "export ORACLE_HOME=/usr/lib/oracle/18.5/client64" >> /etc/apache2/envvars
echo "export LD_LIBRARY_PATH=/usr/lib/oracle/18.5/client64/lib" >> /etc/apache2/envvars

# Restart Apache2
systemctl restart apache2
