import json
import sys
import re

inf = open(sys.argv[1], 'r')
content = inf.readlines()
inf.close()

testsyntax = re.compile('\d*\) test\d*\(ErrorTest\d*\)')

#print(content)

versionline = 0
relevent = False
exception = False
firsttest = True

testfinal = json.loads('{}')
testlist = []
tests = []
onetest = json.loads('{}')
loc = []

for i in range(len(content)):
    if i==versionline and content[i].startswith("JUnit version "):
        print(content[i])
        jver = content[i]

    if content[i].startswith("Time: "):
        time = content[i]
        relevent = True

    '''
    if relevent:
        print(i, content[i])
    '''

    if relevent:
        if testsyntax.match(content[i]):
            onetest = json.loads('{}')
            loc = []
            if not firsttest:
                print("==============")
                print(onetest)
                onetest.update({"from": loc})
                tests.append(onetest)
                #testfinal.update(testlist)
            else:
                firsttest = False
            #if not first close
            onetest.update({"id": content[i]})
            exception = True
            #testid = {"id": content[i]}
            #testresult.update(testid)
            print(i, content[i])
        elif exception:
            onetest.update({"exception": content[i]})
            print(content[i])
            exception = False
        else:
            loc.append(content[i])

result = {"jver": jver, "time": time, "tests": tests}



print(json.dumps(result))

with open('data.json', 'w') as f:
    json.dump(result, f)
    