
// library
function defined(obj) {
	return obj !== undefined;
}
// (key -> key) -> key -> [key]
function MapGetAncestors(map, key, includeSelf) {
	var ancestors = [];
	var checked = {};
	if (includeSelf) {
		ancestors.push(key);
		checked[key] = true;
	}
	key = map[key];
	while (defined(key) && !checked[key]) {
		if (defined(map[key])){
			ancestors.push(key);
		}
		checked[key] = true;
		key = map[key];
	}
	return ancestors;
}
var Path = {};
Path.dirname = function(path) {
	return Path.parse(path).dir;
	var ns = path.split("/");
	var filename = ns.pop();
	var path2 = ns.length == 0 ? "." : ns.join("/");
	return path2;
};
Path.relative = function(from, to) {
	from = from == "." ? "" : from;
	to = to == "." ? "" : to;
	var ns1 = from.split("/");
	var ns2 = to.split("/");
	ns1.pop();
	var c = ns1.length;
	for (var i = 0; i < ns1.length; i++) {
		if (!(i < ns2.length) || ns1[i] !== ns2[i]) {
			c = i;
			break;
		}
	}
	var ns = [];
	for (var i = c; i < ns1.length; i++) {
		ns.push("..");
	}
	for (var i = c; i < ns2.length; i++) {
		ns.push(ns2[i]);
	}
	var path = ns.join("/");
	return path || ".";
};
Path.parse = function(path) {
	var m;
	if (m = path.match(/^(.*)\/+([^\/]*)$/)) {
		return { dir: m[1] || "/", base: m[2] };
	} else {
		return { dir: ".", base: path };
	}
};
Path.join = function(path1, path2) {
	if (!path1.match(/^(.*)\/$/)) {
		path1 = path1 + "/";
	}
	if (path2 == ".") {
		path2 = "";
	}
	var path = path1 + path2;
	return path;
}

// modify at mark
var es = document.getElementsByClassName("fa-at");
es = Array.from(es);
es.forEach(function(e) {
	e.outerHTML = "@";
});

// navigation
function getRelPath(base, path) {
	// var root = Path.dirname(base);
	var path2 = Path.relative(base, path);
	// console.log(base, path, path2);
	return path2;
}
function getDefaultParent(path) {
	var { dir: dir, base: name } = Path.parse(path);
	if (name === "") {
		var { dir: root, base: base } = Path.parse(dir);
		return Path.join(root, "");
	}
	return Path.join(dir, "");
}
var items = {};
var parentsM = {};
// console.log(window.directoryInfoItems);
for (var item of window.directoryInfoItems) {
	var path = item.url;
	var parent = (
		item.parent === "" ? getDefaultParent(path) :
		item.parent === "?" ? "" :
		item.parent
	);
	if (parent == path) {
		parent = "";
	}
	parentsM[path] = parent;
	var item2 = { path: path, parent: parent, title: item.title, description: item.description, children: [] };
	items[path] = item2;
}
for (var path in items) {
	var item = items[path];
	var parent = items[item.parent];
	if (parent) {
		parent.children.push(path);
	}
}
// console.log(items);
var eNav = document.getElementById("main-nav");
var eNavInfo = document.getElementById("main-nav-info");
var pathRoot = eNavInfo.textContent;
var parents = MapGetAncestors(parentsM, pathRoot, true).reverse();
// console.log(parents);
var pathRoot = parents[parents.length - 1];
function getInfo(path) {
	var item = items[path];
	var title = item.title || getRelPath(pathParent, path);
	var url = getRelPath(pathRoot, path);
	return { title: title, url: url, description: item.description, children: item.children };
}
var vueNav = new Vue({ el: "#main-nav", delimiters: ["[[", "]]"], data: { parents: parents.map(getInfo), list: [], getInfo: getInfo } });
document.addEventListener("click", function(event) {
	var e = event.target;
	var b = e.matches("#main-nav *");
	if (!b) {
		vueNav.list = [];
	}
});
