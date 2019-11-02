// ui colors
let theme = {
	primary: "#009688",
	secondary: "#FFCA28",
	dark: "#263238",
	light: "#A8B7B9",
	white: "#F3FEFF",
	black: "#222D32",
	error: "#EB5757"
};

// alert modes for toast bar
let alertmode = {ERROR: theme.error, SUCCESS: theme.primary, WARNING: theme.secondary};

// template lists
let templatelist = () => {
	let templist = QGecko.templates;
	templist = JSON.parse(templist);
	let res = [];
	for (var i = 0; i < templist.length; i++) {
		res.push(templist[i].name);
	}
	return res;
};

// template model
let templatemodel = () => {
	let templist = QGecko.templates;
	templist = JSON.parse(templist);
	return templist;
};

// feed template model
let feedtempmodel = (model) => {
	let templist = QGecko.templates;
	templist = JSON.parse(templist);
	for (var i = 0; i < templist.length; i++) {
		model.append(templist[i]);
	}
}

let configuration = () => {
	return JSON.parse(QGecko.configuration);
}

const closeapp = (root) => {
	root.close();
}

const toast = (toastobj, msg, mode) => {
	toastobj.textobj.text = msg;
	toastobj.rectobj.color = mode;
	toastobj.rectobj.visible = true;
	toastobj.timeobj.start();
}

const uninstall = (name, model, toastobj) => {
	let res = QGecko.removetemplate(name);
	if (res){
		toast(toastobj, name+" deleted successfully", alertmode.SUCCESS);
		// clear model
		model.clear();
		// feed again
		feedtempmodel(model);
	}else{
		toast(toastobj, name+" could not be deleted.", alertmode.ERROR);
	}
}

const configure = (author, git, root, toastobj) => {
	if (author.length != 0 && git.length != 0 && root.length != 0){
		let response = QGecko.configure(author, git, root);
		if (!response){
			toast(toastobj, "Could not configure Gecko! Invalid Inputs", alertmode.ERROR);
		}else{
			toast(toastobj, "Gecko configured!", alertmode.SUCCESS);
		}
	}else {
		toast(toastobj, "Please fill empty forms.", alertmode.WARNING);
	}
}

const install = (jsonpath, name, model, toastobj) => {
	if (jsonpath.length != 0 && name.length != 0){
		let response = QGecko.installtemplate(jsonpath, name);
		if (response){
			toast(toastobj, "template installed", alertmode.SUCCESS);
			// clear model
			model.clear();
			// feed again
			feedtempmodel(model);
		}else {
			toast(toastobj, "error installing template", alertmode.ERROR);
		}
	}else {
		toast(toastobj, "Please fill empty forms.", alertmode.WARNING);
	}
}

const createproject = (dataobj, toastobj) => {
	if (dataobj.name.text.length != 0 && dataobj.template.currentText.length != 0 && dataobj.description.text.length != 0){
		let res = QGecko.createproject(dataobj.name.text, dataobj.template.currentText, dataobj.description.text, dataobj.git.checked);
		if (res){
			toast(toastobj, "Project '"+ dataobj.name.text +"' created.", alertmode.SUCCESS);
		}else {
			toast(toastobj, "Project could not be created.", alertmode.ERROR);
		}
	}else {
		toast(toastobj, "Fill form completly", alertmode.WARNING);
	}
}
