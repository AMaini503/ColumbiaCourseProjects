import re
from prettytable import PrettyTable
from operator import itemgetter
import csv
from StringIO import StringIO
from bisect import bisect
import sys, os
from mysql.connector import MySQLConnection, Error
import mysql.connector

class GlobalScope:
	def __init__(self):
		self.map_tname_to_obj = dict()
	def getAllTNames(self):
		return self.map_tname_to_obj.keys()
	def getTObjFor(self, tname):
		if tname in self.map_tname_to_obj:
			return self.map_tname_to_obj[tname]
		else:
			print "Table " + tname + " doesn't exist"
	def addTable(self, table_file_name):

		if table_file_name not in self.map_tname_to_obj:
			table_name = table_file_name.split(".")[0]
			table_obj = Table(table_name, table_file_name)

			self.map_tname_to_obj[table_name] = table_obj

	def tableExists(self, tname): 
		return tname in self.map_tname_to_obj

def ParseQuery(raw_query_text):
	pattern_for_DM_queries = re.compile(r"(find|insert)\s+([A-Za-z0-9]+)\s+(.*)", re.I)
	match_for_DM_queries = pattern_for_DM_queries.match(raw_query_text)

	pattern_for_constraint_query = re.compile(r"apply\s+unique\s+to\s+([A-Za-z0-9]+)\.([A-Za-z0-9]+)")
	match_for_constraint_query = pattern_for_constraint_query.match(raw_query_text)

	pattern_for_pk_query = re.compile(r"set\s+([A-Za-z0-9]+)\.([A-Za-z0-9]+)\s+as\s+pk")
	match_for_pk_query = pattern_for_pk_query.match(raw_query_text)

	pattern_for_add_table_query = re.compile(r"add\s+table\s+for\s+(.+)")
	match_for_add_table_query = pattern_for_add_table_query.match(raw_query_text)

	pattern_for_aio_query = re.compile(r"build\s+index\s+on\s+([A-Za-z0-9]+)\.([A-Za-z0-9]+)")
	match_for_aio_query = pattern_for_aio_query.match(raw_query_text)

	if match_for_DM_queries:
		q_type = match_for_DM_queries.group(1)
		tname = match_for_DM_queries.group(2)
		aux_info = match_for_DM_queries.group(3)

		#check for existence of table
		if gscope.tableExists(tname):
			return (q_type.lower(), tname.lower(), aux_info)
		else:
			print "Table " + tname + " doesn't exist"
			return "error"
	elif match_for_constraint_query: 
		table_name = match_for_constraint_query.group(1)
		col_name = match_for_constraint_query.group(2)

		q_type = "unique constraint"
		tname = table_name
		aux_info = col_name

		if gscope.tableExists(tname):
			return (q_type, tname, aux_info)
		else:
			print "Table " + tname + " doesn't exist"
			return "error"

	elif match_for_pk_query:
		q_type = "pk"
		table_name = match_for_pk_query.group(1)
		col_name = match_for_pk_query.group(2)

		if gscope.tableExists(table_name):
			return (q_type, table_name, col_name)
		else:
			print "Table " + table_name + " doesn't exist"
			return "error"
		
	elif match_for_add_table_query:
		q_type = "add table"
		aux_info = match_for_add_table_query.group(1)
		return (q_type, None, aux_info)
	elif match_for_aio_query:
		q_type = "build index"
		table_name = match_for_aio_query.group(1)
		col_name = match_for_aio_query.group(2)

		if gscope.tableExists(table_name):
			return (q_type, table_name, col_name)
		else:
			print "Table " + table_name + " doesn't exist"
			return "error"

	elif raw_query_text.lower().strip() == "show tables":
		q_type = "show tables"
		return (q_type, None, None)
	else:
		return "Invalid Query"

def HandleQuery(raw_query_text):
	result = ParseQuery(raw_query_text)
	
	if result == "Invalid Query":
		print result
	else :

		if result == "error": 
			return

		q_type = result[0]
		tname = result[1]
		aux_info = result[2]
		
		if q_type == "find":
			table_obj = gscope.getTObjFor(tname)
			find_query_obj = FindQuery(table_obj, aux_info)
			result = find_query_obj.execute()
			return result
		elif q_type  == "insert":
			table_obj = gscope.getTObjFor(tname)
			insert_query_obj = InsertQuery(table_obj, aux_info)
			return_val = insert_query_obj.execute()
			return return_val
		elif q_type == "unique constraint": #handle unique here
			table_name = tname
			uc_col_name = aux_info
			unique_constraint_query = ConstraintQuery(gscope.getTObjFor(table_name), uc_col_name)
			unique_constraint_query.execute()
		elif q_type == "pk":
			table_name = tname
			pk_col_name = aux_info
			pk_query = PKQuery(gscope.getTObjFor(table_name), pk_col_name)
			pk_query.execute()
		elif q_type == "show tables": 
			table = PrettyTable(["Table name"])
			map(lambda tname: table.add_row([tname]), gscope.getAllTNames())
			print table
		elif q_type == "add table": 
			table_file_name = aux_info
			addtff_query = AddTFFQuery(table_file_name)
			addtff_query.execute()
		elif q_type == "build index":
			table_name = tname
			col_name = aux_info

			if gscope.tableExists(table_name): 
				aio_query = BuildIndexOnQuery(gscope.getTObjFor(table_name), col_name)
				aio_query.execute()



def start(): 

	
	#first add tables from the command line
	for table_file_name  in sys.argv[1:]:
		addtff_query = AddTFFQuery(table_file_name)
		addtff_query.execute()



	#########################################################
	# customers = Table("customers", "customers.csv")
	# orders = Table("orders", "orders.csv")

	# customers.buildIndex("CustomerID")
	# customers.buildIndex("ContactTitle")
	# customers.setPrimaryKeyAs("CustomerID")
	# orders.buildIndex("\"OrderID\"")

	#########################################################
	prompt_symbol = ">> "
	sig_exit = False
	while(not sig_exit):

		raw_query_text = raw_input(prompt_symbol)
		raw_query_text = raw_query_text.strip()

		if(raw_query_text.lower() == 'exit'):
			sig_exit = True
		else:
			HandleQuery(raw_query_text)
# add table for file
class AddTFFQuery:
	def __init__(self, table_file_name):
		self.table_file_name = table_file_name
	def execute(self):
		if os.path.isfile(self.table_file_name):
			gscope.addTable(self.table_file_name)
			print "Table for " + self.table_file_name + " added successfully"
		else:
			print "File " + self.table_file_name + " doesn't exist"
#Add index on a column of a table
class BuildIndexOnQuery:
	def __init__(self, table_obj, col_name): 
		self.table_obj = table_obj
		self.col_name = col_name
	def execute(self): 
		result = self.table_obj.validateColNames([self.col_name])
		if result["return_code"] == "pass":
			self.table_obj.buildIndex(self.col_name)
		else:
			print result["err_msg"]
class InsertQuery:
	def __init__(self, table_obj, aux_info):

		#needed because this object holds the in-memory image of the data
		#update the rows of this object
		self.table_obj = table_obj
		self.aux_info = aux_info
	
	def execute(self):

		#remove the round brackets from the end
		csv_val_string = self.aux_info[1:-1]

		csv_array = ParseCSVString2Array(csv_val_string)
		num_values_in_query = len(csv_array)
		num_cols_in_table = len(self.table_obj.getAllColNames())

		#1st check is to validate whether user entered a value for all the columns
		if num_values_in_query < num_cols_in_table:
			print "FAILED: #values < #columns"
			return "Fail"
		else:
			primary_key_col_name = self.table_obj.getPrimaryKeyCol()
			if primary_key_col_name != None:

				#add a check to verify that user has entered a value for primary key 
				# primary_key_col_index = self.table_obj.getAllColNames().index(primary_key_col_name)

				#add a check to verify that user has entered a value for primary key
				result = self.passesPKNEConstraint(csv_array)

				if result["return_code"] != "Pass":
					print result["err_msg"]
					return "Fail"

				#verify that PK given doesn't exist in the table apriori
				result = self.passesPKNDConstraint(csv_array)
				if result["return_code"] != "Pass":
					print result["err_msg"]
					#instance of pretty table
					print result["table"]
					return "Fail"
				# if csv_array[primary_key_col_index] == "": 
					# print "FAILED: Primary Key attribute must have a non-empty value"
					# return

				# all_rows_in_table = self.table_obj.getAllRows()
				# all_values_in_primary_key_col = map(lambda row_string: ParseCSVString2Array(row_string)[primary_key_col_index], all_rows_in_table)

				# if csv_array[primary_key_col_index] in all_values_in_primary_key_col:
				# 	print "A record with the same value for primary key exists"
				# 	table = PrettyTable(self.table_obj.getAllColNames())
				# 	exisiting_row_index = all_values_in_primary_key_col.index(csv_array[primary_key_col_index])
				# 	table.add_row(ParseCSVString2Array(all_rows_in_table[exisiting_row_index]))
				# 	print table
				# 	return
				# else:

			result = self.passesUniqueConstraints(csv_array)
			if result["return_code"] != "Pass": 
				print result["err_msg"]
				return "Fail"

			#insert the record at appropriate position
			if primary_key_col_name != None:
				all_values_in_primary_key_col = self.table_obj.getAllValuesForColumn(primary_key_col_name)
				insertion_index_for_new_record = bisect(all_values_in_primary_key_col, csv_array[primary_key_col_index])
			else:
				insertion_index_for_new_record = len(self.table_obj.getAllRows())
			
			#inserting row in the in-memory image of records
			#table takes care of the updating the index
			#writing to file taken care of in insertRowAt
			self.table_obj.insertRowAt(csv_val_string, insertion_index_for_new_record)
			print "Row added successfully"
			return "Pass"

	def passesPKNEConstraint(self, csv_array):
		return self.table_obj.passesPKNEConstraint(csv_array)
	def passesPKNDConstraint(self, csv_array):
		return self.table_obj.passesPKNDConstraint(csv_val_string)
	def passesUniqueConstraints(self, csv_array):
		return self.table_obj.passesUniqueConstraints(csv_array)

class FindQuery:
	
	def __init__(self, table_obj, aux_info):
		self.table_obj = table_obj
		self.aux_info = aux_info
		self.ParseAuxInfo()
	
	def ParseAuxInfo(self): 
		#kv_pairs_list = self.aux_info.split(",")
		kv_pairs_list = ParseCSVString2Array(self.aux_info)
		print kv_pairs_list

		self.query_col_names = map(lambda pair_string: pair_string.split("=")[0].strip(), kv_pairs_list)
		#removing double quotes if any
		self.query_col_names = map(lambda query_col_name: removeDQuotes(query_col_name), self.query_col_names)

		self.query_col_values = map(lambda pair_string: pair_string.split("=")[1].strip(), kv_pairs_list)
		#remove the double quotes if any
		self.query_col_values = map(lambda query_col_value: removeDQuotes(query_col_value), self.query_col_values)



	def execute(self):
		
		result = self.table_obj.validateColNames(self.query_col_names)
		if not result["return_code"] == "pass":
			print result["err_msg"]
			return


		#Remember every attribute has string value, so enclose the value in double quotes
		indexed_columns_names_for_table = self.table_obj.getIndexedColumnsNames()

		query_col_names_set = set(self.query_col_names)

		indexed_query_col_names_set = indexed_columns_names_for_table & query_col_names_set
		non_indexed_query_col_names_set = query_col_names_set - indexed_query_col_names_set

		# print self.query_col_names
		# print self.query_col_values
		# print indexed_query_col_names_set
		# print non_indexed_query_col_names_set
		# return []

		#Bad Init
		num_records_in_result = 0
		records_in_final_result = None

		#First find records using indices
		records_found_using_indices = set(range(0, self.table_obj.getRowCount()))

		for col_name in indexed_query_col_names_set:
			index_for_this_col = self.table_obj.getIndexOn(col_name).getArray()

			#indices where this column occurs in aux_info in query
			occurences_for_this_col = [i for i,query_col_name in enumerate(self.query_col_names) if query_col_name == col_name]

			values_for_this_col = [self.query_col_values[i] for i in occurences_for_this_col]
			# print values_for_this_col

			for val in values_for_this_col:

				if val in index_for_this_col:
					records_with_this_val = index_for_this_col[val]
				else:
					records_with_this_val = set()
				records_found_using_indices = records_found_using_indices & records_with_this_val
				if len(records_found_using_indices) == 0:
					break

			if len(records_found_using_indices) == 0:
				break

		num_records_using_indices = len(records_found_using_indices)
		#print str(num_records_using_indices) + " records found using indices"


		if num_records_using_indices  != 0:
			
			#num_records_in_result = num_records_using_indices
			#set nature is retained because set operations are to follow in the code below
			#sorted_records_found_using_indices = list(records_found_using_indices)
			#sorted_records_found_using_indices.sort()

			#records_in_final_result = self.table_obj.getRowsIndexedBy(sorted_records_found_using_indices)

			#finding records using the non-indexed columns
			##############################################
			records_found_using_non_indices = set(range(0, self.table_obj.getRowCount()))
			for col_name in non_indexed_query_col_names_set:
				occurences_for_this_col = [i for i,query_col_name in enumerate(self.query_col_names) if query_col_name == col_name]
				values_for_this_col = [self.query_col_values[i] for i in occurences_for_this_col]
				# print self.table_obj.getAllColNames()
				serial_index_for_this_col_in_rows = self.table_obj.getAllColNames().index(col_name)

				all_rows_in_table = self.table_obj.getAllRows()
				for val in values_for_this_col:

					#avoid any additional processing of double quotes
					# print ParseCSVString2Array(all_rows_in_table[75])

					# print serial_index_for_this_col_in_rows
					# print ParseCSVString2Array(all_rows_in_table[i], csv.QUOTE_NONE)[7]
					# print val
					records_with_this_val = set([i for i,row_string in enumerate(all_rows_in_table) if  ParseCSVString2Array(row_string)[serial_index_for_this_col_in_rows] == val])

					# print records_with_this_val
					records_found_using_non_indices = records_found_using_non_indices & records_with_this_val

					if len(records_found_using_non_indices) == 0:
						break

				if len(records_found_using_non_indices) == 0:
						break

			final_set_of_indices = records_found_using_indices & records_found_using_non_indices

			sorted_final_list_of_indices = list(final_set_of_indices)
			sorted_final_list_of_indices.sort()

			num_records_in_result = len(final_set_of_indices)
			print str(num_records_in_result) + " records found"

			if num_records_in_result > 0:
				records_in_final_result = self.table_obj.getRowsIndexedBy(sorted_final_list_of_indices)
				table = PrettyTable(self.table_obj.getAllColNames())
				for row_string in records_in_final_result:
					table.add_row(ParseCSVString2Array(row_string))
				print table

				return records_in_final_result
			else: 
				return []
		else: 
			#no records to process
			print "0 records found"
			return []
class ConstraintQuery:
	def __init__(self, table_obj, col_name):
		self.table_obj = table_obj
		self.col_name = col_name
	def execute(self):
		result = self.table_obj.validateColNames([self.col_name])
		if result["return_code"] == "pass":
			self.table_obj.addUniqueOn(self.col_name)
		else: 
			print result["err_msg"]

class PKQuery:
	def __init__(self, table_obj, col_name):
		self.table_obj = table_obj
		self.col_name = col_name
	def execute(self):
		result = self.table_obj.validateColNames([self.col_name])
		if result["return_code"] == "pass":
			self.table_obj.setPrimaryKeyAs(self.col_name)
		else:
			print result["err_msg"]
#Index here is a map from a col_value to the set of row indices that have the "col_value" under colname attribute	
class Index: 
	def __init__(self, colname, hashed_array, table_obj):
		self.colname = colname
		self.hashed_array = hashed_array
		self.table_obj = table_obj
	def getArray(self):
		return self.hashed_array
	def getColName(self):
		return self.colname

	def updateIndexWith(self, hash_key_col_value, hash_val_row_index, _indices_that_need_increment):
		if hash_key_col_value not in self.hashed_array:
			self.hashed_array[hash_key_col_value] = set()
		
		#row_index for those records which are after this record needs to be incremented by 1
		all_hash_items = self.hashed_array.iteritems()

		for (_col_val, _row_index_set) in all_hash_items:

			_row_index_list = list(_row_index_set)

			#increment the row_index only if it belongs to the list passed as paramter to the function
			_updated_row_index_list = map(lambda _row_index: _row_index + 1 if _row_index in _indices_that_need_increment else _row_index, _row_index_list)

			self.hashed_array[_col_val] = set(_updated_row_index_list)

		self.hashed_array[hash_key_col_value].add(hash_val_row_index)

#removes the double quotes from the values in a query
def ParseCSVString2Array(string):
	f = StringIO(string)

	reader = csv.reader(f, delimiter=",", skipinitialspace=True)
	for row in reader:
		return row

	#comes here only if empty string
	return []

#removal is necessary because keys in hash and values in a query are processed without any quotes
def removeDQuotes(string):
	string = string.replace("\"", "")
	return string
class Table: 
	def __init__(self, tname, filename):
		self.name = tname
		#contains index objects
		self.indices = []
		self.indexed_columns_names = set()
		self.filename = filename
		self.primary_key_col_name = None
		self.unique_constrained_col_names = []

		#the file handle, Must be used within a function of table class
		self.f = None
		# self.f_updated = None #file handle is different for debugging purposes

		self.initTableData()

	# def __del__(self):
	# 	self.f.close()
	# 	self.f_updated.close()
	def initTableData(self):
		self.f = open(self.filename, 'rw+')
		
		# self.f_updated = open("./" + self.filename.split(".")[0] + "_updated.csv", 'rw+')
		lines = self.f.readlines()

		#create an array of line offsets, will be used in writing to the file (later)
		#update this when a new record is inserted
		self.line_lengths = [len(line) for line in lines]


		#remove newline character
		lines = list(map(lambda line: line.strip(), lines))
		
		#set the headerline
		self.header_line = lines[0]
		# print header_line

		#DEBUG#######################################
		# self.f_updated.write(self.header_line + "\n")
		#############################################

		self.rows = list(filter(lambda line: line != '', lines[1:]))
		self.rows_in_strings = self.rows
		# print len(lines)


		#self.all_col_names = self.header_line.split(",")
		self.all_col_names = ParseCSVString2Array(self.header_line)
		self.all_col_names = map(lambda col_name: removeDQuotes(col_name), self.all_col_names)
		# print self.all_col_names

		#use this to validate the number of values in insert command
		self.num_cols = len(self.all_col_names)
		
		# print self.allcols
	def refreshAllIndices(self):
		for i, index_obj in enumerate(self.indices):
			self.indices[i] = self.refreshIndex(index_obj.getColName())
	def refreshIndex(self, colname):

		# index_of_col = self.all_col_names.index(colname)

		# all_col_values = map(lambda row: row.split(",")[index_of_col], self.rows)
		#remove double quotes before building hash
		# all_col_values = map(lambda col_value: removeDQuotes(col_value), all_col_values)
		
		all_col_values = self.getAllValuesForColumn(colname)

		hashed_index_on_col = dict()
		for i,val in enumerate(all_col_values):
			if val not in hashed_index_on_col:
				
				hashed_index_on_col[val] = set()
				
			hashed_index_on_col[val].add(i)
		
		index_obj = Index(colname, hashed_index_on_col, self)

		print "Index for " + self.name + "." + colname + " refreshed successfully"
		return index_obj
	def buildIndex(self, colname):
		
		#add colname to the list of indexed columns
		#self.indexed_columns.append(colname)

		if colname in self.indexed_columns_names:	
			print "IGNORED: Index for " + colname + " already exists"
			return

		self.indexed_columns_names.add(colname)

		# col_index = self.getColIndex(colname)
		# print index_of_col

		# all_col_values = map(lambda row: row.split(",")[index_of_col], self.rows)
		#remove double quotes before building hash
		# all_col_values = map(lambda col_value: removeDQuotes(col_value), all_col_values)
		all_col_values = self.getAllValuesForColumn(colname)

		#check if the index needs to be primary o
		hashed_index_on_col = dict()
		for i,val in enumerate(all_col_values):
			if val not in hashed_index_on_col:
				
				hashed_index_on_col[val] = set()
				
			
			hashed_index_on_col[val].add(i)
		
		index_obj = Index(colname, hashed_index_on_col, self)
		self.indices.append(index_obj)

		print "Index for " + self.name + "." + colname + " built successfully"

	def getIndexOn(self, colname): 

		#ideally, indices should have a single index on a column
		index_obj = filter(lambda obj: obj.getColName() == colname, self.indices)[0]
		return index_obj

	def getIndexedColumnsNames(self):
		return self.indexed_columns_names

	def indexExistsOn(self, colname): 
		if colname in self.indexed_columns_names: 
			return True
		else: 
			return False
	def getRowCount(self):
		return len(self.rows)
	def getRowsIndexedBy(self, index_list):
		return [self.rows[index] for index in index_list]
	def getAllColNames(self):
		return self.all_col_names
	def getAllRows(self):
		return self.rows
	def getColIndex(self, col_name):
		all_col_names = self.getAllColNames()
		if col_name in all_col_names:
			return all_col_names.index(col_name)
		else:
			return "error"
	def setPrimaryKeyAs(self, col_name):
		#PK is also unique constrained
		if self.passesUniqueOn(col_name):
			self.primary_key_col_name = col_name

			#sort the rows according to primary key before building the index
			self.rows_as_lol = map(lambda row_string: ParseCSVString2Array(row_string) + [row_string], self.rows_in_strings)

			#sort the rows by pk
			self.rows_as_lol = sorted(self.rows_as_lol, key=itemgetter(self.getColIndex(self.primary_key_col_name)))

			#getting back the re-arranged rows
			self.rows_in_strings = self.rows = map(lambda row_as_lol: row_as_lol[-1], self.rows_as_lol)

			#refresh indices to use the new row indices
			self.refreshAllIndices()


			self.buildIndex(col_name)

			#writing re-arranged rows & header_line to file
			nl_terminated_rows_in_strings = map(lambda row_string: row_string + "\n", self.rows_in_strings)
			nl_terminated_rows_in_strings = [self.header_line + "\n"] + nl_terminated_rows_in_strings
			
			self.f.seek(0)
			self.f.truncate()
			self.f.writelines(nl_terminated_rows_in_strings)
			self.f.flush()
			os.fsync(self.f.fileno())

			#needs update because lines have rearranged
			self.line_lengths = [len(line) for line in nl_terminated_rows_in_strings]
			
			#this will obviously pass
			self.addUniqueOn(col_name)
		else:
			print "FAILED: Unique constraint must hold for PK"
	def getPrimaryKeyCol(self):
		return self.primary_key_col_name

	def updateIndicesWith(self, row_string, row_index):
		#update the index too
		for index_obj in self.indices:

			#find col_index to get the column value which serves as the key in the hashed array
			col_index = self.getColIndex(index_obj.getColName())
			hash_key_col_value = ParseCSVString2Array(row_string)[col_index]
			hash_val_row_index = row_index

			#valid to use because the new row has been inserted already
			all_row_indices = range(0,self.getRowCount())
			_indices_that_need_increment = filter(lambda _row_index: _row_index >= row_index, all_row_indices)

			index_obj.updateIndexWith(hash_key_col_value, row_index, _indices_that_need_increment)

	#row_string has been stripped of newline character
	def insertRowAt(self, row_string, row_index):
		self.rows.insert(row_index, row_string)
		# print row_string
		self.updateIndicesWith(row_string, row_index)
		self.writeRowsToFile(row_index)
		
		#important here because old line lengths need to be used first
		self.line_lengths.insert(row_index, len(row_string + "\n"))

	#only need to write the rows that start at the new_row_index
	def writeRowsToFile(self, new_row_index):
		
		#by default rows don't have newline characters at the end, so it is added at the end of each line
		nl_terminated_rows_in_strings = map(lambda row_string: row_string if row_string[-1] == "\n" else row_string + "\n", self.rows[new_row_index:])
		
		#seek to the desired byte location
		offset = sum(self.line_lengths[0:new_row_index + 1])
		# print self.line_leng	ths[0:new_row_index + 1]
		self.f.seek(offset)
		self.f.truncate()
		# self.f_updated.truncate(offset)
		
		# print nl_terminated_rows_in_strings
		self.f.writelines(nl_terminated_rows_in_strings)
		self.f.flush()
		os.fsync(self.f.fileno())
		# self.f_updated.close()

	def getAllValuesForColumn(self, col_name):
		#col_index = self.getAllColNames().index(col_name)
		col_index = self.getColIndex(col_name)
		all_col_values = map(lambda row_string: ParseCSVString2Array(row_string)[col_index], self.getAllRows())
		return all_col_values

	def passesPKNEConstraint(self, csv_array):

		#primary_key_col_index = self.getAllColNames().index(self.primary_key_col_name)
		primary_key_col_index = self.getColIndex(self.primary_key_col_name)
		primary_key_col_value_in_query = csv_val_string[self.primary_key_col_index]

		result = dict()
		success = {"return_code": "Pass", "err_msg": "FAILED: Primary Key attribute must have a NON NULL value"}
		failure = {"return_code": "Fail"}
		result["return_code"] =  success if primary_key_col_value_in_query != "" else failure

		return result
	def passesPKNDConstraint(self, csv_array):
		#primary_key_col_index = self.getAllColNames().index(self.primary_key_col_name)
		
		primary_key_col_index = self.getColIndex(self.primary_key_col_name)
		primary_key_col_value_in_query = csv_val_string[primary_key_col_index]

		all_col_values_for_pk = self.getAllValuesForColumn(self.primary_key_col_name)

		result = dict()
		if primary_key_col_value_in_query in all_col_values_for_pk:
			table = PrettyTable(self.table_obj.getAllColNames())
			table.add_row(csv_array)

			result["return_code"] = "Fail"
			result["err_msg"] = "FAILED: A record with the same value for primary key exists"
			result["table"] = table
		else: 
			result["status_code"] = "Pass"
		return result
	def passesUniqueConstraints(self, csv_array):

		success = {"return_code": "Pass"}

		#unqiue constrained col_name
		for uc_col_name in self.unique_constrained_col_names:
			#uc_col_index = self.getAllColNames().index(uc_col_name)
			uc_col_index = self.getColIndex(uc_col_name)
			col_value_in_query = csv_array[uc_col_index]
			if self.checkValueExistsFor(uc_col_name, col_value_in_query):
				failure = dict()
				failure["return_code"] = "Fail"
				failure["err_msg"] = "FAILED: The given record violates UNIQUE on " + uc_col_name
				return failure
		return success

	def checkValueExistsFor(self, col_name, col_value):
		all_col_values = self.getAllValuesForColumn(col_name)

		return col_value in all_col_values
	def passesUniqueOn(self, col_name):

		col_index = self.getAllColNames().index(col_name)
		all_col_values = map(lambda row_string: ParseCSVString2Array(row_string)[col_index], self.getAllRows())

		return len(all_col_values) == len(set(all_col_values))
	def addUniqueOn(self, col_name):
		if col_name in self.unique_constrained_col_names:
			print "IGNORED: Constraint already applied"
		#check if this column actually has unique values
		elif not self.passesUniqueOn(col_name):
			print "FAILED: Column has duplicate values"
		else:
			self.unique_constrained_col_names.append(col_name)
			print "UNIQUE contraint applied to " + col_name
	def validateColNames(self, col_names_list):
		
		for col_name in col_names_list:
			if col_name not in self.getAllColNames():
				failure = {"return_code": "error", "err_msg": "FAILED: " + col_name + " doesn't belong to " + self.name}
				return failure

		success = {"return_code": "pass"}
		return success

def test_find():
	def init():
		conn = mysql.connector.connect(host='localhost',
                                       database='hw1',
                                       user='root',
                                       password='password')

		return (conn, conn.cursor())
	def executeSQLSelectQuery(cursor, query):
		try: 
			cursor.execute(query)
			rows = cursor.fetchall()
			#list of tuples
			return rows
		except Error as e:
			print(e)
	def executeSQLInsertQuery(conn, cursor, query):
		try: 
			cursor.execute(query)
			conn.commit()
			return "Pass"
		except Error as e:
			print (e)
			return "Fail"
	def equivalent(result_from_prog, result_from_sql):
		if len(result_from_prog) != len(result_from_sql):
			print "Different number of records produced"
			return False

		#Both have zero number of records, tis a valid equivalence
		if len(result_from_prog) == 0:
			return True

		#CustomerID can act as a sort key
		sorted_result_from_prog = sorted(result_from_prog, key=itemgetter(0))
		sorted_result_from_sql = sorted(result_from_sql, key=itemgetter(0))


		#element to element correspondence check
		equality_checks = map(lambda (i,rp): tuple(map(lambda x: str(x), rp)) == tuple(map(lambda x: str(x), sorted_result_from_sql[i])), enumerate(sorted_result_from_prog))
		failed_checks = filter(lambda (i, check_val): check_val == False, enumerate(equality_checks))

		if len(failed_checks) > 0:
			print "Records that disagree are: "
			print failed_checks
			print "Disagreements on: "
			for (row_index, eval_val) in failed_checks:
				inconsistent_cols = filter( lambda (col_index, col_val): sorted_result_from_prog[row_index][col_index] != sorted_result_from_sql[row_index][col_index], enumerate(sorted_result_from_prog))
				inconsistent_cols = [x[0] for x in inconsistent_cols]
				print [sorted_result_from_prog[i] for i in inconsistent_cols]
				print [sorted_result_from_sql[i] for  i in inconsistent_cols]
			return False
		return True
	######################################################

	HandleQuery("add table for customers.csv")
	HandleQuery("add table for orders.csv")

	(conn, cursor) = init()
	queries_file_name = sys.argv[2]
	
	f = open(queries_file_name, "r")

	lines = f.readlines()

	#remove newline characters at the end
	lines = map(lambda line: line.strip(), lines)
	

	#remove any empty lines
	# lines = filter(lambda line: line != "", lines)
	
	count = len(lines)/2

	ind_query_for_prog = 0
	ind_query_for_sql = 1
	
	while(count > 0):
		query_for_prog = lines[ind_query_for_prog]
		query_for_sql = lines[ind_query_for_sql]

		
		q_type = query_for_prog.split(" ")[0]
		if q_type == "find":

			result_from_prog_in_strings = HandleQuery(query_for_prog)
			result_from_prog = map(lambda row_string: ParseCSVString2Array(row_string), result_from_prog_in_strings)


			result_from_sql = executeSQLSelectQuery(cursor, query_for_sql)

			if not equivalent(result_from_prog, result_from_sql):
				print "Different results for: "
				print query_for_prog
				print query_for_sql
				return
		elif q_type == "insert":
			return_val_prog = HandleQuery(query_for_prog)
			return_val_sql = executeSQLInsertQuery(conn, cursor, query_for_sql)

			if return_val_prog != return_val_sql:
				print "Different return values for insertions: "
				print query_for_prog
				print query_for_sql
				return

		count = count - 1
		ind_query_for_prog = ind_query_for_prog + 2
		ind_query_for_sql = ind_query_for_sql + 2


if __name__ == "__main__":

	global gscope
	gscope = GlobalScope()

	if sys.argv[1] == "testfind":
		test_find()
	else:
		start()