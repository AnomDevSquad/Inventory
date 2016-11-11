function createLabel(parent, id, name){
  var label = document.createElement('label');
  label.setAttribute('id', id);
  label.setAttribute('for',name);
  label.innerHTML = name;
  parent.appendChild(label);
}

function createInput(parent, id, type, name){
  var input = document.createElement('input');
  input.setAttribute('id', id);
  input.setAttribute('type', type);
  input.setAttribute('name', name);
  if (type == 'number') {
    input.setAttribute('placeholder', 'Input the Quantity');
  } else {
    input.setAttribute('placeholder', 'Input the Text');
  }
  parent.appendChild(input);
}

function createOption(){
  // do something
}

function createSelect(){
  // do something
}


/* containers for forms and others */
function createDiv(parent, items, id, className){
  var div = document.createElement('div');
  div.setAttribute('id', id);
  div.setAttribute('class', className);
  parent.appendChild(div);
}
