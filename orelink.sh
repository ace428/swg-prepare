#!/bin/bash

cd /u01/app/oracle/product/18/dbhome_1/lib/stubs
rm libc.*
cd /u01/app/oracle/product/18/dbhome_1/bin
./relink all
cd
