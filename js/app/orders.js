function init(){
  loadDishes();
}

function loadDishes(){
  var table = document.getElementById('table');
  var request = new XMLHttpRequest();
  request.open('GET', 'http://localhost:8080/4to/Inventory/api/v1/get_all_dishes.php', true);
  request.send();
  request.onreadystatechange = function(){
    if (request.status == 200 && request.readyState == 4) {
      var json = JSON.parse(request.responseText);
      for (var i = 0; i < json.dishes.length; i++) {
        var dish = json.dishes[i];
        var tr = document.createElement('tr');
        var name = document.createElement('td');
        var price = document.createElement('td');

        name.innerHTML = dish.name;
        price.innerHTML = dish.price;

        tr.appendChild(name);
        tr.appendChild(price);
        table.appendChild(tr);
      }
    }
  }
}
