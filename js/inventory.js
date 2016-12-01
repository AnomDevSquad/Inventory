function init() {
    setTimeout(initInventoryTemplate, 100);
}

function transfer() {
    setTimeout(loadFormMovements, 1500);
}

function initInventoryTemplate() {
    var opt1 = document.createElement('p');
    var opt2 = document.createElement('p');
    opt1.innerHTML = 'Orders';
    opt2.innerHTML = 'Graphs';
    templateElements().actions.action1.innerHTML = 'Transfer';
    templateElements().actions.action2.innerHTML = 'Loss';
    templateElements().actions.action3.innerHTML = 'Comparation';
    templateElements().actions.action4.innerHTML = 'Inventory';
    templateElements().options.option1.innerHTML = '';
    templateElements().options.option2.innerHTML = '';
    templateElements().options.option1.appendChild(opt1);
    templateElements().options.option2.appendChild(opt2);

    templateElements().actions.action1.addEventListener('click', loadFormMovements);
    templateElements().actions.action2.addEventListener('click', loadTablesComparation);
    templateElements().options.option1.addEventListener('click', goOrders);
    templateElements().options.option2.addEventListener('click', goGraphs);
}

function loadTablesComparation(){
  document.getElementById('main_content').innerHTML = '';
  var content = document.querySelector('#main_content');
  var section_table = create(content, 'div', ['id'], ['table-content']);
  var kitchen = create(section_table, 'table', ['id', 'class'], ['table-kitchen', 'table']);
  var warehouse = create(section_table, 'table', ['id', 'class'], ['table-warehouse', 'table']);
  var header = ['Id', 'Name', 'Warehouse', 'Quantity'];
  for (var i = 0; i < header.length; i++) {
    create(kitchen, 'th', ['class'], ['table-header'], header[i]);
    create(warehouse, 'th', ['class'], ['table-header'], header[i]);
  }
  loadStock(warehouse, kitchen);
}

function loadStock(warehouse, kitchen){
  var request = new XMLHttpRequest();
  request.open('GET', 'http://localhost:8080/4to/inventory/API/v1/get_all_stock.php', true);
  request.send();
  request.onreadystatechange = function(){
    if (request.status == 200 && request.readyState == 4) {
      var json = JSON.parse(request.responseText)
      var stock = json.stock;
      for (var i = 0; i < stock.length; i++) {
        var item = stock[i];
        if (item.warehouse.id == 1) {
          var tr = create(kitchen, 'tr', [], [], '');
          create(tr, 'td', [], [], item.ingredient.id);
          create(tr, 'td', [], [], item.ingredient.description);
          create(tr, 'td', [], [], item.warehouse.description);
          create(tr, 'td', [], [], item.quantity);
        } else {
          var tr = create(warehouse, 'tr', [], [], '');
          create(tr, 'td', [], [], item.ingredient.id);
          create(tr, 'td', [], [], item.ingredient.description);
          create(tr, 'td', [], [], item.warehouse.description);
          create(tr, 'td', [], [], item.quantity);
        }
      }
    }
  }
}

function loadFormMovements() {
    document.getElementById('main_content').innerHTML = '';
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

    document.getElementById('submit').addEventListener('click', function(e) {
        e.preventDefault();
        var request = new XMLHttpRequest();
        request.open('POST', 'http://localhost:8080/4to/inventory/API/v1/warehouse_transfer.php', true);
        var data = new FormData(document.getElementById('form_movement'));
        request.send(data);
        request.onreadystatechange = function() {
            if (request.status == 200 && request.readyState == 4) {
                console.log(request.responseText);
            }
        }
    });

    loadStockItems();
    loadWarehouseItems();
    loadConceptItems();
}

function loadStockItems() {
    var request = new XMLHttpRequest();
    request.open('GET', 'http://localhost:8080/4to/inventory/API/v1/get_all_stock.php', true);
    request.send();
    request.onreadystatechange = function() {
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

function loadWarehouseItems() {
    var request = new XMLHttpRequest();
    request.open('GET', 'http://localhost:8080/4to/inventory/api/v1/get_all_warehouses.php', true);
    request.send();
    request.onreadystatechange = function() {
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

function loadConceptItems() {
    var request = new XMLHttpRequest();
    request.open('GET', 'http://localhost:8080/4to/inventory/api/v1/get_all_movement_concepts.php', true);
    request.send();
    request.onreadystatechange = function() {
        if (request.status == 200 && request.readyState == 4) {
            var json = JSON.parse(request.responseText);
            if (json.status == 0) {
                var concpet = document.querySelector('#concept');
                var c = json.concepts;
                create(concpet, 'option', [], [], 'Select Option');
                for (var i = 0; i < c.length; i++) {
                    var item = c[i];
                    create(concept, 'option', ['id'], [item.id], item.description);
                }
            }
        }
    }
}
