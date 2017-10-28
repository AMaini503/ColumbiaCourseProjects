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

def sql_string(text):
	return "'" +  str(text) + "'"

def insert_prereqs_tree(courses, dependencies):
	for dependency in dependencies:
		course, prereq = courses[dependency[0] - 1], courses[dependency[1] - 1]
		query_text = "INSERT INTO course_prereqs VALUES(" + ','.join([sql_string(course), sql_string(prereq)]) + ")"
		print query_text
		insert_query(cursor, query_text)

def insert_prereqs(courses):
	first_tree_order = [(1,2), (1,4),(1,10),(4,10)]
	second_tree_order = [(3,5),(3,6),(3,7),(3,9),(3,8),(5,7),(5,9),(6,8)]

	insert_prereqs_tree(courses, first_tree_order)
	insert_prereqs_tree(courses, second_tree_order)

if __name__ == '__main__':
	conn, cursor = connect()
	dept_codes = select_query(cursor, "SELECT DISTINCT code FROM department")
	dept_codes = map(lambda code: code[0], dept_codes)
	for dept_code in dept_codes:
		this_dept_courses = select_query(cursor, "SELECT course_id FROM courses WHERE dept_code = " + sql_string(dept_code))
		this_dept_courses = map(lambda course: course[0], this_dept_courses)
		print len(this_dept_courses)
		first_list_courses = this_dept_courses[0:10]
		second_list_courses = this_dept_courses[10:20]

		insert_prereqs(first_list_courses)
		insert_prereqs(second_list_courses)

	conn.commit()

