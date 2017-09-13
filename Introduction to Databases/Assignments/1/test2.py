import re

pattern_for_constraint_query = re.compile(r"apply\s+unique\s+to\s+([A-za-z0-9]+)\.([A-za-z0-9]+)")

while(True):
	string = raw_input(">> ")
	match = pattern_for_constraint_query.match(string)
	if match:
		print match.groups()