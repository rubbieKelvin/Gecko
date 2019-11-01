from PySide2.QtCore import Property, Slot, Signal, QObject
from . import utils
import json, os

class QmlGecko(QObject):
	"""docstring for QmlGecko."""
	def __init__(self):
		super(QmlGecko, self).__init__()

	configurationChanged = Signal(str)	# updates a json string

	@Property(str, notify=configurationChanged)
	def configuration(self):
		conf_ = utils.configuration()
		return json.dumps(conf_)

	@Slot(str, str, str, result=bool)
	def configure(self, author, git, root):
		data = dict(author=author, git=git, root=root)

		# validate
		if os.access(git, os.F_OK) and os.access(root, os.F_OK):
			utils.updateconfiguration(utils.toargs(**data))
			self.configurationChanged.emit(json.dumps(data))
			return True
		return False

	@Slot(str, str)
	def installtemplate(self, path, name):
		pass
