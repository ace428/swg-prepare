ALTER USER SYSTEM IDENTIFIED by "swg";
ALTER SESSION SET "_ORACLE_SCRIPT"=true;
CREATE USER swg IDENTIFIED by "swg";
GRANT ALL PRIVILEGES TO swg;
GRANT UNLIMITED TABLESPACE TO swg;
alter system set sessions=3000 scope=spfile;
alter system set processes=3000 scope=spfile;
alter profile default limit password_life_time unlimited;