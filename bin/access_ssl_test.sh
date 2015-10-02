#!/bin/bash
SCRIPT_DIR=`echo $(cd $(dirname $0);pwd)`

if [ "$JAVA_HOME" != ""  ]
then
	certs="${JAVA_HOME}/jre/lib/security/cacerts"
fi



while getopts "hu:c:" flag
do
    case $flag in
        u) url=$OPTARG;;
        c) certs=$OPTARG;;
        h|*) opt_h=true;;
    esac
done

if [ "${url}" = "" ]
then
	opt_h=true
fi

if [ $opt_h ]
then
	echo "-h : help"
	echo "-u : must specify url"
	echo "-c : certs file(default=\${JAVA_HOME}/jre/lib/security/cacerts)"
	exit;
fi

cd $SCRIPT_DIR
cd ../src
javac SSLClientSample.java
echo "JAVA_HOME=${JAVA_HOME}"
echo "certs file=${certs}"
java -Djavax.net.ssl.trustStore=${certs} SSLClientSample ${url}

if [ $? -eq 0 ]
then
	echo "successfully access ${url}"
	exit 0;
else
	echo "fail to access ${url}"
	exit 1;
fi
