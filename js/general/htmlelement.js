class HtmlElement {
  constructor(parent, tag, id, c, innerHTML) {
    if(typeof parent !== 'undefined' && typeof tag !== 'undefined'){
      this._parent = parent;
      this._tag = tag;
      if(typeof id !== 'undefined') this._id = id; else this._id = '';
      if(typeof c !== 'undefined') this._class = c; else this._class = '';
      if(typeof innerHTML !== 'undefined') this._text = innerHTML; else this._text = '';
      this._element = document.createElement(this._tag);
      this._element.setAttribute('class',this._class);
      this._element.id = this._id;
      this._element.innerHTML = this._text;
    } else {
      throw new Error('HtmlElement cannot be create. It needs [parent, tag]');
    }
  }

  get parent() {
    return this._parent;
  }
  set parent(value) {
    this._parent = value;
  }
  get class() {
    return this._class;
  }
  set class(value) {
    this._class = value;
  }
  get tag() {
    return this._tag;
  }
  set tag(value) {
    this._tag = value;
  }
  get text(){
    return this._text;
  }
  set text(value){
    this._text = value;
  }
  get element(){
    return this._element;
  }
  set element(value) {
    this._element = value;
  }

  draw(){
    this._parent.appendChild(this._element);
  }
  remove(){
    this._parent.removeChild(this._element);
  }

  static measurementUnits(){
    return ['px','%','pt','em'];
  }
  static unitMeasurement(value){
    var measurements = this.measurementUnits();
    var result = '';
    var encontrado = false;
    for(var i = 0; i < measurements.length; i++){
      if(!encontrado && value.search(measurements[i]) != -1){
        result = measurements[i];
        encontrado = true;
      }
    }
    return result;
  }

  static inFromHtmlValue(value){

  }
}

class Square extends HtmlElement {
  constructor(ancho, alto, parent, tag, c,  innerHTML, id) {
    super(parent, tag, c,  innerHTML, id);
    this._ancho = ancho;
    this._alto = alto;
    this._element.style.width = this._ancho;
    this._element.style.height = this._alto;
  }

  draw(){
    super.draw();
  }

  get ancho(){
    return this._ancho;
  }
  set ancho(value){
    this._ancho = value;
  }
  get anchoMeasuType(){
    return measurement(this._ancho);
  }
  get alto(){
    return this._alto;
  }
  set alto(value){
    this._alto = value;
  }
  get altoMeasuType(){
    return measurement(this._alto);
  }
}
