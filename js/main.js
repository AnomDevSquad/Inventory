function init(){
  document.getElementById('header').innerHTML = sessionStorage['where'];
}

function initlogin(){
  document.title = sessionStorage['where'];
}

function setsite(where){
  sessionStorage['where'] = where;
  window.location = 'login.html';
}

function login(){
  window.location = loginsite();
}

function loginsite(){
  var pages = [['Inventory','inventory.html'], ['Dashboard','dashboard.html'], ['Orders','orders.html']];
  for(var i = 0; i<pages.length; i++){
    if(pages[i][0] == sessionStorage['where']){
      return pages[i][1];
    }
  }
  return '';
}
