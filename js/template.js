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

function initTemplate(){
  sendReq('template.html');
}

function goBack(){
  go_actions_menu();
}
function go_actions_menu(){
  location = 'actions_menu.html';
}
