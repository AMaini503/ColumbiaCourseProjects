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
	#80 students
	#Distribution 10 + 10 + 10 + 20 + 10 + 10 + 10
	(conn, cursor) = init()
	query = "SELECT * FROM Student"
	all_students = executeSQLSelect(query, cursor)

	query = "SELECT ID, Name FROM Department"
	all_depts = executeSQLSelect(query, cursor)

	count_array = [10,10,10,20,10,10,10]
	random.shuffle(all_students)

	start = 0

	list_of_updates = []
	for (i, count) in enumerate(count_array):

		end = start + count #exclusive

		did = all_depts[i][0]
		dname = all_depts[i][1]

		students_in_this_dept = all_students[start: end]

		for student in students_in_this_dept:
			sid = student[0]

			query = "UPDATE Student SET DeptID=" + str(did) + ",DeptName='" + dname + "' WHERE StudentID=" + str(sid) + ";\n"
			print query
			list_of_updates.append(query)
		start = end

	f = open("update_students.sql","w")
	f.writelines(list_of_updates)
	f.close()


if __name__ == "__main__":
	main()