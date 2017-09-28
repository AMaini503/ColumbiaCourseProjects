from mysql.connector import MySQLConnection, Error
import mysql.connector
import numpy
import random
def init(): 
	conn = mysql.connector.connect(host='localhost',database='hw2m',user='root',password='password')
	return (conn, conn.cursor())
def executeSQLSelect(query, cursor):
	try:
		cursor.execute(query)
		rows = cursor.fetchall()
		return rows
	except Error as e:
		print(e)

def main():

	#7 departments
	#20 faculty
	#Distribution 2 + 2 + 4 + 4 + 4 + 2 + 2
	(conn, cursor) = init()
	query = "SELECT FacultyID FROM Faculty"
	all_faculty = executeSQLSelect(query, cursor)

	query = "SELECT ID, Name FROM Department"
	all_depts = executeSQLSelect(query, cursor)

	count_array = [2,2,4,4,4,2,2]
	random.shuffle(all_faculty)

	start = 0

	list_of_updates = []
	for (i, count) in enumerate(count_array):

		end = start + count #exclusive

		did = all_depts[i][0]
		dname = all_depts[i][1]

		faculty_in_this_dept = all_faculty[start: end]

		for faculty in faculty_in_this_dept:
			fid = faculty[0]

			query = "UPDATE Faculty SET DeptID=" + str(did) + ",DeptName='" + dname + "' WHERE FacultyID=" + str(fid) + ";\n"
			print query
			list_of_updates.append(query)
		start = end

	f = open("update_faculty.sql","w")
	f.writelines(list_of_updates)
	f.close()


if __name__ == "__main__":
	main()