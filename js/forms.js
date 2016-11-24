function create(parent, type, key, value, text){
  var element = document.createElement(type);
  for (var i = 0; i < key.length; i++) {
    element.setAttribute(key[i], value[i]);
  }
  if (!(text === undefined)) {
    element.innerHTML = text;
  }
  parent.appendChild(element);
  return element;
}
