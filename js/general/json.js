class JsonRequest {
  constructor(url, parameters) {
    if(typeof url !== 'undefined'){
      this._url = url;
      if(paramters !== 'undefined' && typeof paramters.length !== 'undefined')
        this._parameters = parameters;
      else
        this._parameters = [];
    }
    else{
      this._url = 'none';
      this._parameters = 'none';
    }
  }

  getJson(){
    var request = new XMLHttpRequest();
    request.open("GET", this._url, true);
    request.send();
    request.onreadystatechange = function(){
      if(request.status == 200 && request.readyState == 4){
        return JSON.parse(request.responseText);
      }
    }
    request.open("GET", this._url, false);
    request.send();
    return JSON.parse(request.responseText);
  }
}
