function initTemplate(){
  sendReq('template.html');
  setTimeout(init, 1000);
}

function createRequestObject() {
    var obj;
    var browser = navigator.appName;
    if (browser == "Microsoft Internet Explorer") {
        obj = new ActiveXObject("Microsoft.XMLHTTP");
    } else {
        obj = new XMLHttpRequest();
    }
    return obj;
}

function sendReq(req) {
    var http = createRequestObject();
    http.open('get', req);
    http.onreadystatechange = function() {
        if (http.readyState == 4) {
            var response = http.responseText;
            document.getElementById('content').innerHTML = response;
        }
    };
    http.send(null);
}

function loadTemplate(url) {
    sendReq(url);
}

function goBack(){
  go_index();
}
function go_index(){
  location = 'index.html';
}

function goOrders(){
  location = 'orders.html';
}

function goInventory(){
  location = 'inventory.html';
}

function goGraphs(){
  location = 'graphs.html';
}
