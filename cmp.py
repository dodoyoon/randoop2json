import json, copy, sys
from json2html import *

with open(sys.argv[1]) as f:
  data = json.load(f)

with open(sys.argv[2]) as f:
    data2 = json.load(f)

def search(case):
    equal = False
    for i in data['descriptions']:
        if(i['exception']==case['exception']):
            if len(i['location']) == len(case['location']):
                location_equal = True
                for j in range(len(i['location'])-1):
                    if i['location'][j] != case['location'][j]:
                        location_equal = False
                        break
                if location_equal:
                    return True
    return equal

data3 = []
cnt = 0
for i in data2['descriptions']:
    if not search(i):
        cnt+=1
        data3.append(copy.deepcopy(i))
        #print(i)
    #print(i['exception'])

html = json2html.convert(json = data3)
print(html)

# f = open('final.html', 'w')
# f.write(html)
# f.close()