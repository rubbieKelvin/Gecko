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
				item = {"name":temp.strip(".gecko")}
				with open(os.path.join(utils.TEMPLATE_DIR, temp)) as file: item["size"] = len(file.read())
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