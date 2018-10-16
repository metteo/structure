#!/bin/bash

# Uncomment if the home dir should be derived from the location of the script
STRUCTURE_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"

# Check for $STRUCTURE_HOME
if [[ ! $STRUCTURE_HOME ]]; then
	echo "STRUCTURE_HOME is not set or empty!";
	exit 1;
else
	echo "STRUCTURE_HOME=$STRUCTURE_HOME";
fi

STRUCTURE_BIN_DIR=bin
STRUCTURE_ENV_FILE=structure.env.sh

# Load ENV variables
source $STRUCTURE_HOME/$STRUCTURE_BIN_DIR/$STRUCTURE_ENV_FILE

# Load sys properties 
source $STRUCTURE_HOME/$STRUCTURE_BIN_DIR/$STRUCTURE_SYS_FILE

SYS_PROPS=""

for i in "${!STRUCTURE_SYS_PROPS[@]}"
do
	SYS_PROPS="$SYS_PROPS -D$i=${STRUCTURE_SYS_PROPS[$i]}"
done

echo $SYS_PROPS

# Check for $JAVA_HOME
if [[ ! $JAVA_HOME ]]; then
	echo "JAVA_HOME is not set or empty!";
	exit 1;
else
	echo "JAVA_HOME=$JAVA_HOME";
fi

#export optional if used with -cp
export CLASSPATH="$STRUCTURE_HOME/lib/modules/*:$STRUCTURE_HOME/lib/*";
#echo $CLASSPATH;

$JAVA_HOME/bin/java $SYS_PROPS $JAVA_OPTIONS $STRUCTURE_MAIN "$@"
#$JAVA_HOME/bin/java -cp $CLASSPATH $STRUCTURE_MAIN "$@"

