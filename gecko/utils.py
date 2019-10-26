import os
import sys
import eel
import yaml
import json

TEMPLATE_DIR = "gecko\\templates"
EXTENSION = ".gecko"

def newfile(root, name, content=""):
	with open(os.path.join(root, name), "w") as file:
		file.write(content)

def newfolder(root, name):
	os.mkdir(os.path.join(root, name))

def printhelp(args=[]):
	print("this is Gecko's help system")

def createtree(tree, root=""):
	for name in tree.keys():
		if type(tree[name]) is dict:
			newfolder(root, name)
			createtree(tree[name], root=os.path.join(root, name))
		elif type(tree[name]) is str:
			newfile(root, name, tree[name])

def createproject(args, defaults):
	pass

def readgeckofile(filename):
	with open(filename) as file:
		result = yaml.load(file)
	return result

def installgeckotemplate(args):
	"""
		Installs a json tree to a gecko template
	"""
	# collects: json=file.json name=temp1
	args = processargs(args)
	with open(args.get("json")) as file:
		jsn = json.load(file)
	with open(os.path.join(TEMPLATE_DIR, args.get("name")+EXTENSION), "w") as file:
		yaml.dump(jsn, file)		


def showgui(args, defaults={}):
	eel.init("gecko\\web")
	eel.start("index.html")

class processargs(object):
	def __init__(self, args):
		# remove the first two items, usually current running file and command
		args = args[2:]
		self.result = {}
		# turn argument to dictionary
		# syntax "key=value"
		for item in args:
			item = item.strip()
			if "=" in item and len(item.split("="))==2:
				key = item.split("=")[0].strip().lower()
				value = item.split("=")[1].strip()
				self.result[key] = value
			else:
				raise KeyError("syntax: 'key=value'")

	def get(self, key):
		if key in self.result:
			return self.result[key]
		else:
			return ""

	def set(self, key, value=""):
		self.result[key] = value