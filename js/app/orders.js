var total = 0;

function init(){
  loadDishes();
}

function loadDishes(){
  var table = document.getElementById('dishes');
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
        var button = document.createElement('button');

        price.setAttribute('id', dish.id);

        button.setAttribute('id', dish.id);
        button.setAttribute('price', dish.price);
        button.setAttribute('class', 'btn');
        button.setAttribute('onclick', 'get_dish(this.id)');

        button.innerHTML = dish.name;
        price.innerHTML = dish.price;

        name.appendChild(button);
        tr.appendChild(name);
        tr.appendChild(price);
        table.appendChild(tr);
      }
    }
  }
}

function get_dish(id){
  var price = document.getElementById(id).getAttribute('price');
  var t = document.getElementById('total');
  total += parseInt(price);
  t.innerHTML = total;
}

function buy(){
  if (total > 0) {
    alert("Total: " + total);
  } else {
    alert("You not selected anything Order");
  }
}
