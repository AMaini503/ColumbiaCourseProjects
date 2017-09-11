import csv

f = open("customers.csv")
reader = csv.reader(f, delimiter=",")
print row[7]
