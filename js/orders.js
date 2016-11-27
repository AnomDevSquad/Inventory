var idCateory = [1,2,3,4,5];
var categoryName = ['Entrace','Sushi and Sashimi','Main Course','Tempura','Drinks'];
var total = 0;
var iva = 0;
var arrayItems = [];

function orderInit(){
  setTimeout(dishesRequest, 1000);
}

function dishesRequest(){
  document.querySelector('#main_title').innerHTML = "Menu";
  var content = document.querySelector('#main_content');
  var request = new XMLHttpRequest();
  request.open('GET', 'http://localhost:8080/4to/Inventory/api/v1/get_all_dishes.php', true);
  request.send();
  request.onreadystatechange = function(){
    if (request.status == 200 && request.readyState == 4) {
      loadSections(content)
      loadDishes(request.responseText);
    }
  }
}

function loadSections(content){
  var menu = create(content, 'div', ['id', 'class'], ['menu', ''])
  for (var i = 0; i < categoryName.length; i++) {
    create(menu, 'div', ['id', 'class'], ["category_"+idCateory[i], 'category'], '<p>'+categoryName[i]+'</p>');
  }
}

function loadDishes(data){
  var json = JSON.parse(data);
  var dishes = json.dishes;
  for (var i = 0; i < dishes.length; i++) {
    var item = dishes[i];
    var section = document.getElementById('category_'+item.category);
    create(section, 'button', ['id', 'value', 'onclick'], ['dish_'+item.id, 'button', 'addDish(this.id)'], item.name + ", $ " + item.price + " DLLS");
  }
  var content = document.querySelector('#main_content');
  var order = create(content, 'div', ['id', 'class'], ['orders', ''], 'Orders');
  create(order, 'div', ['id'], ['dishes']);
}

function addDish(id){
  var dishes = document.getElementById('dishes');
  var dish = document.getElementById(id).cloneNode(true);
  dish.setAttribute('id', id.slice(5, id.length));
  dish.setAttribute('onclick', 'removeDish(this.id);');
  dishes.appendChild(dish);
}

function removeDish(id){
  var item = document.getElementById(id);
  alert(item.innerHTML);
  item.parentNode.removeChild(item);
}
