function init(){
  LoadFormMovement();
  document.getElementById('submit').addEventListener('click', function(e){
    e.preventDefault();
    var request = new XMLHttpRequest();
    request.open('POST', '');
    request.send(new FormData(document.getElementById('form')));
  });
}

function LoadFormMovement(){
  LoadStock();
  LoadWarehouse();
  LoadConcept();
}

function LoadStock(){
  var request = new XMLHttpRequest();
  request.open("GET", 'http://localhost:8080/4to/Inventory/api/v1/get_all_stock.php', true);
  request.send();
  request.onreadystatechange = function(){
    if (request.status == 200 && request.readyState == 4) {
      var json = JSON.parse(request.responseText);
      if (json.status == 0) {
        var data = json.stock;
        var select = document.getElementById('ingredients');
        createOption(select, 'Select Option');
        for (var i = 0; i < data.length; i++) {
          createOption(select, data[i].ingredient.description, data[i].ingredient.id, '', 'onclick', 'changeSelect(this.id)');
        }
      }
    }
  }
}

function LoadWarehouse(){
  var request = new XMLHttpRequest();
  request.open("GET", 'http://localhost:8080/4to/inventory/api/v1/get_all_warehouses.php', true);
  request.send();
  request.onreadystatechange = function(){
    if (request.status == 200 && request.readyState == 4) {
      var json = JSON.parse(request.responseText);
      if (json.status == 0) {
        var data = json.warehouses;
        var select = document.getElementById('warehouses');
        createOption(select, 'Select Option');
        for (var i = 0; i < data.length; i++) {
          createOption(select, data[i].description, data[i].id, '', 'onclick', 'changeSelect(this.id)');
        }
      }
    }
  }
}

function LoadConcept(){
  var request = new XMLHttpRequest();
  request.open("GET", 'http://localhost:8080/4to/inventory/api/v1/get_all_movement_concepts.php', true);
  request.send();
  request.onreadystatechange = function(){
    if (request.status == 200 && request.readyState == 4) {
      var json = JSON.parse(request.responseText);
      if (json.status == 0) {
        var data = json.concepts;
        var select = document.getElementById('concepts');
        createOption(select, 'Select Option');
        for (var i = 0; i < data.length; i++) {
          createOption(select, data[i].description, data[i].id, '', 'onclick', 'changeSelect(this.id)');
        }
      }
    }
  }
}

function changeSelect(id){
  return id;
}
