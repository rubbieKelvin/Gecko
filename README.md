# Gecko
## project creation automator

###	shell commands

####show help
```bash
python geckoapp.py -h
```

####create project from terminal instead of gui
```bash
python geckoapp.py -c 
```

####show gui
```bash
python geckoapp.py gui
```

####install a project template
make this json file, test.json
```json
{
	"js":{
		"vendor":{
			"bootstrap.js": ""
		},
		"index.js": ""
	},
	"css":{
		"bootstrap.css": "",
		"index.css": ""
	},
	"img":{},
	"index.html": "<!DOCTYPE html> \n<html> \n<head> \n\t<title>Hey!</title> \n</head> \n<body> \n\t<p>Hey!</p> \n</body> \n</html>"
}
```

then run
```bash
python geckoapp.py -i json=test.json name=test
```

the tree stucture would be stored in the gecko\templates folder as a gecko file