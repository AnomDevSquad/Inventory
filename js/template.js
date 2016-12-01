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

function getActionButtons(){
  var actions = [];
  actions['action1'] = document.getElementById('action_1');
  actions['action2'] = document.getElementById('action_2');
  actions['action3'] = document.getElementById('action_3');
  actions['action4'] = document.getElementById('action_4');
  actions['action5'] = document.getElementById('action_5');
  return actions;
}

function getOptions(){
  var options = [];
  options['option1'] = document.getElementById('opt_1');
  options['option2'] = document.getElementById('opt_2');
  options['option3'] = document.getElementById('opt_3');
  return options;
}

function getTitles(){
  var titles = [];
  titles['principal'] = document.getElementById('title');
  titles['subtitle'] = document.getElementById('main_title');
  return titles;
}

function templateElements(){
  var actions = getActionButtons();
  var options = getOptions();
  var titles = getTitles();
  var templateVariableElements = [];
  templateVariableElements['titles'] = titles;
  templateVariableElements['actions'] = actions;
  templateVariableElements['options'] = options;
  return templateVariableElements
}
