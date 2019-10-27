import gecko
import os, sys

app = gecko.Gecko()
# check if gecko is configured
app.ensureconfig()
app.exec(sys.argv)
