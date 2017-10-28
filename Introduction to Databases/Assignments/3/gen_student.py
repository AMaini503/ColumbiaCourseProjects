import csv
import mysql.connector
from mysql.connector import Error
import numpy as np
def connect():
	try:
		conn = mysql.connector.connect(host='localhost', database='hw3', user='root', password='password')

		if conn.is_connected():
			print('Connected to MySQL Databsae')
			return conn, conn.cursor()
	except Error as e:
		print(e)

def select_query(cursor, query_text):
	cursor.execute(query_text)

	rows = cursor.fetchall()
	return rows
def insert_query(conn, cursor, query_text):
	try:
		cursor.execute(query_text)
		conn.commit()
	except Error as e:
		print(e)
def call_stored_proc(cursor, proc_name, args):
	try: 
		cursor.callproc(proc_name, args)
	except Error as e:
		print(e)

if __name__ == '__main__':
	conn, cursor = connect()

	with open('MOCK_DATA.csv', 'r') as csvfile:
		reader = csv.reader(csvfile)

		#skip the header
		next(reader, None)

		#insert first 200 as students

		#get department names
		dept_names = select_query(cursor, "SELECT DISTINCT dname from department")
		dept_names = map(lambda x: x[0], dept_names)
		num_depts = len(dept_names)
		
		print dept_names
		print num_depts

		#inserts 10 * num_depts students
		for dept in dept_names:
			

			#insert 10 students in this department
			count = 0
			for row in reader:
				
				year = np.random.randint(1990, 2018)
				
				row.append(dept)
				row.append(str(year))
				
				call_stored_proc(cursor, 'insertStudent', row)
				
				count = count + 1
				if(count == 10):
					break

		num_remaining_students = 200 - 10 * num_depts
		count = 0
		for row in reader:

			dept = dept_names[np.random.randint(0, num_depts)]
			year = np.random.randint(1990, 2018)

			row.append(dept)
			row.append(str(year))

			call_stored_proc(cursor, 'insertStudent', row)

			count = count + 1
			if(count  == num_remaining_students):
				break

		

		#inserts the last 50 persons as faculty
		titles = ['Assistant Professor', 'Adjunct Professor', 'Senior Prof']
		pay_grades = range(1,6)

		for dept in dept_names:
			count = 0
			for row in reader:
				title = titles[np.random.randint(0, len(titles))]
				pay_grade = pay_grades[np.random.randint(0, len(pay_grades))]

				row.append(dept)
				row.append(pay_grade)
				row.append(title)

				call_stored_proc(cursor, 'insertFaculty', row)
				count =  count + 1
				if count == 3:
					break

		num_remaining_faculty = 50 - 3 * num_depts
		count = 0
		for row in reader:

			dept = dept_names[np.random.randint(0, num_depts)]
			title = titles[np.random.randint(0, len(titles))]
			pay_grade = pay_grades[np.random.randint(0, len(pay_grades))]

			row.append(dept)
			row.append(pay_grade)
			row.append(title)

			call_stored_proc(cursor, 'insertFaculty', row)
			count = count + 1
			if count == num_remaining_faculty:
				break

		conn.commit()