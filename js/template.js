function initTemplate(){
  sendReq('template.html');
<<<<<<< HEAD
  setTimeout(init, 250);
=======
  setTimeout(init, 1000);
>>>>>>> a8998d37b1b53f037e5f1aa43e15421ae51c7764
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

function getActionsButtons(){
  var actions = [
    document.getElementById('action_1'),
    document.getElementById('action_2'),
    document.getElementById('action_3'),
    document.getElementById('action_4'),
    document.getElementById('go_back')
  ];
  return actions;
}

function getOptions(){
  var options =
  [
    document.getElementById('opt_1'),
    document.getElementById('opt_2'),
    document.getElementById('opt_3')
  ];
  return options;
}
