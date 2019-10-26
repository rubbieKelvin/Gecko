from . import utils


class Gecko(object):
	"""docstring for Gecko"""
	def __init__(self, options={"projectdir":"", "git":"0", "projectname":"", "description":"", "readme":"0", "template":"default"}):
		super(Gecko, self).__init__()
		self.options = options
		
	def exec(self, args=[]):
		if len(args) > 1:
			if args[1].strip() == "-h":
				utils.printhelp(args)

			elif args[1].strip() == "help":
				utils.printhelp(args)

			elif args[1].strip() == "-c":
				utils.createproject(args, defaults=self.options)

			elif args[1].strip() == "gui":
				utils.showgui(args, defaults=self.options)

			elif args[1].strip() == "-i":
				utils.installgeckotemplate(args)
			

			else:
				print(f"'{args[1]}' is not a valid command")
