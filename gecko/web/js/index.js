// javascript
var linkContainer = document.getElementsByTagName("nav");

var links = linkContainer.getElementsByTagName("ul li");

for (var i = 0; i < links.length; i++) {
  links[i].addEventListener("click", function() {
    var current = document.getElementsByClassName("active");
    current[0].className = current.className.replace("active", "");
    this.className += "active";
  });
}
