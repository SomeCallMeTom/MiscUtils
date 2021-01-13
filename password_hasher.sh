#!/bin/bash
######################
#      Settings      #
######################
CP="lib/ojdbc6.jar:lib/postgresql-9.1-901.jdbc3.jar:lib/sqljdbc4.jar:lib/password_hasher.jar;"
MAINCLASS="com.gloryglobalsolutions.cashinsight.database.tools.PasswordHasher"
PARAM1="dbconnect=dbconnect.properties"
# PARAM2="algorithm=PBKDF2WithHmacSHA1"
######################
#    End Settings    #
######################
java -cp $CP $MAINCLASS $PARAM1
read -r -p "press any key to continue"