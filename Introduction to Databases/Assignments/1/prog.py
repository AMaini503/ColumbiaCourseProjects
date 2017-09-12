import re
from prettytable import PrettyTable
import csv
from StringIO import StringIO
from bisect import bisect
def GetQueryObj(raw_query_text):
	raw_query_text = raw_query_text.strip()

	parts = raw_query_text.split(" ")
	q_type = ""
	if parts[0].lower() == "find" : 
		obj = FindQuery(raw_query_text)
		q_type = "find"
	elif parts[0].lower() == "insert":
		obj = InsertQuery(raw_query_text)
		q_type = "insert"

	return (q_type, obj)


def start(): 

	def ParseQuery():
		pattern = re.compile(r"(find|insert)\s+([A-za-z0-9]+)\s+(.*)", re.I)
		match = pattern.match(raw_query_text)

		if match:
			q_type = match.group(1)
			tname = match.group(2)
			aux_info = match.group(3)

			return (q_type.lower(), tname.lower(), aux_info)
		else:
			return "Invalid Query"

	def HandleQuery(raw_query_text):
		result = ParseQuery()
		
		if result == "Invalid Query":
			print result
		else :
			q_type = result[0]
			tname = result[1]
			aux_info = result[2]
			table_obj = customers if tname == "customers" else orders
			
			if q_type == "find":
				find_query_obj = FindQuery(table_obj, aux_info)
				find_query_obj.execute()
			#would always be an insert because invalid query already handled in parse
			else:
				insert_query_obj = InsertQuery(table_obj, aux_info)
				insert_query_obj.execute()
		

	#########################################################
	customers = Table("customers", "customers.csv")
	orders = Table("orders", "orders.csv")

	# customers.buildIndex("CustomerID")
	# customers.buildIndex("ContactTitle")
	customers.setPrimaryKeyAs("CustomerID")
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
			return
		else:
			primary_key_col_name = self.table_obj.getPrimaryKeyCol()
			if primary_key_col_name != None:

				#add a check to verify that user has entered a value for primary key 
				primary_key_col_index = self.table_obj.getAllColNames().index(primary_key_col_name)

				if csv_array[primary_key_col_index] == "": 
					print "FAILED: Primary Key attribute must have a non-empty value"
					return

				all_rows_in_table = self.table_obj.getAllRows()
				all_values_in_primary_key_col = map(lambda row_string: ParseCSVString2Array(row_string)[primary_key_col_index], all_rows_in_table)

				if csv_array[primary_key_col_index] in all_values_in_primary_key_col:
					print "A record with the same value for primary key exists"
					table = PrettyTable(self.table_obj.getAllColNames())
					exisiting_row_index = all_values_in_primary_key_col.index(csv_array[primary_key_col_index])
					table.add_row(ParseCSVString2Array(all_rows_in_table[exisiting_row_index]))
					print table
					return
				else:
					#insert the record at appropriate position
					insertion_index_for_new_record = bisect(all_values_in_primary_key_col, csv_array[primary_key_col_index])
					
					#inserting row in the in-memory image of records
					#table takes care of the updating the index
					self.table_obj.insertRowAt(csv_val_string, insertion_index_for_new_record)
					print "Row added successfully"

					#start the actual write to the file

class FindQuery:
	
	def __init__(self, table_obj, aux_info):
		self.table_obj = table_obj
		self.aux_info = aux_info
		self.ParseAuxInfo()
	
	def ParseAuxInfo(self): 
		#kv_pairs_list = self.aux_info.split(",")
		kv_pairs_list = ParseCSVString2Array(self.aux_info)
		# print kv_pairs_list

		self.query_col_names = map(lambda pair_string: pair_string.split("=")[0].strip(), kv_pairs_list)
		#removing double quotes if any
		self.query_col_names = map(lambda query_col_name: removeDQuotes(query_col_name), self.query_col_names)

		self.query_col_values = map(lambda pair_string: pair_string.split("=")[1].strip(), kv_pairs_list)
		#remove the double quotes if any
		self.query_col_values = map(lambda query_col_value: removeDQuotes(query_col_value), self.query_col_values)


		# print self.query_col_names
		# print self.query_col_values
	def execute(self):
		
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
		else: 
			#no records to process
			print "0 records found"
		

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

	def buildIndex(self, colname):
		
		#add colname to the list of indexed columns
		#self.indexed_columns.append(colname)
		self.indexed_columns_names.add(colname)

		index_of_col = self.all_col_names.index(colname)
		# print index_of_col

		all_col_values = map(lambda row: row.split(",")[index_of_col], self.rows)
		#remove double quotes before building hash
		all_col_values = map(lambda col_value: removeDQuotes(col_value), all_col_values)

		#check if the index needs to be primary o

		# print all_col_values
		# print len(all_col_values)
		
		hashed_index_on_col = dict()
		for i,val in enumerate(all_col_values):
			if val not in hashed_index_on_col:
				# hashed_index_on_col[val] = []
				hashed_index_on_col[val] = set()
				
			# hashed_index_on_col[val].append(i)	
			hashed_index_on_col[val].add(i)
		
		# print hashed_index_on_col.keys()
		
		# print hashed_index_on_col[key]
		index_obj = Index(colname, hashed_index_on_col, self)
		self.indices.append(index_obj)
		
		# print self.getIndexOn(colname).getArray()
		# return index_on_col

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
	def setPrimaryKeyAs(self, col_name):
		self.primary_key_col_name = col_name
	def getPrimaryKeyCol(self):
		return self.primary_key_col_name

	def updateIndicesWith(self, row_string, row_index):
		#update the index too
		for index_obj in self.indices:

			#find col_index to get the column value which serves as the key in the hashed array
			col_index = self.getAllColNames().index(index_obj.getColName())
			hash_key_col_value = ParseCSVString2Array(row_string)[col_index]
			hash_val_row_index = row_index

			#valid to use because the new row has been inserted already
			all_row_indices = range(0,self.getRowCount())
			_indices_that_need_increment = filter(lambda _row_index: _row_index >= row_index, all_row_indices)

			index_obj.updateIndexWith(hash_key_col_value, row_index, _indices_that_need_increment)

	#row_string has been stripped of newline character
	def insertRowAt(self, row_string, row_index):
		self.rows.insert(row_index, row_string)
		self.updateIndicesWith(row_string, row_index)
		self.writeRowsToFile(row_index)
		
		#important here because old line lengths need to be used first
		self.line_lengths.insert(row_index, len(row_string + "\n"))

	#only need to write the rows that start at the new_row_index
	def writeRowsToFile(self, new_row_index):
		
		#by default rows don't have newline characters at the end, so it is added at the end of each line
		nl_terminated_rows_in_strings = map(lambda row_string: row_string if row_string[-1] == "\n" else row_string + "\n", self.rows_in_strings[new_row_index:])
		
		#seek to the desired byte location
		offset = sum(self.line_lengths[0:new_row_index + 1])
		# print offset
		# print self.line_leng	ths[0:new_row_index + 1]
		self.f.seek(offset)
		self.f.truncate()
		# self.f_updated.truncate(offset)
		
		self.f.writelines(nl_terminated_rows_in_strings)
		# self.f_updated.close()
		
		

if __name__ == "__main__":
	start()