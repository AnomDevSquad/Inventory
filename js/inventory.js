var urlAPI = 'http://localhost:8080/4to/Inventory/';

function init() {
    setTimeout(initInventoryTemplate, 100);
}

function transfer() {
    setTimeout(loadFormTransfer, 100);
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

    templateElements().actions.action1.addEventListener('click', loadFormTransfer);
    templateElements().actions.action2.addEventListener('click', loadFormLosses);
    templateElements().actions.action3.addEventListener('click', loadTablesComparation);
    templateElements().options.option1.addEventListener('click', goOrders);
    templateElements().options.option2.addEventListener('click', goGraphs);
}

function loadFormLosses(){
  document.getElementById('main_content').innerHTML = '';
  var content = document.getElementById('main_content');
  var form = create(content, 'form', ['id'], ['form_movement']);
  var labels = ['Ingredient', 'Warehouse', 'Quantity'];
  var inputsName = ['itmid', 'warid', 'qty']
  for (var i = 0; i < labels.length; i++) {
    if (labels[i] == 'Quantity') {
      create(form, 'label', '', '', labels[i]);
      create(form, 'input', ['id', 'type', 'name', 'min', 'max'], [labels[i].toLocaleLowerCase(), 'number', inputsName[i], '1', '']);
    } else {
      create(form, 'label', '', '', labels[i]);
      create(form, 'select', ['id', 'name'], [labels[i].toLocaleLowerCase(), inputsName[i]]);
    }
  }
  create(form, 'button', ['id', 'type'], ['button_losses', 'submit'], 'Generate Loss');
  loadStockItems();
  loadWarehouseItems();
}

function loadTablesComparation() {
    document.getElementById('main_content').innerHTML = '';
    var content = document.querySelector('#main_content');
    var section_table = create(content, 'div', ['id', 'class'], ['table-content', 'table']);
    var table = create(section_table, 'table', ['id'], ['table-comparation']);
    var header = ['Id', 'Name', 'Kitchen', 'Warehouse'];
    for (var i = 0; i < header.length; i++) {
        create(table, 'th', ['class'], ['table-header'], header[i]);
    }
    loadStock(table);
}

function loadStock(table) {
    var request = new XMLHttpRequest();
    request.open('GET', 'api/v1/get_all_stock.php', true);
    request.send();
    request.onreadystatechange = function() {
        if (request.status == 200 && request.readyState == 4) {
            var json = JSON.parse(request.responseText);
            var stock = json.stock;
            for (var i = 0; i < stock.length; i+=2) {
                var tr = create(table, 'tr', [], []);
                var item = stock[i];
                create(tr, 'td', ['class'], ['identifer'], item.ingredient.id);
                create(tr, 'td', ['class'], ['name'], item.ingredient.description);
                create(tr, 'td', ['class'], ['number'], item.quantity);
                create(tr, 'td', ['class'], ['number'], stock[i+1].quantity);
            }
        }
    }
}

function loadFormTransfer() {
    document.getElementById('main_content').innerHTML = '';
    var content = document.getElementById('main_content');
    var form = create(content, 'form', ['id'], ['form_movement']);
    var labels = ['Ingredient', 'WarehouseOutput', 'WarehouseInput', 'Quantity'];
    var inputsName = ['itmid', 'wari', 'qty']
    for (var i = 0; i < labels.length; i++) {
        if (labels[i] == 'Quantity') {
            create(form, 'label', '', '', labels[i]);
            create(form, 'input', ['id', 'type', 'name', 'min', 'max'], [labels[i].toLocaleLowerCase(), 'number', inputsName[i], '1', '']);
        } else {
            create(form, 'label', '', '', labels[i]);
            create(form, 'select', ['id', 'name'], [labels[i].toLocaleLowerCase(), inputsName[i]]);
        }
    }
    document.getElementById(labels[0].toLocaleLowerCase()).setAttribute('onchange', 'getIngredient(this.value)');
    document.getElementById(labels[1].toLocaleLowerCase()).setAttribute('onchange', 'getWarehouseOutput(this.value)');
    create(form, 'button', ['id'], ['submit'], 'generate movement');

    document.getElementById('submit').addEventListener('click', function(e) {
      e.preventDefault();

      var ingredient = document.getElementById(labels[0].toLocaleLowerCase()).value;
      var warOutput = document.getElementById(labels[1].toLocaleLowerCase()).value;
      var warInput = document.getElementById(labels[2].toLocaleLowerCase()).value;
      var quantity = document.getElementById(labels[3].toLocaleLowerCase()).value;

      if (ingredient == 'Select Option' || warOutput == 'Select Option' || warInput == 'Select Option' || quantity == "") {
        alert('Faltan campos por llenar');
      } else if (warOutput == warInput) {
        alert('No se pueden Transferir al mimos Warehouse')
      } else if (parseInt(quantity) <= 0 ) {
        alert('La cantidad a transferir no puede ser menor o igual a 0');
      } else {
        var request = new XMLHttpRequest();
        request.open('POST', 'api/v1/warehouse_transfer.php', true);
        var data = new FormData(document.getElementById('form_movement'));
        request.send(data);
        request.onreadystatechange = function() {
          if (request.status == 200 && request.readyState == 4) {
            console.log(request.responseText);
            var json = JSON.parse(request.responseText);
            alert(json.result);
            for (var i = 0; i < labels.length; i++) {
              if (i == 3) {
                document.getElementById(labels[i].toLocaleLowerCase()).value = '';
              } else {
                document.getElementById(labels[i].toLocaleLowerCase()).selectedIndex = 0;
              }
            }
          }
        }
      }
    });

    loadStockItems();
    loadWarehouseItems();
    // loadConceptItems();
}

function loadStockItems() {
    var request = new XMLHttpRequest();
    request.open('GET', 'api/v1/get_all_stock.php', true);
    request.send();
    request.onreadystatechange = function() {
        if (request.status == 200 && request.readyState == 4) {
            var json = JSON.parse(request.responseText);
            if (json.status == 0) {
                var stock = json.stock;
                var ingredient = document.querySelector('#ingredient');
                create(ingredient, 'option', [], [], 'Select Option');
                for (var i = 0; i < stock.length; i+=2) {
                    var item = stock[i];
                    if (item.warehouse.id == 1) {
                      create(ingredient, 'option', ['id', 'value'], [item.ingredient.id, item.ingredient.id], item.ingredient.description);
                    }
                }
            }
        }
    }
}

function loadWarehouseItems() {
    var request = new XMLHttpRequest();
    request.open('GET', 'api/v1/get_all_warehouses.php', true);
    request.send();
    request.onreadystatechange = function() {
        if (request.status == 200 && request.readyState == 4) {
            var json = JSON.parse(request.responseText);
            if (json.status == 0) {
                var warehouseOutput = document.querySelector('#warehouseoutput');
                var warehouseInput = document.querySelector('#warehouseinput');
                var warehouse = document.querySelector('#warehouse');
                var wh = json.warehouses;
                if (warehouseInput != undefined && warehouseOutput != undefined) {
                  create(warehouseOutput, 'option', [], [], 'Select Option');
                  create(warehouseInput, 'option', [], [], 'Select Option');
                } else {
                  create(warehouse, 'option', [], [], 'Select Option');
                }
                for (var i = 0; i < wh.length; i++) {
                    var item = wh[i];
                    if (warehouseInput != undefined && warehouseOutput != undefined) {
                      create(warehouseOutput, 'option', ['id', 'value'], [item.id, item.id], item.description);
                      create(warehouseInput, 'option', ['id', 'value'], [item.id, item.id], item.description);
                    } else {
                      create(warehouse, 'option', ['id', 'value'], [item.id, item.id], item.description);
                    }
                }
            }
        }
    }
}

function getWarehouseOutput(value){
  alert(value)
}

function getIngredient(value){
  alert(value)
}

function loadConceptItems() {
    var request = new XMLHttpRequest();
    request.open('GET', 'api/v1/get_all_movement_concepts.php', true);
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
