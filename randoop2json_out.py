import json, copy, sys
from json2html import *
import io

filename = sys.argv[1]
inf = open(filename, "r")
file = inf.readlines()
#file = sys.argv[1]

final_dict = {}
l_cnt = 0
last_elem_cnt = 0
descriptions=[]
one_description={}
result_dict={}
loc_list=[]

is_exception = False
exception_list = []

for line in file:
    if line == '\n' or not line :
        continue

    line = line.strip()
    # print(line)

    if line.split(' ', 1)[0] == 'at':
        #print("1")
        # print(exception_list)
        one_description['exception'] = copy.deepcopy(exception_list)

        is_exception = False


    if line[0].isdigit() and 'test' in line:
        #print("2")
        if loc_list:
            #opprint("2-1")
            one_description['location'] = loc_list
            descriptions.append(copy.deepcopy(one_description))
            loc_list.clear()
            one_description.clear()
            exception_list.clear()
            one_description['id'] = line
        else:
            # print("2-2")
            one_description['id'] = line

        is_exception = True

    # exception
    # elif line.split('.', 1)[0] == 'java':
    elif is_exception:
        # print("3")
        # one_description['exception'] = line
        exception_list.append(copy.deepcopy(line))
        # is_exception = False

    # location
    elif line.split(' ', 1)[0] == 'at':
        # print("4")
        loc_list.append(copy.deepcopy(line))

    # results
    elif line[0] == 'F':
        # print("5")
        result_dict['word'] = line
        if last_elem_cnt == 0:
            # print("5-1")
            one_description['location'] = loc_list

            descriptions.append(copy.deepcopy(one_description))
            last_elem_cnt = last_elem_cnt + 1

    elif line.split(' ', 1)[0] == 'Tests':
        # print("6")
        result_dict['result'] = line

    else:
        # print("7")
        continue

final_dict['descriptions'] = descriptions
final_dict['summary'] = result_dict



out_file_name = filename + '.json'
out_file = open(out_file_name, "w")
json.dump(final_dict, out_file, indent=4)
out_file.close()
'''
html_name = filename + '.html'
outf = open(html_name, "w")
#outf.write(json2html.convert(json = final_dict))

print(json2html.convert(json = final_dict))
#outf.close()
'''