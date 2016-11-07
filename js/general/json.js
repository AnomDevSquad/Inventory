class JsonRequest {
  constructor(url, parameters) {
    this._url = url;
    this._parameters = parameters;
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
  }
}
