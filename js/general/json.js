class JsonRequest {
  static json(url, paramters){
    if(typeof url !== 'undefined' && paramters !== 'undefined' && typeof paramters.length !== 'undefined'){

    }
  }

  constructor(url, parameters) {
    this._url = url;
    this._parameters = parameters;
  }

  getJson(){
    var request = new XMLHttpRequest();
    request.onreadystatechange = function(){
      if(request.readyState == 4 && request.status = 200)
        return JSON.parse(request.responseText);
    }
    request.open("GET", theURL, false);
    request.send();
  }
}
