import time
import bisect

def binary_search(index, key): 
	start = 0
	end = len(index) - 1

	while start <= end:
		mid = (end - start)/2 + start
		if index[mid][0] == key:
			return mid
		elif index[mid][0] < key:
			start = mid + 1
		else:
			end = mid - 1
	return -1

key = 3122

start = time.clock()

dictionary = {x:x for x in range(1,100001)}
if key in dictionary:
	print dictionary[key]

new_key = 43324
if new_key in dictionary:
	dictionary[new_key] = 0
print "For dictionary : " + str(time.clock() - start)

start = time.clock()
index = [(x,x) for x in range(1,100001)]
key_index = binary_search(index, key)
if key_index != -1:
	print index[key_index]
print "For dictionary: " + str(time.clock() - start)