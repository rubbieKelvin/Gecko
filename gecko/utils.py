import os
import sys
# import eel
import yaml
import json
import subprocess

from PySide2.QtWidgets import QApplication
from PySide2.QtQml import QQmlApplicationEngine, qmlRegisterType

from . import CONFIG
from . import ROOT

TEMPLATE_DIR = "templates"
EXTENSION = ".gecko"

def newfile(root, name, content=""):
	with open(os.path.join(root, name), "w") as file:
		file.write(content)

def newfolder(root, name):
	try:
		os.mkdir(os.path.join(root, name))
		return True
	except FileExistsError:
		return False

def printhelp(args=[]):
	with open("README.md") as file:
		print(file.read())

def createtree(tree, root=""):
	for name in tree.keys():
		if type(tree[name]) is dict:
			newfolder(root, name)
			createtree(tree[name], root=os.path.join(root, name))
		elif type(tree[name]) is str:
			newfile(root, name, tree[name])

def query(args, defaults):
	args = processargs(args, default=defaults)

	root = require(prompt="root folder", default=args.get("root"))
	name = require(prompt="project name")
	temp = require(prompt="template name")
	author = require(prompt="author", default=args.get("author"))
	descr = require(prompt="project description", optional=True, default="")
	readme = require(prompt="use readme yes=>1, no=>0.", _type=int)
	license = require(prompt="license file path", optional=True, default="")

	args.feed({"root":root, "projectname":name, "author":author, "description":descr, "readme":readme, "license":license, "template":temp})
	createproject(["", ""], defaults=args.tree.copy(), ignorerequired=True)


def createproject(args, defaults, ignorerequired=False):
	"""
		this part does the creation of the project folder and specific initialization
		arguments==>
			> root				default will be set on first startup
			> projectname
			> author			optional
			> description		optional
			> git				create git repo?
			> readme			initialize readme?
			> template			template to use, must be installed first
			> lisence			lisence file path
	"""
	args = processargs(args, default=defaults)
	if args.get("projectname") and args.get("template") or ignorerequired:
		# get template
		temps = os.listdir(TEMPLATE_DIR)
		if args.get("template").lower()+EXTENSION in temps:
			# open template
			with open(os.path.join(TEMPLATE_DIR, args.get("template")+EXTENSION)) as file:
				tree = yaml.load(file, Loader=yaml.FullLoader)

			# create project root
			folder = args.get("projectname")
			prevroot = args.get("root")
			if not newfolder(prevroot, folder):
				print("Project already exists")
				return None
			newroot = os.path.join(prevroot, folder)

			# reassign root
			args.set("root", newroot)

			# create tree
			createtree(tree=tree, root=args.get("root"))

			# initialise readme
			if int(args.get("readme")):
				readme = "# {projectname}\n## {description}\nauthor: {author}".format(**args.tree)
				newfile(root=args.get("root"), name="README.md", content=readme)

			# create git repo
			if args.get("git") != "0":
				newfolder(root=args.get("root"), name=".git")
				subprocess.call(["attrib", "+H", os.path.join(args.get("root"), ".git")])
				subprocess.run('{git} --git-dir="{gitdir}" --work-tree="{dir}" init'.format(git=args.get("git"), gitdir=os.path.join(args.get("root"), ".git"), dir=args.get("root")))
				# subprocess.run('git --git-dir="{gitdir}" add .'.format(gitdir=os.path.join(args.get("root"), ".git")))
				# subprocess.run('git --git-dir="{gitdir}" commit -m "initial commit from gecko"'.format(gitdir=os.path.join(args.get("root"), ".git")))
		else:
			print(f"{args.get('template')} is not installed")
	else:
		print("include %projectname and %template arguments")

def readgeckofile(filename):
	with open(filename) as file:
		result = yaml.load(file, Loader=yaml.FullLoader)
	return result

def installgeckotemplate(args):
	"""
		Installs a json tree to a gecko template
	"""
	# collects: json=file.json name=temp1
	args = processargs(args)
	with open(args.get("json")) as file:
		jsn = json.load(file)
	name = args.get("name")
	if not name: name = "new"
	with open(os.path.join(TEMPLATE_DIR, name+EXTENSION), "w") as file:
		yaml.dump(jsn, file)

def showgui(args, defaults={}):
	# eel.init("gecko\\web")
	# eel.start("index.html")
	from .qmlplugins import QmlGecko
	from . import ui

	appname = "autoGecko"
	QGecko = QmlGecko()
	os.environ["QT_QUICK_CONTROLS_STYLE"] = "Material"

	# create application objects
	app = QApplication(args)
	app.setApplicationName(appname)
	app.setOrganizationName("rubbiesoft")
	app.setOrganizationDomain("org.rubbiesoft.%s" %appname.lower())

	# create qml app engine
	engine = QQmlApplicationEngine()
	engine.rootContext().setContextProperty("QGecko", QGecko)
	engine.load("qrc:/ui/qml/gecko.qml")
	engine.quit.connect(app.quit)

	# exit program
	sys.exit(app.exec_())

def toargs(**kwargs):
	res = ""
	res_ = ["", ""]
	for i in kwargs:
		res = res + i + "=" +kwargs[i] + "<=>"
	return res_+res.strip("<=>").split("<=>")

class processargs(object):
	def __init__(self, args, default={}):
		# remove the first two items, usually current running file and command
		args = args[2:]
		self.result = default
		# turn argument to dictionary
		# syntax "key=value"
		for item in args:
			item = item.strip()
			if "=" in item and len(item.split("="))==2:
				key = item.split("=")[0].strip().lower()
				value = item.split("=")[1].strip()
				self.result[key] = value
			else:
				print(args)
				raise KeyError("syntax: 'key=value'")

	def __repr__(self):
		return "<Args %r>" %self.result

	def get(self, key):
		if key in self.result:
			return self.result[key]
		else:
			return ""

	@property
	def tree(self):
		return self.result

	def set(self, key, value=""):
		self.result[key] = value

	def feed(self, _dict:dict):
		self.result.update(_dict)


def require(prompt="Enter a value", _type=str, optional=False, default=None):
	prompt = prompt.strip().strip(":").title()
	if default:
		prompt = "%s [%s]: " %(prompt, default)
	else:
		prompt = prompt+": "
	while True:
		try:
			response = input(prompt)
		except KeyboardInterrupt as e:
			print("process interrupted. exiting now.")
			sys.exit(0)
		if response:
			try:
				response = _type(response)
				break
			except ValueError as e:
				print("Enter a value with type", _type)
		elif optional or default is not None:
			response = default
			break
	return response

def lookforgit():
	programfolder = os.environ["PROGRAMFILES"]
	git = "Git\\cmd\\git.exe"
	git = os.path.join(programfolder, git)
	if os.access(git, os.F_OK):
		return git
	else:
		return "0"

def updateconfiguration(args):
	args = processargs(args)
	with open(CONFIG) as file: config = yaml.load(file, Loader=yaml.FullLoader)
	config.update(args.tree)
	with open(CONFIG, "w") as file: yaml.dump(config, file)

def forceconfig(**kwargs):
	data = dict(author="", git="0", root="\\")
	data.update(kwargs)
	if not os.access(CONFIG, os.F_OK):
		with open(CONFIG, "w") as file:
			pass
	with open(CONFIG, "w") as file:
		yaml.dump(data, file)


def configuration():
	if os.access(CONFIG, os.F_OK):
		with open(CONFIG) as file:
			res = yaml.load(file, Loader=yaml.FullLoader)
	else:
		return {}
	return res

def configured():
	if os.access(CONFIG, os.F_OK):
		try:
			with open(CONFIG) as file:
				res = yaml.load(file, Loader=yaml.FullLoader)
			return bool(res)
		except Exception as e:
			print("error checking configuration\n")
			raise e
