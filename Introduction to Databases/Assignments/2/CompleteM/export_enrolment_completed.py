import mysql.connector
from mysql.connector import Error
import numpy as np

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

def executeSQLInsert(query, cursor):
	try:
		cursor.execute(query)
		conn.commit()
	except Error as e:
		print(e)

def main():
	
	(conn, cursor) = init()

	#go by enrolling the student in a course, adding prereqs to the completed courses
	query = "SELECT * FROM Student"
	all_students = executeSQLSelect(query, cursor)

	query = "SELECT CourseID,FullName FROM Course"
	all_courses = executeSQLSelect(query, cursor)

	map_course_id_to_prereq_records = dict()
	for course in all_courses:
		map_course_id_to_prereq_records[course] = []

	query = "SELECT CourseID,CourseName,PrereqCourseID, PrereqCourseName FROM Prerequisite"
	all_records = executeSQLSelect(query, cursor)

	for record in all_records:
		map_course_id_to_prereq_records[record[0:2]].append(record[2:4]) 

	list_of_inserts = []

	possible__pass_grades = ['A','B','C']

	for student in all_students:

		#each student must enrol in exactly 2 courses at least one from his department
		#find out which courses this student should enrol in

		courses_to_enrol_for = []

		while True:
			case_type = np.random.randint(low = 0, high = 2)
			student_dept_id = student[6]

			query = "SELECT CourseID, CourseName from Offered_by where DeptID = " + str(student_dept_id) + ";"
			all_dept_courses = executeSQLSelect(query, cursor)

			query = "SELECT CourseID, CourseName from Offered_by where DeptID <> " + str(student_dept_id) + ";"
			all_non_dept_courses = executeSQLSelect(query, cursor)

			random_indices = None

			courses_to_enrol_for = []
			preqs = []
			if case_type == 0: #both are dept courses
				num_courses = 0

				while num_courses != 2:
					random_indices = np.random.randint(low = 0, high = len(all_dept_courses), size = 2)
					random_indices = list(set(random_indices))
					num_courses = len(random_indices)

				courses_to_enrol_for = [all_dept_courses[x] for x in random_indices]

			elif case_type == 1:
				dept_course_index = np.random.randint(low = 0, high = len(all_dept_courses))
				non_dept_course_index = np.random.randint(low = 0, high = len(all_non_dept_courses))

				courses_to_enrol_for = [all_dept_courses[dept_course_index], all_non_dept_courses[non_dept_course_index]]

			preqs = map_course_id_to_prereq_records[courses_to_enrol_for[0]]
			preqs.extend(map_course_id_to_prereq_records[courses_to_enrol_for[1]])

			intersection = list(set(courses_to_enrol_for) & set(preqs))
			if len(intersection) == 0:
				break


		# num_courses = 0
		# random_indices = None

		# while num_courses != 2:
		# 	random_indices = np.random.randint(low = 0, high = len(all_courses), size = 2)
		# 	random_indices = list(set(random_indices))
		# 	num_courses = len(random_indices)

		#courses are known now
		# courses_to_enrol_for = [all_courses[x] for x in random_indices]

		for course_to_enrol_for in courses_to_enrol_for:
			(cid, cname) = course_to_enrol_for

			#get the sections for this course
			query = "SELECT CourseID, CourseName, SectionNumber from Sections Where CourseID='" + cid + "'"
			all_sections = executeSQLSelect(query, cursor)

			#randomly select a section
			random_index = np.random.randint(low = 0, high = len(all_sections))

			section_to_enrol_for = all_sections[random_index]

			cid = section_to_enrol_for[0]
			cname = section_to_enrol_for[1]
			snum = section_to_enrol_for[2]

			sid = student[0]
			sfname = student[1]
			slname = student[2]

			query = "INSERT INTO Has_enrolled_in(`StudentID`,`StudentFName`,`StudentLName`,`CourseID`,`CourseName`,`SectionNumber`) VALUES('" + sid + "','" + sfname + "','" + slname + "','" + cid + "','" + cname + "'," + str(snum) + ");\n"
			print query
			list_of_inserts.append(query)

		#also get the prereqs completed
		preqs = set(map_course_id_to_prereq_records[course_to_enrol_for])
		for preq in preqs:
			preq_cid = preq[0]
			preq_cname = preq[1]

			#get all the sections for this preq
			query = "SELECT CourseID, CourseName, SectionNumber from Sections WHERE CourseID='" + preq_cid + "'"
			all_sections_for_this_preq = executeSQLSelect(query, cursor)

			random_index = np.random.randint(low = 0, high = len(all_sections_for_this_preq))

			section_to_enrol_for = all_sections_for_this_preq[random_index]

			preq_snum = section_to_enrol_for[2]

			grade = possible__pass_grades[np.random.randint(low = 0, high = len(possible__pass_grades))]

			query = "INSERT INTO Has_completed(`StudentID`,`StudentFName`,`StudentLName`,`CourseID`,`CourseName`,`SectionNumber`,`Grade`) VALUES('" + sid + "','" + sfname + "','" + slname + "','" + preq_cid + "','" + preq_cname + "'," + str(preq_snum) + ",'" + str(grade) + "');\n"

			print query

			list_of_inserts.append(query)
	f = open("export_enrolment_completed.sql","w")
	f.writelines(list_of_inserts)
	f.close()


if __name__ == "__main__":
	main()