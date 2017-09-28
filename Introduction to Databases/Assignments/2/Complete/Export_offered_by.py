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


def main(): 
	(conn, cursor) = init()


	num_dept = 7
	(conn, cursor) = init()

	query = "SELECT ID, Name from Department"
	all_depts = executeSQLSelect(query, cursor)
	
	query = "SELECT CourseID, FullName, CourseCode from Course"
	all_courses = executeSQLSelect(query, cursor)

	dept_codes = { "CS": 0, "ES":1 , "EL":2, "BS":3, "NS":4, "MT":5, "BM":6}

	#add native courses to their respective department
	list_of_offered_by = []

	for course in all_courses:
		code = course[2]
		cname = course[1]
		cid = course[0]
		dept_code = code[0:2]

		corresponding_dept = all_depts[dept_codes[dept_code]]
		did = corresponding_dept[0]
		dname = corresponding_dept[1]

		query = "INSERT INTO Offered_by(`DeptID`,`DeptName`,`CourseID`,`CourseName`) VALUES(" + str(did) + ",'" + dname + "','" + cid + "','" + cname + "');\n"
		# print query
		list_of_offered_by.append(query)

	f = open("Export_offered_by.sql", "w")
	f.writelines(list_of_offered_by)
	f.close()
if __name__ == "__main__":
	main()