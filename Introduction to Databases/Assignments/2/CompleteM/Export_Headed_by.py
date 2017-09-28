from mysql.connector import MySQLConnection, Error
import mysql.connector
import numpy as np


def init():
	conn = mysql.connector.connect(host='localhost',database='hw2m', user='root',password='password')

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


def main(): 
	(conn, cursor) = init()


	num_dept = 7
	(conn, cursor) = init()

	query = "SELECT ID, Name from Department"
	all_depts = executeSQLSelect(query, cursor)
	
	list_of_headed_by = []

	for dept in all_depts:

		#get all the members of that department
		query = "SELECT FacultyID,FirstName,LastName from Faculty where DeptID=" + str(dept[0]) + ";"

		# print query
		all_members = executeSQLSelect(query, cursor)

		#randomly choose a member as HOD

		random_index = np.random.randint(low = 0, high = len(all_members))

		hod = all_members[random_index]

		fid = hod[0]
		fname = hod[1]
		lname = hod[2]

		did = dept[0]
		dname = dept[1]

		query = "INSERT INTO Headed_by(`DeptID`,`DeptName`,`FacultyID`,`FacultyFName`,`FacultyLName`) VALUES(" + str(did) + ",'" +  dname + "','" + fid  + "','" + fname + "','" + lname + "');\n"
		print query
		list_of_headed_by.append(query)


	f = open("Export_headed_by.sql","w")
	f.writelines(list_of_headed_by)
	f.close()

if __name__ == "__main__":
	main()