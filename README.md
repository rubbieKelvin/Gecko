# Gecko

## project creation automator
automate the process of creating project file structure and also the boring CLI commands

## installation
install with pypi
```bash
pip install autogecko
```
or just clone from the git url

### show help
```bash
python autogecko.py -h
```

### create project from terminal instead of gui
```bash
python autogecko.py -c
```

### show gui, alternatively run without argument
```bash
python autogecko.py gui
```

### install a project template
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
python autogecko.py -i json=test.json name=html5boilerplate
```
the tree stucture would be stored in the gecko\templates folder as a gecko file. You can then run:
```bash
python autogecko.py -c projectname=Test template=html5boilerplate readme=1
```
you can now check the folder which you setup as root folder on the first run.

### update configuration
```bash
python autogecko.py -config <key1=value1> <key2=value2> ... <key-n=value-n>
```