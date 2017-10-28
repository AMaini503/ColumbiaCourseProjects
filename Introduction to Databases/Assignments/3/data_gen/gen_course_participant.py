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
def sql_string(text):
	return "'" +  str(text) + "'"
if __name__ == '__main__':
	conn, cursor = connect()

	

	conn.commit()
					