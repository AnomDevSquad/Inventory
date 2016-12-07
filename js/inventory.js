function init() {
    setTimeout(initInventoryTemplate, 100);
    setTimeout(kitchenStock, 100);
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
            var json = JSON.parse(request.responseText)
            var stock = json.stock;
            for (var i = 0; i < stock.length; i += 2) {
                var tr = create(table, 'tr', [], []);
                var item = stock[i];
                create(tr, 'td', ['class'], ['identifer'], item.ingredient.id);
                create(tr, 'td', ['class'], ['name'], item.ingredient.description);
                create(tr, 'td', ['class'], ['number'], item.quantity);
                create(tr, 'td', ['class'], ['number'], stock[i + 1].quantity);
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
            var select = create(form, 'select', ['id', 'name'], [labels[i].toLocaleLowerCase(), inputsName[i]]);
            if (labels[i] != 'WarehouseInput') {
                select.addEventListener('change', putMeasurement);
            }
        }
    }
<<<<<<< HEAD
    var label = create(form, 'label', ['id'], ['ingredientmeasurement']);
    label.setAttribute('class', 'measurement');
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
            alert('No se pueden Transferir al mismo Warehouse')
        } else if (parseInt(quantity) <= 0) {
            alert('La cantidad a transferir no puede ser menor o igual a 0');
        } else {
            var request = new XMLHttpRequest();
            request.open('POST', 'api/v1/post_transfer.php', true);
            var data = new FormData(document.getElementById('form_movement'));
            request.send(data);
            request.onreadystatechange = function() {
                if (request.status == 200 && request.readyState == 4) {
                    //console.log(request.responseText);
                    alert(request.responseText);
                    for (var i = 0; i < labels.length; i++) {
                        if (i == 3) {
                            document.getElementById(labels[i].toLocaleLowerCase()).value = '';
                        } else {
                            document.getElementById(labels[i].toLocaleLowerCase()).selectedIndex = 0;
                        }
                    }
                }
=======
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
>>>>>>> test
            }
        }
    });

    loadStockItems();
    loadWarehouseItems();
}

function loadStockItems() {
    var request = new XMLHttpRequest();
    request.open('GET', 'api/v1/get_stock_warehouse.php?warid=2', true);
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
<<<<<<< HEAD
                    if (item.warehouse.id == 2) {
                        create(ingredient, 'option', ['id', "value"], [item.ingredient.id, item.ingredient.id], item.ingredient.description);
=======
                    if (item.warehouse.id == 1) {
                        create(ingredient, 'option', ['id', 'value'], [item.ingredient.id, item.ingredient.id], item.ingredient.description);
>>>>>>> test
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
<<<<<<< HEAD
                    create(warehouseOutput, 'option', ['id', "value"], [item.id, item.id], item.description);
                    create(warehouseInput, 'option', ['id', "value"], [item.id, item.id], item.description);
=======
                    if (warehouseInput != undefined && warehouseOutput != undefined) {
                      create(warehouseOutput, 'option', ['id', 'value'], [item.id, item.id], item.description);
                      create(warehouseInput, 'option', ['id', 'value'], [item.id, item.id], item.description);
                    } else {
                      create(warehouse, 'option', ['id', 'value'], [item.id, item.id], item.description);
                    }
>>>>>>> test
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

function putMeasurement() {
    var ingid = document.getElementById('ingredient').value;
    var waro = document.getElementById('warehouseoutput').value;
    if (ingid === 'Select Option')
        ingid = 0;
    if (waro === 'Select Option')
        waro = 0;

        //console.log(ingid, waro);

    if (ingid != 0 && waro != 0) {
        var request = new XMLHttpRequest();
        request.open('GET', 'api/v1/get_ingredient_measurement.php?ingredientid=' + ingid + '&warehouseid=' + waro);
        request.send();
        request.onreadystatechange = function() {
            if (request.status == 200 && request.readyState == 4) {
                var json = JSON.parse(request.responseText);
                if (json.status == 0) {
                    // console.log(document.getElementById('ingredientmeasurement'));
                    // console.log(json.measurement.description);
                    document.getElementById('ingredientmeasurement').innerHTML = json.measurement.description;
                    // console.log(document.getElementById('ingredientmeasurement').value);
                }
            }
        }
    }

}

function getCombo(id) {
    var value = this.options[this.selectedIndex].value;
    alert(value)
}

function kitchenStock() {
    var request = new XMLHttpRequest();
    request.open('GET', 'api/v1/get_stock_warehouse.php?warid=1', true);
    request.send();
    request.onreadystatechange = function() {
        if (request.status == 200 && request.readyState == 4) {
            var json = JSON.parse(request.responseText);
            var stockElements = json.stock;
            if (json.status == 0) {
                // console.log(json);
                for (var i = 0; i < stockElements.length; i++) {

                }
            }
        }
    }
}

// class StockIngredient {
//     constructor(jsonObj) {
//         this._ingredient = jsonObj.ingredient.description;
//         this._image = 'img/ingredients/img_' + jsonObj.ingredient.id;
//         this._quantity = jsonObj.quantity;
//         this._max = jsonObj.max;
//         this._min = jsonObj.min;
//
//         this.div = ducument.createElement('div');
//         this.divTitle = ducument.createElement('div');
//         this.divPicture = ducument.createElement('div');
//         this.divNumbers = ducument.createElement('div');
//         this.pTitle = ducument.createElement('p');
//         this.pQuantity = ducument.createElement('p');
//         this.pMax = ducument.createElement('p');
//         this.pMin = ducument.createElement('p');
//         this.imgIngredient = document.createElement('img');
//
//         this.div.appendChild(this.divTitle);
//         this.div.appendChild(this.divPicture);
//         this.div.appendChild(this.divNumbers);
//         this.divTitle.appendChild(this.pTitle);
//         this.divPicture.appendChild(this.imgIngredient);
//         this.divNumbers.appendChild(this.pMin);
//         this.divNumbers.appendChild(this.pQuantity);
//         this.divNumbers.appendChild(this.pMax);
//         this.divNumbers.appendChild(this.pMin);
//
//         this.div.setAttribute('class', 'stockElement');
//         this.divTitle.setAttribute('class', 'header');
//         this.divPicture.setAttribute('class', 'picture');
//         this.divNumbers.setAttribute('class', 'quantities');
//         this.pTitle.setAttribute('class', 'title');
//         this.pQuantity.setAttribute('class', 'quantity');
//         this.pMax.setAttribute('class', 'max');
//         this.pMin.setAttribute('class', 'min');
//         this.imgIngredient.setAttribute('class', 'image');
//
//         this.pTitle.innerHTML = this._ingredient;
//         this.pQuantity.innerHTML = this._quantity;
//         this.pMax.innerHTML = this._max;
//         this.pMin.innerHTML = this._min;
//         this.imgIngredient.setAttribute('src', this._image);
//     }
//
//     draw(padre) {
//         padre.appendChild(this.div);
//     }
//
//     remove() {
//         this.div.parentNode.removeChild(this.div);
//     }
// }
