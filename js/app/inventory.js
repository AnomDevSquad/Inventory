function stock(){
  var request = new XMLHttpRequest();
  var table = document.getElementById('table');
  table.innerHTML = '';
  request.open('GET', 'http://localhost:8080/4to/Inventory/API/v1/get_all_stock.php', true);
  request.send();
  request.onreadystatechange = function(){
    if (request.status == 200 && request.readyState == 4) {
      var json = JSON.parse(request.responseText);
      if (json.status == 0) {

        var products = ['id', 'Name', 'Quantity', 'Wharehouse'];
        for (var i = 0; i < products.length; i++) {
          var th = document.createElement('th');
          th.innerHTML = products[i];
          table.appendChild(th);
        }
        var data = json.stock;
        for (var i = 0; i < data.length; i++) {
          var tr = document.createElement('tr');
          var id = document.createElement('td');
          var name = document.createElement('td');
          var quantity = document.createElement('td');
          var warehouse = document.createElement('td');
          var ingredient = data[i];

          id.innerHTML = ingredient.ingredient.id;
          name.innerHTML = ingredient.ingredient.description;
          quantity.innerHTML = ingredient.quantity;
          warehouse.innerHTML = ingredient.warehouse.description;

          tr.appendChild(id);
          tr.appendChild(name);
          tr.appendChild(quantity);
          tr.appendChild(warehouse);

          table.appendChild(tr);
        }
      }
    }
  }
}

function movements(){
  var request = new XMLHttpRequest();
  var table = document.getElementById('table');
  table.innerHTML = '';
  request.open('GET', 'http://localhost:8080/4to/Inventory/api/v1/get_all_movements.php', true);
  request.send();
  request.onreadystatechange = function(){
    if (request.status == 200 && request.readyState == 4) {
      var json = JSON.parse(request.responseText);
      if (json.status == 0) {
        var movements = ['Id', 'Date', 'Quantity', 'Ingredient', 'Wharehouse', 'Movement Concept'];
        for (var i = 0; i < movements.length; i++) {
          var th = document.createElement('th');
          th.innerHTML = movements[i];
          table.appendChild(th);
        }
        var data = json.movements;
        for (var i = 0; i < data.length; i++) {
          var movement = data[i];
          var tr = document.createElement('tr');
          var id = document.createElement('td');
          var date = document.createElement('td');
          var quantity = document.createElement('td');
          var ingredient = document.createElement('td');
          var warehouse = document.createElement('td');
          var movementConcept = document.createElement('td');

          id.innerHTML = movement.id;
          var datetime = new Date(movement.date)
          date.innerHTML = datetime.getFullYear() + '-' + datetime.getMonth() + '-' + datetime.getDate();
          quantity.innerHTML = movement.quantity;
          ingredient.innerHTML = movement.stock.ingredient.description;
          warehouse.innerHTML = movement.stock.warehouse.description;
          movementConcept.innerHTML = movement.movementConcept.description;

          tr.appendChild(id);
          tr.appendChild(date);
          tr.appendChild(quantity);
          tr.appendChild(ingredient);
          tr.appendChild(warehouse);
          tr.appendChild(movementConcept);
          table.appendChild(tr);
        }
      }
    }
  }
}
