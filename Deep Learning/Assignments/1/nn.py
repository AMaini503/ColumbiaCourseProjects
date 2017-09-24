import numpy as np
import matplotlib.pyplot as plt
from numpy import linalg as LA

class NeuralNet:

	class Architecture:
		def __init__():
			pass

	def __test_sigmoid(self):
		matrix = np.array([[1,2],[3,4]])
		expected_output = np.array([0.73105857863,0.88079707797,0.95257412682,0.98201379003])
		calculated_output = self.__sigmoid(matrix)
		calculated_output = np.ndarray.flatten(calculated_output)

		error = np.absolute(calculated_output - expected_output)
		return not np.any(error > 1e-5)
	def __test_tanh(self):
		matrix = np.array([[1,2],[3,4]])
		expected_output = np.array([0.76159415595,0.96402758007,0.99505475368,0.99932929973])
		calculated_output = self.__tanh(matrix)
		calculated_output = np.ndarray.flatten(calculated_output)
		error = np.absolute(calculated_output - expected_output)

		return not np.any(error > 1e-5)

	def __test_weight_init(self):
		self.num_units_in_layers = [100, 50, 150, 200, 250]
		self.__weight_init()

		# values = np.ndarray.flatten(self.weight_matrices[0])
		# plt.hist(values)
		# plt.show()
		L = self.num_layers - 1
		for i in range(1,L+1):
			w_i = self.weight_matrices[i-1]
			if w_i.shape != (self.num_units_in_layers[i-1], self.num_units_in_layers[i]):
				return False

		return True
	def __test_bias_init(self):
		self.num_units_in_layers = [100, 50, 150, 200, 250]
		self.__bias_init()

		L = self.num_layers - 1
		for i in range(1,L+1):
			b_i = self.bias_units[i]

			if b_i.shape[0] != self.num_units_in_layers[i]:
				return False
		return True
	def __test_forwardProp(self):

		self.num_units_in_layers = (2,2,1)

		w_1 = np.matrix([[1,2],[3,4]])
		w_2 = np.matrix([[1],[2]])

		self.weight_matrices = []
		self.weight_matrices.append(np.empty((1,1)))
		self.weight_matrices.append(w_1)
		self.weight_matrices.append(w_2)

		b_1 = np.array([2, 3])
		b_2 = np.array([1])

		self.bias_units = []
		self.bias_units.append(np.array([]))
		self.bias_units.append(b_1)
		self.bias_units.append(b_2)
		

		x1 = np.array([1,2])
		x2 = np.array([2,1])
		x3 = np.array([0,0])
		x4 = np.array([-1,1])

		X = np.matrix([x1,x2,x3,x4])

		# print X
		# print self.bias_units

		(calculated_a_,calculated_z_) = self.__forwardProp(X)

		expected_z_1 = np.matrix([[9,13],[7,11],[2,3],[4,5]])
		expected_z_2 = np.matrix([[3.9998706],[3.9990553],[3.7857945],[3.9686278]])
		expected_z_ = [np.empty((1,1)),expected_z_1,expected_z_2]

		expected_a_1 = np.matrix([[0.9998766,0.999997],[0.9990889,0.9999832],[0.880797,0.952574],[0.9820138,0.993307]])
		expected_a_2 = np.matrix([[0.982,0.98199,0.9778,0.98145]])
		expected_a_ = [X,expected_a_1,expected_a_2]

		L = self.num_layers - 1
		for l in range(1,L+1):
			calculated_a_l = calculated_a_[l]
			calculated_z_l = calculated_z_[l]

			expected_a_l = expected_a_[l]
			expected_z_l = expected_z_[l]

			error_in_a_l = np.absolute(expected_a_l - calculated_a_l)
			error_in_z_l = np.absolute(expected_z_l - calculated_z_l)

			if np.any(error_in_a_l > 1e-3) or np.any(error_in_z_l > 1e-3):
				return False
		return True

	def __test_BackProp(self):
		self.num_units_in_layers = (2,2,1)

		w_1 = np.matrix([[1,2],[3,4]])
		w_2 = np.matrix([[1],[2]])

		self.weight_matrices = []
		self.weight_matrices.append(np.empty((1,1)))
		self.weight_matrices.append(w_1)
		self.weight_matrices.append(w_2)

		b_1 = np.array([2, 3])
		b_2 = np.array([1])

		self.bias_units = []
		self.bias_units.append(np.array([]))
		self.bias_units.append(b_1)
		self.bias_units.append(b_2)
		

		x1 = np.array([1,2])
		# x2 = np.array([2,1])
		# x3 = np.array([0,0])
		# x4 = np.array([-1,1])

		X = np.matrix([x1])
		Y = np.matrix([[5]])

		(calculated_a_, caculated_z_) = self.__forwardProp(X)

		(calculated_delta_weights, calculated_delta_bias) = self.__backProp(X,Y)

		# print len(calculated_delta_weights[1]), len(calculated_delta_weights[2])

		expected_delta_weights = []
		expected_delta_weights.append([])

		expected_delta_bias = []
		expected_delta_bias.append([])

		layer_1_delta_weight_matrices = []
		delta_w1_x1 = np.matrix([[-8.757e-6,-3.2086e-7],[-1.7514e-5,-6.4172e-7]])
		layer_1_delta_weight_matrices.append(delta_w1_x1)

		layer_2_delta_weight_matrices = []
		delta_w2_x1 = np.matrix([[-0.070968],[-0.070970]])
		layer_2_delta_weight_matrices.append(delta_w2_x1)

		layer_1_delta_bias = []
		delta_b1_x1 = np.array([-8.757e-6,-3.2086e-7])
		layer_1_delta_bias.append(delta_b1_x1)

		layer_2_delta_bias = []
		delta_b2_x1 = np.array([-0.07097756])
		layer_2_delta_bias.append(delta_b2_x1)

		expected_delta_weights.append(layer_1_delta_weight_matrices)
		expected_delta_weights.append(layer_2_delta_weight_matrices)

		expected_delta_bias.append(layer_1_delta_bias)
		expected_delta_bias.append(layer_2_delta_bias)

		L = self.num_layers - 1
		num_samples = X.shape[0]

		print calculated_delta_weights
		print calculated_delta_bias

		for l in range(1,L+1):
			for i in range(0,num_samples):
				# print l
				calculated_delta_weight_matrix_xm = calculated_delta_weights[l][i]
				expected_delta_weight_matrix_xm = expected_delta_weights[l][i]

				calculated_delta_bias_xm = calculated_delta_bias[l][i]
				expected_delta_bias_xm = expected_delta_bias[l][i]

				error_in_delta_weight_matrix = np.absolute(calculated_delta_weight_matrix_xm - expected_delta_weight_matrix_xm)
				error_in_delta_bias = np.absolute(calculated_delta_bias_xm - expected_delta_bias_xm)
				if np.any(error_in_delta_weight_matrix > 1e-4) or np.any(error_in_delta_bias > 1e-4):
					# print calculated_delta_weight_matrix_xm
					# print expected_delta_weight_matrix_xm
					return False
		return True


	#will be used on an input vector and not matrix
	#testing: Done
	def __sigmoid(self, x):
		return 1.0 / (1.0 + np.exp(-1 * x))
	def __tanh(self, x):
		return (np.exp(2 * x) - 1) / (np.exp(2 * x) + 1)

	def __sigmoid_prime(self, x):
		return self.__sigmoid(x) * (1 - self.__sigmoid(x))
	def __sigmoid_prime_mat(self, matrix):
		return np.apply_along_axis(lambda x: self.__sigmoid_prime(x), 0, matrix)

	def __sigmoid_prime_vector(self, vector):
		return np.apply_along_axis(lambda x: self.__sigmoid_prime(x), 0, vector)
	def __tanh_mat(self, matrix):
		return np.apply_along_axis(self.__tanh, 0, matrix)
	def __sigmoid_mat(self, matrix):
		return np.apply_along_axis(self.__sigmoid, 0, matrix)

	#testing: Done	
	def __param_init(self):
		self.__weight_init()
		self.__bias_init()

	#testing: Done
	def __weight_init(self):
		
		if self.param_init_type == 'Gaussian':
			mean = 0
			var = 1
			self.weight_matrices.append(np.empty((1,1)))
			L = self.num_layers - 1
			for i in range(1,L + 1):
				w_i = np.random.normal(mean,var,size = (self.num_units_in_layers[i-1],self.num_units_in_layers[i]))
				
				self.weight_matrices.append(w_i)
	#testing: Done
	def __bias_init(self):
		if self.param_init_type == 'Gaussian':
			mean = 0
			var = 1
			self.bias_units.append(np.empty((1,1)))
			L = self.num_layers - 1
			for  i in range(1,L + 1):
				b_i = np.random.normal(mean, var, size = self.num_units_in_layers[i])
				self.bias_units.append(b_i)

	
	def test(self):
		if self.__test_sigmoid():
			print "__sigmoid and __sigmoid_mat passed tests"
		if self.__test_tanh():
			print "__tanh and __tanh_mat passed tests"
		if self.__test_weight_init():
			print "__weight_init passed tests"
		if self.__test_bias_init():
			print "__bias_init passed tests"

		if self.__test_forwardProp():
			print "__forwardProp passed tests"
		if self.__test_BackProp():
			print "__backProp passed tests"


	#num_units_in_layers includes the size of the input layer too
	def __init__(self, param_init_type = 'Gaussian', num_units_in_layers = (2,100,1), activation_function = 'tanh'):
		
		self.weight_matrices = []
		self.bias_units = []
		self.param_init_type = param_init_type
		self.num_layers = len(num_units_in_layers)
		#running tests by default, add an if condition later on	
		self.test()

		#if tests passed init functions can be used
		self.__param_init()

	#testing: Done
	def __forwardProp(self, X_mini_batch):
		
		#activations is a list of matrices
		#each matrix (activations[i]) is of size: (m,n_i)
		#matrix consists of activations for the samples stacked row-wise

		a_ = []
		z_ = []

		L = self.num_layers - 1
		num_samples = X_mini_batch.shape[0]
		a_ = []
		a_.append(X_mini_batch)
		z_.append(np.empty((1,1)))

		# l = 1..L
		A_l_minus_1 = a_[0]
		A_l = None # size = (m,nl)
		W_l = None # size = (nl-1,nl)
		B_l = None # size = (m,nl)
		Z_l = None # size = (m,nl)
		for l in range(1,L + 1):

			W_l = self.weight_matrices[l]
			b_l = self.bias_units[l]
			B_l = np.matrix([b_l] * num_samples)
			Z_l = A_l_minus_1 * W_l + B_l
			A_l = self.__sigmoid_mat(Z_l)

			# print A_l

			a_.append(A_l)
			z_.append(Z_l)
			A_l_minus_1 = A_l

		self.a_ = a_
		self.z_ = z_

		return (a_,z_)
	
	def __backProp(self, X_mini_batch, Y_mini_batch):

		#X : matrix of size (m,d) where m - #samples and d - #dimensions
		#Y : vector of size (m,1) where m - #samples

		a_ = self.a_
		z_ = self.z_

		num_layers = self.num_layers
		num_samples = X_mini_batch.shape[0]

		L = num_layers - 1
		delta_bias = [ [] for l in range(0,L+1) ]
		delta_weights = [ [] for l in range(0,L+1) ]

		# print delta_weights
		# print delta_bias

		# 
		#delta_weights[l] - give the (sample wise) list of update matrices  for layer l
		#delta_weghts[l][i] - gives the weight update matrix for layer l by sample i
		
		for (i,x) in enumerate(X_mini_batch):
			y = Y_mini_batch[i]
			L = self.num_layers - 1
			y_cap = a_[L][i]

			d_a_l = y_cap - y
			
			for l in range(L,0,-1):


				z_l = z_[l][i]
				a_l = a_[l][i]


				d_z_l = np.multiply(d_a_l, self.__sigmoid_prime_mat(z_l))
				# print z_l
				a_l_minus_1 = a_[l-1][i]
				d_w_l = a_l_minus_1.T * d_z_l
				d_b_l = d_z_l


				# print "l: " + str(l)
				# print len(delta_weights[l])
				# print len(delta_bias[l])


				delta_weights[l].append(d_w_l)
				delta_bias[l].append(d_b_l)

				# print delta_weights

				# print len(delta_weights[l])
				# print len(delta_bias[l])

				#init for next iteration
				w_l = self.weight_matrices[l]
				
				d_a_l = d_z_l * w_l.T
				# print d_a_l
				# z_l = z_[l-1][i]
				# a_l = a_[l-1][i]

				
		return (delta_weights, delta_bias)

	#uses stochastic gradient descent as of now
	#regressor
	def trainOn(X,Y):

		num_samples = X.shape[0]

		#change this to accept from user
		mini_batch_size = self.mini_batch_size
		
		#process sequentiallly on all the training data
		X_mini_batches = [ X[index: index + mini_batch_size] for index in range(0,num_samples,mini_batch_size) ]
		Y_mini_batch = [Y[index: index + mini_batch_size] for index in range(0,num_samples,mini_batch_size)]
		
		eta = 0.03

		for X_mini_batch in X_mini_batches:
			(a_,z_) = __forwardProp(X_mini_batch)
			(delta_weights, delta_bias_units) = __backProp(X_mini_batch, Y_mini_batch, a_, z_)

			#update the network using this batch's updates
			L = self.num_layers
			this_batch_size = X_mini_batch.shape[0]
			for l in range(1,L):
				summed_weight_updates_for_layer_l = reduce(lambda x, y: x + y, delta_weights[l])

				#add assert for this_batch_size = len(delta_weights[l])
				average_weight_update = (1.0/this_batch_size) * (summed_weight_updates_for_layer_l)

				summed_bias_updates_for_layer_l = reduce(lambda x,y: x + y, delta_bias_units[l])

				#add assertion
				average_bias_update = (1.0/this_batch_size) * (summed_bias_updates_for_layer_l)

				#update rules
				self.weight_matrices[l] = self.weight_matrices[l] - eta * average_weight_update
				self.bias_units[l] = self.bias_units[l] - eta * average_bias_update
	
	def predictOnSet(X,Y):
		if not isinstance(x,np.ndarray):
			x = np.matrix(x)
			y = np.matrix(y)
		(a_,z_) = __forwardProp(x,y)
	def predictOn(x,y):
		if not isinstance(x,np.ndarray):
			x = np.matrix(x)
			y = np.matrix(y)

		(a_,z_) = __forwardProp(x,y)

		L = self.num_layers
		output = a_z[L][0]

		print "Loss: ", averageLoss(np.matrix(y_cap), np.matrix(y))
		print "Predicted Value: " + str(output) + ", Actual Value: " + str(y)

	def averageLoss(Y_cap, Y):
		m = Y_cap.shape[0]
		
		sample_wise_error = map(lambda (y_cap,y): MSELoss(y_cap,y), zip(Y_cap, Y))
		summed_error = reduce(lambda x,y: x+y, sample_wise_error)
		
		return (1.0/m) * summed_error


	def MSELoss(y,y_cap):
		return 0.5 * LA.norm(y - y_cap)



if __name__ == "__main__":
	nn = NeuralNet()

		
