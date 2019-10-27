import gecko
import os, sys

app = gecko.Gecko()

if __name__ == "__main__":
	# check if gecko is configured
	app.ensureconfig()
	app.exec(sys.argv)
