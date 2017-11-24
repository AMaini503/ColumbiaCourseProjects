
# coding: utf-8

# In[ ]:


import numpy as np
import tensorflow as tf
import matplotlib.pyplot as plt
# get_ipython().run_line_magic('matplotlib', 'inline')
import glob
import copy
from time import time
import scipy.misc
import random
import sys

t1 = time()


# In[6]:


print(tf.__version__)  # for Python 2


# In[7]:


# TF order [batch, in_height, in_width, in_channels]
## opencv,scipy H W K


# In[35]:


# Functions to load data, DO NOT change these
def get_files(folder):
    """
    Given path to folder, returns list of files in it
    """
    filenames = [file for file in glob.glob(folder+'*/*')]
    filenames.sort()
    return filenames

def get_label(filepath, label2id):
    """
    Files are assumed to be labeled as: /path/to/file/999_frog.png
    Returns label for a filepath
    """
    tokens = filepath.split('/')
    label = tokens[-1].split('_')[1][:-4]
    if label in label2id:
        return label2id[label]
    else:
        sys.exit("Invalid label: " + label)
        
def get_labels(folder, label2id):
    """
    Returns vector of labels extracted from filenames of all files in folder
    :param folder: path to data folder
    :param label2id: mapping of text labels to numeric ids. (Eg: automobile -> 0)
    """
    files = get_files(folder)
    y = []
    for f in files:
        y.append(get_label(f,label2id))
    return np.array(y)


def one_hot(y, num_classes=10):
    """
    Converts each label index in y to vector with one_hot encoding
    """
    y_one_hot = np.zeros((y.shape[0], num_classes))
    for i in range(y.shape[0]):
        y_one_hot[i,y[i]]=1
    return y_one_hot.T

def get_label_mapping(label_file):
    """
    Returns mappings of label to index and index to label
    The input file has list of labels, each on a separate line.
    """
    with open(label_file, 'r') as f:
        id2label = f.readlines()
        id2label = [l.strip() for l in id2label]
    label2id = {}
    count = 0
    for label in id2label:
        label2id[label] = count
        count += 1
    return id2label, label2id

def get_images(folder):
    """
    returns numpy array of all samples in folder
    each column is a sample resized to 30x30 and flattened
    """
    files = get_files(folder)
    images = []
    count = 0
    X = np.zeros((len(files),32,32,3))
    for f in files:
        count += 1
        if count % 10000 == 0:
            print("Loaded {}/{}".format(count,len(files)))
        img_arr = scipy.misc.imread(f)
        #img_arr = img_arr.flatten() / 255.0
        img_arr = img_arr.astype(float)  #H,W,K
        images.append(img_arr)
        X[count-1,:,:,:] = img_arr[np.newaxis,:]   #  [batch, in_height, in_width, in_channels]


    return X

def get_train_data(data_root_path):
    """
    Return X and y
    """
    train_data_path = data_root_path + 'train'
    id2label, label2id = get_label_mapping(data_root_path+'labels.txt')
    print(label2id)
    X = get_images(train_data_path)
    y = get_labels(train_data_path, label2id)
    return X, y

def save_predictions(filename, y):
    """
    Dumps y into .npy file
    """
    np.save(filename, y)
    


# #rotates by 90,180,270
# def rotate_images(images, k):

#     rotated_images = map(lambda image: np.rot90(image, k), images)
#     rotated_images = np.array(rotated_images)

#     return rotated_images

# # (cw, ch) - size of the crop
# def crop_images(images, cw, ch):

#     ow,oh = images.shape[1],images.shape[2]

#     sx = (ow - cw)//2
#     sy = (oh - ch)//2

#     cropped_padded_images = map(lambda image: image[sx:sx+cw, sy:sy+ch, :], images)

#     pad_before_x = sx
#     pad_after_x = ow - cw - sx

#     pad_before_y = sy
#     pad_after_y = oh - ch - sy

#     cropped_padded_images = map(lambda image: np.lib.pad(image, ((pad_before_x, pad_after_x),(pad_before_y, pad_after_y),(0,0)), 'constant', constant_values=(0,0)), cropped_padded_images)
#     cropped_padded_images = np.array(cropped_padded_images)

#     return cropped_padded_images


def flip_images_lr(images): 
    
    flipped_images = map(lambda image: np.fliplr(image), images)
    flipped_images = np.array(flipped_images)
    
    return flipped_images

#rotates by an angle [-15,15]
def rotate_images(images):
    
    num_images = images.shape[0]
    ow,oh = images.shape[1], images.shape[2]

    #compute random rotation angles1
    rotation_angles = np.random.uniform(-15,15,size=(num_images,))

    #rotate the images, preserves size
    rotated_images = map(lambda (i,image): scipy.misc.imrotate(image, rotation_angles[i]), enumerate(images))
    rotated_images = np.array(rotated_images)

    # #resize the images to the original size
    # rotated_images = map(lambda image: scipy.misc.imresize(image, (ow, oh)), rotated_images)
    # rotated_images = np.array(rotated_images)
    return rotated_images


#crops 28 X 28 portion of the image and then resizes it to the original size
def random_crop_resize_images(images):
    ow,oh = images.shape[1],images.shape[2]
    num_images = images.shape[0]
    sx = np.random.randint(0, 5, size=(num_images, ))
    sy = np.random.randint(0, 5, size=(num_images, ))

    cropped_resized_images = map(lambda (i,image): image[sx[i]:sx[i]+28, sy[i]:sy[i]+28, :], enumerate(images))
    cropped_resized_images = map(lambda image: scipy.misc.imresize(image, (ow, oh)), cropped_resized_images)

    cropped_resized_images = np.array(cropped_resized_images)
    return cropped_resized_images


def add2end(X, y, images, label):
    
    #add the images to X
    X = np.concatenate((X,images), axis = 0)
    
    #add the labels to y
    num_images = images.shape[0]
    labels =  np.array([label] * num_images)
    y = np.concatenate((y,labels))
    
    return (X,y)
    
#txfms - list of strings that state what kind of transformations to use for images in X
# 1. fliplr - flip images from left to right
# 2. rotate - rotate the images by [0,1,2,3] * 90 degrees
# 3. all - apply all the above transformations

#frac - fraction of images in a clas to be used for transformation. Lies in [0,1]
#     - the same fraction is used for all the classes to avoid bias against any specific class
def augment(X, y, txfms, frac):
    #(batch_size, 32, 32, 3)
    all_labels = np.unique(y)
    for label in all_labels: 
        
        image_indices_with_this_label = (y == label)
        num_images = np.sum(image_indices_with_this_label)
        
        #selects fraction `frac` out of all the images with this class label
        num_images = int(num_images * frac)
        image_indices_with_this_label = np.random.randint(0, num_images, size=(num_images, ))
        images_with_this_label = X[image_indices_with_this_label, :, :, :]
        
        
        
        if "fliplr" in txfms: 
            
            #flips the given images and adds them to the end of the data set given
            flipped_images = flip_images_lr(images_with_this_label)
            (X, y) = add2end(X, y, flipped_images, label)


        #rotates the given images by 90, 180, 270
        if "rotate" in txfms:

            # #90 degrees
            # rotated_images = rotate_images(images_with_this_label, k = 1)

            # #rotate by 180 degrees and append
            # rotated_images = np.concatenate((rotated_images, rotate_images(images_with_this_label, k = 2)))

            # #rotate by 270 degrees and append
            # rotated_images = np.concatenate((rotated_images, rotate_images(images_with_this_label, k = 3)))            

            rotated_images = rotate_images(images_with_this_label)
            (X, y) = add2end(X, y, rotated_images, label)

        # #crops the center portion of the given images and pads them to the original size 28 X 28
        # if "crop&pad" in txfms:

        #     cropped_padded_images = crop_images(images_with_this_label, 28, 28)
        #     (X, y) = add2end(X, y, cropped_padded_images, label)

        #crops and resizes the image to original size
        if "crop&resize" in txfms: 
            cropped_resized_images = random_crop_resize_images(images_with_this_label)
            (X, y) = add2end(X, y, cropped_resized_images, label)
    
    return (X,y)
    
def get_batch(X, y, batch_size,list_,counter):
    """
    Return minibatch of samples and labels

    :param X, y: samples and corresponding labels
    :parma batch_size: minibatch size
    :returns: (tuple) X_batch, y_batch
    """
    idx = list_[counter:counter+batch_size]
    X_batch = X[idx,:,:,:]
    y_batch = y[idx]
    #X_batch = augment(X_batch)
    return X_batch, y_batch


# In[9]:


# Load the data
data_root_path = 'cifar10-hw1/'
X_train, y_train = get_train_data(data_root_path) # this may take a few minutes
X_test = get_images(data_root_path + 'test')
print('Data loading done')


# In[36]:

print "Data shapes before augmentation"
print X_train.shape
print y_train.shape
print X_test.shape


#data augmentation
print "Data shapes after augmentation - "
txfms = ["fliplr","rotate","crop&resize"]
X_train, y_train = augment(X_train, y_train, txfms, 0.1)
print X_train.shape
print y_train.shape


#number of samples per class = 5000
#number of samples used per transformation per class = frac * 5000
#number of samples per transformation = 5000 * frac * 10
#number of samples over n transformations = 5000 * frac  * 10 * n


# #testing if the images are actually transformed
# #saving the last 10 images for testing the code
# images = X_train[-10:,:,:,:]
# print "Saving images of shape"
# print images.shape


# for (i,image) in enumerate(images): 
#     scipy.misc.toimage(image, cmin=0, cmax=255).save('outfile_' + str(i) + '.jpg')
# # In[19]:

# sys.exit(0)

iters_max=20000
batch_size=100
split_ratio = 0.9
lr_ = 0.01
orig_full = range(len(y_train))
np.random.shuffle(orig_full)
split_idx = int((len(orig_full)*split_ratio))
orig_train = orig_full[:split_idx]
orig_val = orig_full[split_idx:]
counter = 0
train_idx = []


#extend the data by epochs
epocs = (iters_max*batch_size)/len(orig_train) + 1
for i in range(epocs):
    np.random.shuffle(orig_train)
    train_idx.extend(orig_train)


# In[8]:


# conv1
images = tf.placeholder(tf.float32, shape=[None, 32,32,3])
gt = tf.placeholder(tf.float32, shape=[None, 10])
lr = tf.placeholder(tf.float32, shape=())
with tf.variable_scope('conv1') as scope:
    init = tf.truncated_normal_initializer(stddev=1e-2, dtype=tf.float32)
    kernel = tf.get_variable('weights', shape=[5, 5, 3, 64], initializer=init, dtype=tf.float32)
    conv = tf.nn.conv2d(images, kernel, [1, 1, 1, 1], padding='SAME')
    biases = tf.get_variable('biases', shape=[64], initializer=tf.constant_initializer(0.0), dtype=tf.float32)
    pre_activation = tf.nn.bias_add(conv, biases)
    conv1 = tf.nn.relu(pre_activation, name=scope.name)
    
# pool1
pool1 = tf.nn.max_pool(conv1, ksize=[1, 3, 3, 1], strides=[1, 2, 2, 1],
                     padding='SAME', name='pool1')
norm1 = tf.nn.lrn(pool1, 4, bias=1.0, alpha=0.001 / 9.0, beta=0.75,
                    name='norm1') 
# conv2
with tf.variable_scope('conv2') as scope:
    init = tf.truncated_normal_initializer(stddev=1e-2, dtype=tf.float32)
    kernel = tf.get_variable('weights', shape=[5, 5, 64, 64], initializer=init, dtype=tf.float32)
    conv = tf.nn.conv2d(norm1, kernel, [1, 1, 1, 1], padding='SAME')
    biases = tf.get_variable('biases', shape=[64], initializer=tf.constant_initializer(0.0), dtype=tf.float32)
    pre_activation = tf.nn.bias_add(conv, biases)
    conv2 = tf.nn.relu(pre_activation, name=scope.name)
    
pool2 = tf.nn.max_pool(conv2, ksize=[1, 3, 3, 1], strides=[1, 2, 2, 1],
                   padding='SAME', name='pool2')
norm2 = tf.nn.lrn(pool2, 4, bias=1.0, alpha=0.001 / 9.0, beta=0.75,
                    name='norm2') 
# conv3
# with tf.variable_scope('conv3') as scope:
#     init = tf.truncated_normal_initializer(stddev=1e-2, dtype=tf.float32)
#     kernel = tf.get_variable('weights', shape=[3, 3, 64, 64], initializer=init, dtype=tf.float32)
#     conv = tf.nn.conv2d(norm2, kernel, [1, 1, 1, 1], padding='SAME')
#     biases = tf.get_variable('biases', shape=[64], initializer=tf.constant_initializer(0.0), dtype=tf.float32)
#     pre_activation = tf.nn.bias_add(conv, biases)
#     conv3 = tf.nn.relu(pre_activation, name=scope.name)
    
# pool3 = tf.nn.max_pool(conv3, ksize=[1, 3, 3, 1], strides=[1, 2, 2, 1],
#                      padding='SAME', name='pool3')
# norm3 = tf.nn.lrn(pool3, 4, bias=1.0, alpha=0.001 / 9.0, beta=0.75,
#                     name='norm3')
# Fully connected layer    
with tf.variable_scope('FC1') as scope:
    reshape = tf.reshape(norm2, [batch_size, -1])
    init = tf.truncated_normal_initializer(stddev=1/4096.0, dtype=tf.float32)
    weights = tf.get_variable('weights', shape=[4096,10], initializer=init, dtype=tf.float32)
    biases = tf.get_variable('biases', shape=[10], initializer=tf.constant_initializer(0.0), dtype=tf.float32)
    before_softmax = tf.add(tf.matmul(reshape, weights), biases, name=scope.name)
    
# Fully connected layer    
# with tf.variable_scope('FC2') as scope:
#     #reshape = pool2
#     reshape = tf.reshape(fc1, [batch_size, -1])
#     #dim = reshape.get_shape()[1].value
#     #print type(dim),dim
#     init = tf.truncated_normal_initializer(stddev=1/128.0, dtype=tf.float32)
#     weights = tf.get_variable('weights', shape=[128,10], initializer=init, dtype=tf.float32)
#     biases = tf.get_variable('biases', shape=[10], initializer=tf.constant_initializer(0.0), dtype=tf.float32)
#     before_softmax = tf.add(tf.matmul(reshape, weights), biases, name=scope.name)


# In[9]:


loss = tf.nn.softmax_cross_entropy_with_logits(logits = before_softmax, labels = gt)
loss = tf.reduce_mean(loss)
correct_prediction_df = tf.equal(tf.argmax(before_softmax,1), tf.argmax(gt,1))
accuracy_df = tf.reduce_mean(tf.cast(correct_prediction_df, tf.float32))
train_acc = 0


# In[10]:


#tf.gradients(yvars,xvars)
#tf.summary.histogram('', x)
tf.summary.scalar('loss',loss)
tf.summary.scalar('train_acc',train_acc)
conv1_grad = tf.gradients(loss, [conv1])[0]
conv2_grad = tf.gradients(loss, [conv2])[0]
#conv3_grad = tf.gradients(loss, [conv3])[0]
fc1_grad = tf.gradients(loss, [before_softmax])[0]
tf.summary.histogram('conv1_grad',conv1_grad)
tf.summary.histogram('conv2_grad',conv2_grad)
#tf.summary.histogram('conv3_grad',conv3_grad)
tf.summary.histogram('fc1_grad',fc1_grad)
merged = tf.summary.merge_all()
train_writer = tf.summary.FileWriter('tensorboard/')


# In[11]:


train_step = tf.train.GradientDescentOptimizer(lr).minimize(loss)


# In[ ]:


with  tf.Session() as sess:
    tf.global_variables_initializer().run()
    for iter in range(iters_max):
        X_batch, y_batch = get_batch( X_train, y_train, batch_size,train_idx,counter)
        counter += batch_size
        y_batch = one_hot(y_batch).transpose((1,0))
        #loss.run(feed_dict={images: X_batch, gt: y_batch})
        if iter%10000 == 1:
            lr_/=10.0
        _, loss_npy,summary = sess.run([train_step,loss,merged],feed_dict={images: X_batch, gt: y_batch,lr:lr_})
        

        if iter%100==0:
            print iter, loss_npy
        if iter%500==0:
            test_counter = 0
            train_counter = 0
            acc_val  = []
            acc_train  = []
            while test_counter < len(orig_val):  # check if we need to add +1 or -1 REMOVE this BUG
                X_batch, y_batch = get_batch( X_train, y_train, batch_size,orig_val,test_counter)
                y_batch = one_hot(y_batch).transpose((1,0))
                test_counter+=batch_size
                acc_val.append(sess.run([accuracy_df],feed_dict={images: X_batch, gt: y_batch,lr:lr_}))
            while train_counter < len(orig_train):  # check if we need to add +1 or -1 REMOVE this BUG
                X_batch, y_batch = get_batch( X_train, y_train, batch_size,orig_train,train_counter)
                y_batch = one_hot(y_batch).transpose((1,0))
                train_counter+=batch_size
                acc_train.append(sess.run([accuracy_df],feed_dict={images: X_batch, gt: y_batch, lr:lr_}))
            print 'val accuracy ', np.mean(np.asarray(acc_val)),'train accuracy ', np.mean(np.asarray(acc_train))
            train_acc = np.mean(np.asarray(acc_train))
        train_writer.add_summary(summary, iter)
            

