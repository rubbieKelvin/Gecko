let theme = {
	primary: "#009688",
	secondary: "#FFCA28",
	dark: "#263238",
	light: "#A8B7B9",
	white: "#F3FEFF",
	black: "#222D32",
	error: "#EB5757"
};
let alertmode = {ERROR: theme.error, SUCCESS: theme.primary, WARNING: theme.secondary};
let templatelist = ["Qml", "PythonModule", "Html"];

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

const configure = (author, git, root, toastobj) => {
	if (author.length != 0 && git.lenght != 0 && root.lenght != 0){
		let response = QGecko.configure(author, git, root);
		if (!response){
			toast(toastobj, "Could not configure Gecko! Invalid Inputs", alertmode.ERROR);
		}else{
			toast(toastobj, "Gecko configured!", alertmode.SUCCESS);
		}
	}
}
