import gecko
import os, sys

app = gecko.Gecko()

if __name__ == "__main__":
	# check if gecko is configured
	args = sys.argv
	app.ensureconfig(args)
	app.exec(args)
