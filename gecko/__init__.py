from . import utils
from socket import gethostname
import os, json

class Gecko(object):
	"""docstring for Gecko"""
	def __init__(self, options={"root":"", "projectname":"", "author":"", "description":"", "git":"0", "readme":"0", "template":"", "lisence":""}):
		super(Gecko, self).__init__()
		self.options = options

	def exec(self, *args, **kwargs):
		if self.configured: self.exec_(*args, **kwargs)
		else: print("Gecko is not configured.")


	def exec_(self, args=[]):
		if len(args) > 1:
			if args[1].strip() == "-h":
				utils.printhelp(args)

			elif args[1].strip() == "-c":
				utils.createproject(args, defaults=self.options)

			elif args[1].strip() == "gui":
				utils.showgui(args, defaults=self.options)

			elif args[1].strip() == "-i":
				utils.installgeckotemplate(args)

			else:
				print(f"'{args[1]}' is not a valid command")

	def ensureconfig(self):
		if not self.configured():
			# collect project root
			root = utils.require(prompt="Project root folder")
			git = utils.require(prompt="Git.exe folder", default="", optional=True)
			author = utils.require(prompt="Your Name", default=gethostname(), optional=True)

			if os.access(root, os.F_OK):
				if git == "" or os.access(git, os.F_OK):
					with open("gecko.config", "w") as file:
						json.dump({"root":root, "git":git, "author":author}, file)
						return True
			print("gecko not config properly")
			return False


	def configured(self):
		# checks if gecko is configured
		if os.access("gecko.config", os.F_OK):
			with open("gecko.config") as file:
				cont = file.read()
			return cont.strip() != ""
		else:
			return False
