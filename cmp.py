import json, copy, sys
from json2html import *

with open(sys.argv[1]) as f:
    data = json.load(f)

with open(sys.argv[2]) as f:
    data2 = json.load(f)

# Step1 : remove the exactly same ones
def check1(case):
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


# extract exception part
def extract_exception(input):
    split_str = input.split(': ', 1)
    return split_str[0]


def check4(case):
    found = False
    for i in data['descriptions']:
        exception1 = i['exception'][0]
        exception2 = case['exception'][0]

        direct_cause1 = i['location'][0]
        direct_cause2 = case['location'][0]

        if exception1 == exception2:
            if direct_cause1 == direct_cause2:
                found = True
                return found

    return found



        # if(i['exception']==case['exception']):
        #     if len(i['location']) == len(case['location']):
        #         location_equal = True
        #         for j in range(len(i['location'])-1):
        #             if i['location'][j] != case['location'][j]:
        #                 location_equal = False
        #                 break
        #         if location_equal:
        #             return True

    return equal


# Step2 : check if the same methods are used between ver1 and ver2
def check5(case):
    found = False
    for i in data['descriptions']:
        exception1 = i['exception'][0]
        exception2 = case['exception'][0]

        direct_cause1 = i['location'][0]
        direct_cause2 = case['location'][0]

        if extract_exception(exception1) == extract_exception(exception2):
            if direct_cause1 == direct_cause2:
                found = True
                return found

    return found



        # if(i['exception']==case['exception']):
        #     if len(i['location']) == len(case['location']):
        #         location_equal = True
        #         for j in range(len(i['location'])-1):
        #             if i['location'][j] != case['location'][j]:
        #                 location_equal = False
        #                 break
        #         if location_equal:
        #             return True

    return equal

def check7(case):
    equal = False
    for i in data['descriptions']:
        if(i['exception']==case['exception']):
            return True
    return equal

def check8(case):
    equal = False
    for i in data['descriptions']:
        exception1 = i['exception'][0]
        exception2 = case['exception'][0]
        if(extract_exception(exception1)==extract_exception(exception2)):
            return True
    return equal

data3 = []
# Step1
cnt = 0
'''
for i in data2['descriptions']:
    if not search(i):
        cnt+=1
        # print(i)
        data3.append(copy.deepcopy(i))
# print(cnt)
'''

# Step2
cnt = 0
for i in data2['descriptions']:
    if not check8(i):
        cnt+=1
        data3.append(copy.deepcopy(i))
        #print(i)

html = json2html.convert(json = data3)
print(cnt)
print(html)