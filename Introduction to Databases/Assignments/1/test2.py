import re

string = raw_input(">> ")

pattern = re.compile(r'"([A-za-z0-9]*)"(\s*,\s*"([A-za-z0-9]*)")*')
match = pattern.match(string)
print match.groups()
