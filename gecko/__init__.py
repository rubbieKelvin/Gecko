from . import utils
import os, json, yaml

CONFIG = "geckoconfig.yml"

class Gecko(object):
	"""docstring for Gecko"""
	def __init__(self, options={"root":"", "projectname":"", "author":"", "description":"", "git":None, "readme":"0", "template":"", "lisence":""}):
		super(Gecko, self).__init__()
		self.options = options

	def exec(self, *args, **kwargs):
		if self.configured: self.exec_(*args, **kwargs)
		else: print("Gecko is not configured.")


	def exec_(self, args=[]):
		if len(args) > 1:
			if args[1].strip() == "-h":
				# shows help and usage information
				utils.printhelp(args)

			elif args[1].strip() == "-c":
				# creates a project from command line
				utils.createproject(args, defaults=self.options)

			elif args[1].strip() == "-q":
				# creates a project by collecting queries
				pass
			
			elif args[1].strip() == "gui":
				# shows gui.. alternatively do not add an argument
				utils.showgui(args, defaults=self.options)

			elif args[1].strip() == "-i":
				# installs a gecko file from json file
				utils.installgeckotemplate(args)

			else:
				print(f"'{args[1]}' is not a valid command")
		elif len(args) == 1:
			utils.showgui(args, defaults=self.options)
		

	def ensureconfig(self):
		if not self.configured():
			# collect project root
			root = utils.require(prompt="Project root folder")
			git = utils.require(prompt="Git.exe folder", default=utils.lookforgit(), optional=True)
			author = utils.require(prompt="Your Name", default=os.environ["USERNAME"], optional=True)

			conf_ = {"root":root, "git":git, "author":author}

			if os.access(root, os.F_OK):
				if git == "" or os.access(git, os.F_OK):
					with open(CONFIG, "w") as file:
						yaml.dump(conf_, file)
						self.options.update(conf_)
						return True
			print("gecko not config properly")
			return False
		else:
			with open(CONFIG) as file:
				conf_ = yaml.load(file)
			self.options.update(conf_)



	def configured(self):
		# checks if gecko is configured
		if os.access(CONFIG, os.F_OK):
			with open(CONFIG) as file:
				cont = file.read()
			return cont.strip() != ""
		else:
			return False
