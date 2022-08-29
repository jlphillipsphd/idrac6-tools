#!/bin/bash

echo -n 'iDRAC IP/FQDN: '
read drachost
echo

echo -n 'Username: '
read dracuser
echo

echo -n 'Password: '
read -s dracpwd
echo

export LD_LIBRARY_PATH=/usr/local/lib:${LD_LIBRARY_PATH}
# export JAVA_BIN=/opt/dell/srvadmin/lib64/openmanage/jre/bin/java
export JAVA_BIN=java
${JAVA_BIN} -cp /usr/local/lib/avctKVM.jar -Djava.library.path=/usr/local/lib com.avocent.idrac.kvm.Main ip=${drachost} kmport=5900 vport=5900 user=${dracuser} passwd=${dracpwd} apcp=1 version=2 vmprivilege=true "helpurl=https://${drachost}:443/help/contents.html"
