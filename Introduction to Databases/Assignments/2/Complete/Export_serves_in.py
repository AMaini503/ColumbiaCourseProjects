from mysql.connector import MySQLConnection, Error
import mysql.connector
import numpy as np


def init():
	conn = mysql.connector.connect(host='localhost',database='hw2', user='root',password='password')

	return (conn, conn.cursor())
def executeSQLSelect(query, cursor):
	try: 
		cursor.execute(query)
		rows = cursor.fetchall()
		return rows
	except Error as e:
		print(e)
def executeInsertQuery(query, cursor, conn):
	try: 
		cursor.execute(query)
		conn.commit()
	except Error as e:
		print "Error in insert for " + query 

def getRandomDesg(desigs):
	return desigs[np.random.randint(low = 0, high = len(desigs))]

def main():

	#assign faculty to random departments
	#assign a faculty to atmost 3 departments

	num_dept = 7
	desigs = ["Senior Professor", "Adjunt Professor", "Assistant Professor"]
	(conn, cursor) = init()
	query = "SELECT FacultyID, FirstName, LastName FROM Faculty"

	all_faculty = executeSQLSelect(query, cursor)

	query = "SELECT ID, Name from Department"
	all_depts = executeSQLSelect(query, cursor)

	print all_depts
	print all_faculty

	list_of_serves_in = []

	for faculty_record in all_faculty:
		fid = faculty_record[0]
		fname = faculty_record[1]
		lname = faculty_record[2]

		#generate random departments
		random_indices = np.random.randint(low = 0, high = 7, size = 3)

		dropped_depts = np.random.randint(low = 1, high = 4)

		#how many actual departments
		random_indices = random_indices[0:dropped_depts]
		random_indices = set(random_indices)

		for index in random_indices:
			dept = all_depts[index]

			did = dept[0]
			dname = dept[1]

			designation = getRandomDesg(desigs)
			query = "INSERT INTO Serves_in(`DeptID`,`DeptName`,`FacultyID`,`FacultyFName`,`FacultyLName`,`Designation`) VALUES(" + str(did) + ",'" + dname + "','" + fid + "','" + fname + "','" + lname + "','" + designation + "');\n" 
			# print query
			list_of_serves_in.append(query)
			# list_of_serves_in.append(query)

	f = open("Export_serves_in.sql", "w")
	f.writelines(list_of_serves_in)
	f.close()

if __name__ == "__main__":
	main()