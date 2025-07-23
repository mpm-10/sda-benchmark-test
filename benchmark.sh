#!/usr/bin/env bash





MIN_CONCURRENT_USERS=0
MAX_CONCURRENT_USERS=255

MIN_REPS_RUN=0
MAX_REPS_RUN=100000

MIN_DELAY=0
MAX_DELAY=60

IS_VALID_VALUE=0
URLS_FILE="dos-experiment-urls-local.txt"





while [ ${IS_VALID_VALUE} -eq 0 ];
do
	read -p "Insira a Quantidade de Usuários(${MIN_CONCURRENT_USERS}-${MAX_CONCURRENT_USERS}): " CONCURRENT_USERS
	
	if [ -z "${CONCURRENT_USERS}" ];
	then
		continue
	elif [ -z "${CONCURRENT_USERS##*[!0-9]*}" ];
	then
		continue
	elif [ "${CONCURRENT_USERS}" -lt "${MIN_CONCURRENT_USERS}" ];
	then
		continue
	elif [ "${CONCURRENT_USERS}" -gt "${MAX_CONCURRENT_USERS}" ];
	then
		continue
	fi;
	
	IS_VALID_VALUE=1	
done;



IS_VALID_VALUE=0



while [ ${IS_VALID_VALUE} -eq 0 ];
do
	read -p "Insira a Quantidade de Repetições(${MIN_REPS_RUN}-${MAX_REPS_RUN}): " REPS_RUN
	
	if [ -z "${REPS_RUN}" ];
	then
		continue
	elif [ -z "${REPS_RUN##*[!0-9]*}" ];
	then
		continue
	elif [ "${REPS_RUN}" -lt "${MIN_REPS_RUN}" ];
	then
		continue
	elif [ "${REPS_RUN}" -gt "${MAX_REPS_RUN}" ];
	then
		continue
	fi;
	
	IS_VALID_VALUE=1
done;



IS_VALID_VALUE=0



while [ ${IS_VALID_VALUE} -eq 0 ];
do
	read -p "Insira o Tempo de Delay(${MIN_DELAY}-${MAX_DELAY}): " DELAY
	
	if [ -z "${DELAY}" ];
	then
		continue
	elif [ -z "${DELAY##*[!0-9]*}" ];
	then
		continue
	elif [ "${DELAY}" -lt "${MIN_DELAY}" ];
	then
		continue
	elif [ "${DELAY}" -gt "${MAX_DELAY}" ];
	then
		continue
	fi;
	
	IS_VALID_VALUE=1
done;



IS_VALID_VALUE=0





echo 
echo "Usuários: $CONCURRENT_USERS"
echo "Repetições: $REPS_RUN"
echo "Delay: $DELAY"





siege -c ${CONCURRENT_USERS} -r ${REPS_RUN} -d ${DELAY} -f ${URLS_FILE} | python3 benchmark.py

