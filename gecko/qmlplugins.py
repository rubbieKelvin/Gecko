from PySide2.QtCore import Property, Slot, Signal, QObject
from . import utils
from datetime import datetime
import json, os

class QmlGecko(QObject):
	"""docstring for QmlGecko."""
	def __init__(self):
		super(QmlGecko, self).__init__()

	configurationChanged = Signal(str)	# updates a json string
	templateAdded = Signal(str)	# updates a json string
	gitStatusChanged = Signal(bool)

	@Property(bool, notify=gitStatusChanged)
	def git_installed(self):
		return utils.lookforgit() != "0"

	@Property(str, notify=configurationChanged)
	def configuration(self):
		conf_ = utils.configuration()
		return json.dumps(conf_)

	@Property(str, notify=templateAdded)
	def templates(self):
		templist = os.listdir(utils.TEMPLATE_DIR)
		tempdata = []
		for temp in templist:
			if temp.endswith(".gecko"):
				item = {"name":temp[:-6]}
				with open(os.path.join(utils.TEMPLATE_DIR, temp)) as file: item["filesize"] = str(len(file.read())/1000)+" kb"
				tempdata.append(item)
		return json.dumps(tempdata)

	@Slot(str, str, str, result=bool)
	def configure(self, author, git, root):
		data = dict(author=author, git=git, root=root)

		# validate
		if os.access(git, os.F_OK) and os.access(root, os.F_OK):
			utils.updateconfiguration(utils.toargs(**data))
			self.configurationChanged.emit(json.dumps(data))
			return True
		return False

	@Slot(str, result=bool)
	def removetemplate(self, name):
		file = os.path.join(utils.TEMPLATE_DIR, name+".gecko")
		print(file, os.access(file, os.F_OK))
		if os.access(file, os.F_OK):
			try:
				os.remove(file)
				return True
			except Exception as e:
				print(e)
				return False
		else:
			return False

	@Slot(str, str, result=bool)
	def installtemplate(self, jsonpath, name):
		data = dict(json=jsonpath, name=name)

		# validate
		if os.access(jsonpath, os.F_OK):
			try: utils.installgeckotemplate(utils.toargs(**data))
			except json.decoder.JSONDecodeError as e: return False
			with open(jsonpath) as file: data["size"] = len(file.read())
			d = datetime.utcnow()
			data["date"] = str(d.date())
			self.templateAdded.emit(json.dumps(data))
			return True
		return False

	@Slot(str, str, str, bool, result=bool)
	def createproject(self, name, template, descr, git):
		try:
			args = utils.processargs([])
			args.feed(utils.configuration())
			args.feed({"projectname":name, "description":descr, "readme":1, "license":'', "template":template})
			if not git: args.set("git", "0")
			utils.createproject(["", ""], defaults=args.tree.copy(), ignorerequired=True)
			return True
		except Exception as e:
			print(e)
			return False
