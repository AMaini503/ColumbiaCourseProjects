from threading import Thread
import string
from time import sleep

def printd(args):
	for d in args:
		print d
		sleep(1)
def printl(args):
	for l in args:
		print l;
		sleep(1)

thread1 = Thread(target = printd, args = (list(range(1,11)), ))
thread2 = Thread(target = printl, args = (list(string.ascii_lowercase), ))

thread1.start()
thread2.start()