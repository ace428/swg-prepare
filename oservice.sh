#!/bin/bash

cp ~/swg-prepare/includes/odb/odb.service /etc/systemd/system/
cp ~/swg-prepare/includes/odb/odb-start.sh /etc/
cp ~/swg-prepare/includes/odb/odb-stop.sh /etc/
systemctl enable odb.service
