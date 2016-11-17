class Card extends HtmlElement{
  constructor(parent, tag, name, icon, id, c,  innerHTML) {
    super(parent, tag, id, c,  innerHTML);
    if(typeof name !== 'undefined')
      this._name = name;
    else
      this._name = '';
    if(typeof icon !== 'undefined')
      this._icon = icon;
    else
      this._icon = icon;
    var p = document.createElement('p');
    p.innerHTML = this._name;
    var icon = document.createElement('div');
    icon.innerHTML = this._icon;
    this._element.appendChild(icon);
    this._element.appendChild(p);
  }

  get name(){
    return this._name;
  }
  set name(value){
    this._name = value;
  }
  get icon(){
    return this._icon;
  }
  set icon(value){
    this._icon = value;
  }
}

class CardPage extends HtmlElement {
  constructor() {

  }
}
