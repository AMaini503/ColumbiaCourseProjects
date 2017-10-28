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
def insert_query(cursor, query_text):
	try:
		cursor.execute(query_text)
	except Error as e:
		print(e)
def call_stored_proc(cursor, proc_name, args):
	try: 
		cursor.callproc(proc_name, args)
	except Error as e:
		print(e)
def sql_string(text):
	return "'" +  str(text) + "'"
if __name__ == '__main__':
	conn, cursor = connect()

	#10 courses per department
	num_courses_per_dept = 20
	dept = select_query(cursor, "SELECT DISTINCT code,dname from department");
	dept_codes = map(lambda code: code[0], dept)
	dept_names = map(lambda code: code[1], dept)

	faculty_codes = ['BC', 'C', 'E', 'F','G', 'V', 'W', 'X']
	levels = range(10)
	numbers = np.random.randint(100,999, size=(num_courses_per_dept * len(dept_codes)))
	number_index = 0
	for (dept_code, dept_name) in zip(dept_codes, dept_names):
		

		for title_index in range(1,21):
			query_text = "INSERT INTO courses(`dept_code`,`faculty_code`,`level`,`number`,`title`,`description`) VALUES(";
			faculty_code = faculty_codes[np.random.randint(0,len(faculty_codes))]
			level = levels[np.random.randint(0, len(levels))]
			number = numbers[number_index]
			number_index = number_index + 1
			title = dept_name + "-" + str(title_index)	
			row = [sql_string(dept_code), sql_string(faculty_code), sql_string(level), str(number), sql_string(title), sql_string('lorem ipsum')]
			query_text = query_text + ','.join(row) + ")"
			insert_query(cursor, query_text)

	conn.commit()

