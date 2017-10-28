import random
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

	# #sections per course  in [1,5]
	course_ids = select_query(cursor, "SELECT DISTINCT course_id FROM courses")
	course_ids = map(lambda cid: cid[0], course_ids)

	years = range(1990,2018)
	call_no = 1
	for course_id in course_ids:

		num_years = np.random.randint(1,len(years))
		this_course_years = random.sample(years, num_years)

		for year in this_course_years:
			case = np.random.randint(1,3)

			#insert into spring semester only
			if case == 1:
				

				#sections >= 1 and <= 4
				num_sections = np.random.randint(1,5)
				enrollment_limit = np.random.randint(2,11)
				for section_no in range(1,num_sections + 1):

					#make the _call_no a CHAR(5)s
					_call_no = str(call_no)
					_call_no = _call_no.zfill(5)

					call_no = call_no + 1

					row = [sql_string(_call_no), sql_string(course_id), sql_string(section_no), str(year), sql_string('Spring'), str(enrollment_limit)]
					query_text = "INSERT INTO sections(call_no,course_id,section_no,year,semester,enrollment_limit) VALUES(" + ','.join(row) +  ")"
					insert_query(cursor, query_text)
					print query_text

					


			#insert into fall semester only	
			if case == 2:
				

				#sections >= 1 and <= 4
				num_sections = np.random.randint(1,5)
				enrollment_limit = np.random.randint(2,11)
				for section_no in range(1,num_sections + 1):

					#make the _call_no a CHAR(5)s
					_call_no = str(call_no)
					_call_no = _call_no.zfill(5)

					call_no = call_no + 1

					row = [sql_string(_call_no), sql_string(course_id), sql_string(section_no), str(year), sql_string('Fall'), str(enrollment_limit)]
					query_text = "INSERT INTO sections(call_no,course_id,section_no,year,semester,enrollment_limit) VALUES(" + ','.join(row) +  ")"
					print query_text
					insert_query(cursor, query_text)

					

			if case == 3:

				#sections >= 1 and <= 4
				num_sections = np.random.randint(1,5)
				enrollment_limit = np.random.randint(2,11) 
				for section_no in range(1,num_sections + 1):

					#make the _call_no a CHAR(5)s
					_call_no = str(call_no)
					_call_no = _call_no.zfill(5)

					call_no = call_no + 1

					row = [sql_string(_call_no), sql_string(course_id), sql_string(section_no), str(year), sql_string('Spring'), str(enrollment_limit)]
					query_text = "INSERT INTO sections(call_no,course_id,section_no,year,semester,enrollment_limit) VALUES(" + ','.join(row) +  ")"
					print query_text
					insert_query(cursor, query_text)
					

				#sections >= 1 and <= 4
				num_sections = np.random.randint(1,5)
				enrollment_limit = np.random.randint(2,11) 
				for section_no in range(1,num_sections + 1):

					#make the _call_no a CHAR(5)s
					_call_no = str(call_no)
					_call_no = _call_no.zfill(5)

					call_no = call_no + 1

					row = [sql_string(_call_no), sql_string(course_id), sql_string(section_no), str(year), sql_string('Fall'), str(enrollment_limit)]
					query_text = "INSERT INTO sections(call_no,course_id,section_no,year,semester,enrollment_limit) VALUES(" + ','.join(row) +  ")"
					print query_text
					insert_query(cursor, query_text)

	conn.commit()
					