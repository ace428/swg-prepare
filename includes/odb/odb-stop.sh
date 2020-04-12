#!/bin/bash

export TMP=/tmp;
export TMPDIR=$TMP;
export ORACLE_HOSTNAME=swg;
export ORACLE_BASE=/u01/app/oracle;
export ORACLE_HOME=$ORACLE_BASE/product/18/dbhome_1;
export ORACLE_SID=swg;
export ORACLE_UNQNAME=$ORACLE_SID;
export PATH=/usr/sbin:$ORACLE_HOME/bin:$PATH;
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib:/usr/lib64;
export CLASSPATH=$ORACLE_HOME/JRE:$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib;

sqlplus "/as sysdba" << EOF
shutdown;
exit;
EOF
lsnrctl stop
