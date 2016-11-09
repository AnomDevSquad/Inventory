function createLabel(parent, id, name){
  var label = document.createElement('label');
  label.setAttribute('id', id);
  label.setAttribute('for',name);
  parent.appendChild(label);
}

function createInput(parent, id, type){
  var input = document.createElement('input');
  input.setAttribute('id', id);
  input.setAttribute('type', type);
  parent.appendChild(input);
}
