from mysql.connector import MySQLConnection, Error
import mysql.connector
from operator import itemgetter
import sys
def init():
	conn = mysql.connector.connect(host='localhost',
                                       database='hw1',
                                       user='root',
                                       password='password')

	return (conn, conn.cursor())
def executeQuery(cursor, query):
	try: 
		cursor.execute(query)
		rows = cursor.fetchall()

		rows = sorted(rows, key=itemgetter(1))
		print rows
	except Error as e:
		print(e)

if __name__ == "__main__":
	(conn, cursor) = init()
	while True:
		query = raw_input(">> ")
		executeQuery(cursor, query)



