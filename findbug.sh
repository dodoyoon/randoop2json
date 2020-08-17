#!/bin/bash

source ~/.bash_profile

git clone $1
cd "$(basename "$1" .git)"
git reset --hard $2
cd randoop
source build.sh
cd $(git rev-parse --show-toplevel)/randoop
source randoop.sh
pwd

#run randoop for version 1
#java -classpath ${RANDOOP_JAR}: randoop.main.Main gentests --classlist=$(git rev-parse --show-toplevel)/randoop/myclasses.txt --time-limit=60 --unchecked-exception=ERROR --checked-exception=ERROR

vim -E -s RegressionTest0.java << EOF
:%s/null; \/\/ flaky://g
:%s/false; \/\/ flaky://g
:%s/0; \/\/ flaky://g
:%s/0L; \/\/ flaky://g
:%s/\/\/ flaky: //g
:update
:quit
EOF

vim -E -s RegressionTest1.java << EOF
:%s/null; \/\/ flaky://g
:%s/false; \/\/ flaky://g
:%s/0; \/\/ flaky://g
:%s/0L; \/\/ flaky://g
:%s/\/\/ flaky: //g
:update
:quit
EOF

vim -E -s RegressionTest2.java << EOF
:%s/null; \/\/ flaky://g
:%s/false; \/\/ flaky://g
:%s/0; \/\/ flaky://g
:%s/0L; \/\/ flaky://g
:%s/\/\/ flaky: //g
:update
:quit
EOF

javac -classpath .:$JUNITPATH ErrorTest*.java 
javac -classpath .:$JUNITPATH RegressionTest*.java
err1=$(java -classpath .:$JUNITPATH: org.junit.runner.JUnitCore ErrorTest)
java -classpath .:$JUNITPATH: org.junit.runner.JUnitCore ErrorTest > $(git rev-parse --show-toplevel)/../err1.txt
java -classpath .:$JUNITPATH: org.junit.runner.JUnitCore RegressionTest > $(git rev-parse --show-toplevel)/../reg1.txt

git reset --hard $3
cd $(git rev-parse --show-toplevel)
pwd
cd randoop
source build.sh

#run randoop for version 2 : assumption! - ErrorTest and RegressionTest in same directory as previous version
javac -classpath .:$JUNITPATH RegressionTest*.java
err3=$(java -classpath .:$JUNITPATH: org.junit.runner.JUnitCore RegressionTest)
java -classpath .:$JUNITPATH: org.junit.runner.JUnitCore RegressionTest
java -classpath .:$JUNITPATH: org.junit.runner.JUnitCore RegressionTest > $(git rev-parse --show-toplevel)/../reg_dif.txt

# clean up the existing test
#cd $(git rev-parse --show-toplevel)
rm **/ErrorTest* **/RegressionTest*

cd $(git rev-parse --show-toplevel)/randoop
source randoop.sh

#java -classpath ${RANDOOP_JAR}: randoop.main.Main gentests --classlist=$(git rev-parse --show-toplevel)/randoop/myclasses.txt --time-limit=60 --unchecked-exception=ERROR --checked-exception=ERROR
#javac -classpath .:$JUNITPATH ErrorTest*.java
#javac -classpath .:$JUNITPATH RegressionTest*.java
err2=$(java -classpath .:$JUNITPATH: org.junit.runner.JUnitCore ErrorTest)
java -classpath .:$JUNITPATH: org.junit.runner.JUnitCore ErrorTest > $(git rev-parse --show-toplevel)/../err2.txt
java -classpath .:$JUNITPATH: org.junit.runner.JUnitCore RegressionTest > $(git rev-parse --show-toplevel)/../reg2.txt

cd $(git rev-parse --show-toplevel)/../
python3 randoop2json_out.py err1.txt
python3 randoop2json_out.py err2.txt
./randoop2html.sh result.html
