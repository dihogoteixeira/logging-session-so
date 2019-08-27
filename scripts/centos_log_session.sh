#!/bin/bash

# Instalando dependencias 
yum -y install psacct && systemctl start psacct && systemctl enable psacct
yum -y provides /usr/bin/script 

# Criando path de sessions
mkdir /var/log/session
chmod 777 /var/log/session

# Aplicando configuracao no /etc/profile para iniciar o log em todo login
echo -e '#Record terminal sessions\n
if [ "x$SESSION_RECORD" = "x" ]\n
then\n
timestamp=`date "+%m%d%Y%H%M"`\n
output=/var/log/session/session.$USER.$$.$timestamp\n
SESSION_RECORD=started\n
export SESSION_RECORD\n
script -t -f -q 2>${output}.timing $output\n
exit\n
fi' >> /etc/profile

