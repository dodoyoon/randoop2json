#!/bin/bash

git clone $1
cd "$(basename "$1" .git)"
git reset --hard $2
cd rdp
chmod +x randoop.sh
source randoop.sh
pwd
source ~/.bash_profile

#run randoop for version 1
java -classpath ${RANDOOP_JAR}: randoop.main.Main gentests --classlist=$(git rev-parse --show-toplevel)/rdp/myclasses.txt --time-limit=60 --unchecked-exception=ERROR --checked-exception=ERROR
javac -classpath .:$JUNIT_PATH ErrorTest*.java 
err1=$(java -classpath .:$JUNIT_PATH: org.junit.runner.JUnitCore ErrorTest)
javac -classpath .:$JUNIT_PATH RegressionTest*.java
java -classpath .:$JUNIT_PATH: org.junit.runner.JUnitCore RegressionTest > $(git rev-parse --show-toplevel)/../reg1.txt

git reset --hard $3
cd $(git rev-parse --show-toplevel)
pwd
cd rdp
source randoop.sh
pwd


#run randoop for version 2
java -classpath .:$JUNIT_PATH: org.junit.runner.JUnitCore RegressionTest > $(git rev-parse --show-toplevel)/../reg_dif.txt

# clean up the existing test
#cd $(git rev-parse --show-toplevel)
rm **/ErrorTest* **/RegressionTest*
cd rdp

java -classpath ${RANDOOP_JAR}: randoop.main.Main gentests --classlist=$(git rev-parse --show-toplevel)/rdp/myclasses.txt --time-limit=60 --unchecked-exception=ERROR --checked-exception=ERROR
javac -classpath .:$JUNIT_PATH ErrorTest*.java
err2=$(java -classpath .:$JUNIT_PATH: org.junit.runner.JUnitCore ErrorTest)
javac -classpath .:$JUNIT_PATH RegressionTest*.java
java -classpath .:$JUNIT_PATH: org.junit.runner.JUnitCore RegressionTest > $(git rev-parse --show-toplevel)/../reg2.txt

cd $(git rev-parse --show-toplevel)/../
./randoop2html.sh result.html "$err1" "$err2"
