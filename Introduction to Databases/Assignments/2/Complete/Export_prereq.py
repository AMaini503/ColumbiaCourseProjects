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
	query = "SELECT * FROM Course"
	(conn, cursor) = init()
	result = executeSQLSelect(query, cursor)
	
	all_courses = map(lambda x: (x[0],x[1]), result)

	all_courses = map(lambda x: list(x), all_courses)
	map(lambda x: x.append(int(x[0])), all_courses)

	

	all_courses = sorted(all_courses, key = lambda item: item[2])

	count = len(all_courses)

	# print all_courses

	#generate random prerequisites
	#A course is prereq for 2 courses on av.
	#Total len of prereq table is 140
	# number of pre req rows per dept = 140/7 = 20
	#number of courses per dept = 10
	#draw 3 courses at random and make prereq, giving 2 rows to pre req
	# 2 * 5 = 10

	#inter-departmental pre-reqs

	num_dept = 7
	list_of_prereq = []
	for i in range(0, num_dept):
		for j in range(1,6):
			random_indices = np.random.randint(low = 10 * i, high = 10 * i + 9, size = 3)

			print random_indices
			errors = filter(lambda x: x < 10 * i or x > 10 * i + 8, random_indices)

			if(len(errors) > 0):
				print "Error Found"

			for k in range(0, 2):
				course = all_courses[random_indices[k]]
				prereq = all_courses[random_indices[k+1]]

				if course[2] != prereq[2] and (prereq, course) not in list_of_prereq and (course, prereq) not in list_of_prereq:

					list_of_prereq.append((course, prereq))


	print len(list_of_prereq)
	lines = []
	for (course, prereq) in list_of_prereq:
		query = "INSERT INTO Prerequisite(`CourseID`,`CourseName`,`PrereqCourseID`,`PrereqCourseName`) VALUES('" + course[0] + "','" + course[1] + "','" + prereq[0] + "','" + prereq[1] + "');\n"
		# print query
		lines.append(query)

	f = open("Export_prereq.sql","w")

	f.writelines(lines)

	f.close()

if __name__ == "__main__":
	main()