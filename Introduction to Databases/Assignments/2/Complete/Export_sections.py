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

	#get the join first

	query = "SELECT o.CourseID, o.CourseName, o.DeptID, o.DeptName, s.FacultyID, s.FacultyFName, s.FacultyLName from Offered_by o JOIN Serves_in s ON o.DeptID = s.DeptID"
	result = executeSQLSelect(query, cursor)

	query = "SELECT * from Course"
	all_courses = executeSQLSelect(query, cursor)

	list_of_sections = []
	s = 0

	for course in all_courses:

		cid = course[0]
		
		#sections <= #profs available

		all_possible_prof_assignments = filter(lambda record: record[0] == cid, result)
		num_profs_available_in_this_dept = len(all_possible_prof_assignments)


		max_num_sections = num_profs_available_in_this_dept
		num_dropped_sections = np.random.randint(low = 0, high = max_num_sections) #atleast one section

		actual_num_sections = max_num_sections - num_dropped_sections

		#get random assignments
		random_indices = np.random.randint(low = 0, high = len(all_possible_prof_assignments), size = actual_num_sections)
		random_indices = list(set(random_indices))

		_max_allowance_for_course = 3
		actual_num_sections = min(_max_allowance_for_course, len(random_indices))

		if actual_num_sections > 3:
			print "Error"

		s = s + actual_num_sections
		for index in random_indices[0: actual_num_sections + 1]:

			prof_assignment = all_possible_prof_assignments[index]

			cid = prof_assignment[0]
			cname = prof_assignment[1]

			did = prof_assignment[2]
			dname = prof_assignment[3]

			fid = prof_assignment[4]
			fname = prof_assignment[5]
			lname = prof_assignment[6]

			query = "INSERT INTO Sections(`CourseID`,`CourseName`,`SectionNumber`,`FacultyID`,`InstructorFName`,`InstructorLName`) VALUES('" + cid + "','" + cname + "'," + str(index + 1) + ",'" + fid + "','" + fname + "','" + lname + "');\n"
			# print query			
			list_of_sections.append(query)


	f = open("Export_sections.sql", "w")
	f.writelines(list_of_sections)
	f.close()

	print s
	
if __name__ == "__main__":
	main()