import re
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
				result = find_query_obj.execute()
				print result
			else:
				insert_query_obj = None
		

	#########################################################
	customers = Table("customers", "customers.csv")
	orders = Table("orders", "orders.csv")

	customers.buildIndex("\"CustomerID\"")
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
	def __init__(self, raw_query):
		pass
	def execute():
		pass
class FindQuery:
	
	def __init__(self, table_obj, aux_info):
		self.table_obj = table_obj
		self.aux_info = aux_info
		self.ParseAuxInfo()
	
	def ParseAuxInfo(self): 
		kv_pairs_list = self.aux_info.split(",")
		# print kv_pairs_list
		self.query_col_names = map(lambda pair_string: pair_string.split("=")[0].strip(), kv_pairs_list)
		self.query_col_values = map(lambda pair_string: pair_string.split("=")[1].strip(), kv_pairs_list)

	def execute(self):
		
		#Remember every attribute has string value, so enclose the value in double quotes
		indexed_columns_names_for_table = self.table_obj.getIndexedColumnsNames()

		query_col_names_set = set(self.query_col_names)

		indexed_query_col_names_set = indexed_columns_names_for_table & query_col_names_set
		non_indexed_query_col_names_set = query_col_names_set - indexed_query_col_names_set

		# print self.query_col_names
		# print self.query_col_values
		# print indexed_columns_names_for_table
		# return []

		#First find records using indices
		records_found_using_indices = set(range(0, self.table_obj.getRowCount()))

		for col_name in indexed_query_col_names_set:
			index_for_this_col = self.table_obj.getIndexOn(col_name).getArray()
			occurences_for_this_col = [i for i,x in enumerate(self.query_col_names)]
			values_for_this_col = [self.query_col_values[i] for i in occurences_for_this_col]

			for val in values_for_this_col:
				records_with_this_val = index_for_this_col[val]
				records_found_using_indices = records_found_using_indices & records_with_this_val
				if len(records_found_using_indices) == 0:
					return records_found_using_indices


		return self.table_obj.getRowsIndexedBy(records_found_using_indices)

		

class Index: 
	def __init__(self, colname, hashed_array):
		self.colname = colname
		self.hashed_array = hashed_array
	def getArray(self):
		return self.hashed_array
	def getColName(self):
		return self.colname

class Table: 
	def __init__(self, tname, filename):
		self.name = tname
		self.indices = []
		self.indexed_columns_names = set()
		self.filename = filename

		self.initTableData()

	def initTableData(self):
		f = open(self.filename, 'r')
		lines = f.readlines()

		#remove newline character
		lines = list(map(lambda line: line.strip(), lines))
		
		#set the headerline
		self.header_line = lines[0]
		# print header_line

		self.rows = list(filter(lambda line: line != '', lines[1:]))
		# print len(lines)

		self.allcols = self.header_line.split(",")

		#use this to validate the number of values in insert command
		self.num_cols = len(self.allcols)
		
		# print self.allcols

	def buildIndex(self, colname):
		
		#add colname to the list of indexed columns
		#self.indexed_columns.append(colname)
		self.indexed_columns_names.add(colname)

		index_of_col = self.allcols.index(colname)
		# print index_of_col

		all_col_values = map(lambda row: row.split(",")[index_of_col], self.rows)

		#check if the index needs to be primary o

		# print all_col_values
		# print len(all_col_values)
		
		hashed_index_on_col = dict()
		for i,val in enumerate(all_col_values):
			if val not in hashed_index_on_col:
				hashed_index_on_col[val] = set()
				
			hashed_index_on_col[val].add(i)	
		
		# print hashed_index_on_col.keys()
		
		# print hashed_index_on_col[key]
		index_obj = Index(colname, hashed_index_on_col)
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

if __name__ == "__main__":
	start()