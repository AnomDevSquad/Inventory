// function initInventory(){
//   document.getElementById('content').innerHTML = "";
//   loadTemplate('template.html');
//   setTimeout(loadFormMovements, 1500);
// }

function init(){
  document.getElementById('content').innerHTML = "";
  loadTemplate('template.html');
  setTimeout(loadFormMovements, 1500);
}

function loadFormMovements(){
  var content = document.getElementById('main_content');
  var form = create(content, 'form', ['id'], ['form_movement']);
  var labels = ['Ingredient', 'Warehouse', 'Concept', 'Quantity'];
  var inputsName = ['itmid', 'waridout', 'waridin', 'qty']
  for (var i = 0; i < labels.length; i++) {
    if (labels[i] == 'Quantity') {
      create(form, 'label', '', '', labels[i]);
      create(form, 'input', ['type', 'name'], ['number', inputsName[i]], '');
    } else {
      create(form, 'label', '', '', labels[i]);
      create(form, 'select', ['id', 'name'], [labels[i].toLocaleLowerCase(), inputsName[i]], '');
    }
  }
  create(form, 'button', ['id'], ['submit'], 'generate movement');

  document.getElementById('submit').addEventListener('click', function(e){
    e.preventDefault();
    var request = new XMLHttpRequest();
    request.open('POST', 'http://localhost:8080/4to/inventory/API/v1/warehouse_transfer.php', true);
    var data = new FormData(document.getElementById('form_movement'));
    request.send(data);
    request.onreadystatechange = function(){
      if (request.status == 200 && request.readyState == 4) {
        console.log(request.responseText);
      }
    }
  });

  loadStockItems();
  loadWarehouseItems();
  loadConceptItems();
}

function loadStockItems(){
  var request = new XMLHttpRequest();
  request.open('GET', 'http://localhost:8080/4to/inventory/API/v1/get_all_stock.php', true);
  request.send();
  request.onreadystatechange = function(){
    if (request.status == 200 && request.readyState == 4) {
      var json = JSON.parse(request.responseText);
      if (json.status == 0) {
        var stock = json.stock;
        var ingredient = document.querySelector('#ingredient');
        create(ingredient, 'option', [], [], 'Select Option');
        for (var i = 0; i < stock.length; i++) {
          var item = stock[i];
          if (item.warehouse.id == 1) {
            create(ingredient, 'option', ['id'], [item.ingredient.id], item.ingredient.description);
          }
        }
      }
    }
  }
}

function loadWarehouseItems(){
  var request = new XMLHttpRequest();
  request.open('GET', 'http://localhost:8080/4to/inventory/api/v1/get_all_warehouses.php', true);
  request.send();
  request.onreadystatechange = function(){
    if (request.status == 200 && request.readyState == 4) {
      var json = JSON.parse(request.responseText);
      if (json.status == 0) {
        var warehouse = document.querySelector('#warehouse');
        var wh = json.warehouses;
        create(warehouse, 'option', [], [], 'Select Option');
        for (var i = 0; i < wh.length; i++) {
          var item = wh[i];
          create(warehouse, 'option', ['id'], [item.id], item.description);
        }
      }
    }
  }
}

function loadConceptItems(){
  var request = new XMLHttpRequest();
  request.open('GET', 'http://localhost:8080/4to/inventory/api/v1/get_all_movement_concepts.php', true);
  request.send();
  request.onreadystatechange = function(){
    if (request.status == 200 && request.readyState == 4) {
      var json = JSON.parse(request.responseText);
      if (json.status == 0) {
        var concpet = document.querySelector('#concept');
        var c =json.concepts;
        create(concpet, 'option', [], [], 'Select Option');
        for (var i = 0; i < c.length; i++) {
          var item = c[i];
          create(concept, 'option', ['id'], [item.id], item.description);
        }
      }
    }
  }
}
