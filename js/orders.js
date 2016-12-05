var idCategory = [1, 2, 3, 4, 5];
var categoryName = ['Entrace', 'Sushi and Sashimi', 'Main Course', 'Tempura', 'Drinks'];
var total = 0;
var iva = 0;
var itemsArray = [];

function init() {
    initOrdersTemplate();
}

function initOrdersTemplate() {
    var opt1 = document.createElement('p');
    var opt2 = document.createElement('p');
    templateElements().titles.principal.innerHTML = 'ORDERS';
    templateElements().actions.action1.innerHTML = 'New order';
    templateElements().actions.action2.innerHTML = 'Show orders';
    templateElements().actions.action3.parentNode.removeChild(templateElements().actions.action3);
    templateElements().actions.action4.parentNode.removeChild(templateElements().actions.action4);
    opt1.innerHTML = 'Inventory';
    opt2.innerHTML = 'Graphs';
    templateElements().options.option1.innerHTML = '';
    templateElements().options.option2.innerHTML = '';
    templateElements().options.option1.appendChild(opt1);
    templateElements().options.option2.appendChild(opt2);

    templateElements().options.option1.addEventListener('click', goInventory);
    templateElements().options.option2.addEventListener('click', goGraphs);

    templateElements().actions.action1.addEventListener('click', initNewOrder);
    templateElements().actions.action2.addEventListener('click', initOrders);

}

function initNewOrder() {
    document.getElementById('main_content').innerHTML = '';
    var content = document.querySelector('#main_content');
    var request = new XMLHttpRequest();
    request.open('GET', 'api/v1/get_all_dishes.php', true);
    request.send();
    request.onreadystatechange = function() {
        if (request.status == 200 && request.readyState == 4) {
            loadDishes(content, request.responseText);
        }
    }
}

function loadDishes(content, data) {
  var menu = create(content, 'div', ['id', 'class'], ['menu', 'menu']);
  var order = create(content, 'div', ['id', 'class'], ['client_order', 'client_order']);
  create(menu, 'div', ['id', 'class'], ['', 'title'], 'Menu');
  var food_menu = create(menu, 'div', ['id', 'class'], ['food_menu', 'food_menu']);
  create(order, 'div', ['id', 'class'], ['', 'title'], 'Client order');
  for (var i = 0; i < categoryName.length; i++) {
    create(food_menu, 'div', ['id', 'class'], [idCategory[i], 'category'], '<p class="title">'+ categoryName[i] +'</p>');
  }
  var json = JSON.parse(data);
  var dishes = json.dishes;
  for (var i = 0; i < dishes.length; i++) {
    var item = dishes[i];
    var category = document.getElementById(item.category);
    var dish = create(category, 'div', ['id', 'class', 'onclick'], ['dish_'+item.id, 'dish', 'addDish(this.id)']);
    var picture = create(dish, 'span', ['id', 'class'], ['', 'picture']);
    create(dish, 'span', ['id', 'class'], ['', 'name'], item.name);
    create(dish, 'span', ['id', 'class'], ['', 'price'], '$ '+item.price.toFixed(2));
    create(picture, 'img',['src'],['img/dishes/'+item.id+'.jpg']);
  }
  var form = create(order, 'form', ['id', 'method'], ['form', 'post']);
  var orderDishes = create(order, 'div', ['id', 'class'], ['order_content', 'order_dishes']);
  var bill = create(order, 'div', ['id', 'class'], ['bill', 'bill']);
  var subtotal = create(bill, 'div', ['id', 'class'], ['subtotal', 'subtotal']);
  var tax = create(bill, 'div', ['id', 'class'], ['tax', 'tax']);
  var total = create(bill, 'div', ['id', 'class'], ['total', 'total']);
  var controls = create(order, 'div', ['id', 'class'], ['controls', 'controls']);

  create(subtotal, 'span', ['class'], ['amount_type'], 'SubTotal');
  create(subtotal, 'span', ['id', 'class'], ['subtotal-number','money'], '$ 0');
  create(tax, 'span', ['class'], ['amount_type'], 'Tax');
  create(tax, 'span', ['id', 'class'], ['tax-number','money'], '$ 0');
  create(total, 'span', ['class'], ['amount_type'], 'Total');
  create(total, 'span', ['id', 'class'], ['total-number','money'], '$ 0');
  create(controls, 'button', ['id', 'class', 'onclick'], ['accept', 'btn', 'accept()'], 'Accept');
  create(controls, 'button', ['id', 'class', 'onclick'], ['accept', 'btn', 'cancel()'], 'Cancel');
}

function addDish(id) {
  var item = document.getElementById(id);
  var dish = item.cloneNode(true);
  var order = document.getElementById('order_content');
  dish.setAttribute('id', '_'+id.slice(5, id.length));
  dish.setAttribute('onclick', 'removeDish(this.id)');
  var dishName = dish.childNodes[1].innerHTML;
  if (validateCombo(order, dishName)) {
    var getSimilarDish = document.getElementById('_'+id.slice(5, id.length));
    var getCombo = parseInt(getSimilarDish.childNodes[3].innerHTML.slice(1));
    getSimilarDish.childNodes[3].innerHTML = 'X' + (getCombo + 1);
  } else {
    create(dish, 'span', ['id', 'class'], ['combo', 'combo'], 'X1');
    order.appendChild(dish);
  }
  calculateTotalAndTax();
}

function validateCombo(order, dishName){
  var isSimilar = false;
  for (var i = 0; i < order.childNodes.length; i++) {
    if (order.childNodes[i].childNodes[1].innerHTML == dishName) {
      isSimilar = true;
    }
  }
  return isSimilar;
}

function removeDish(id) {
  var item = document.getElementById(id);
  var getCombo = parseInt(item.childNodes[3].innerHTML.slice(1)) - 1;
  if (getCombo <= 0) {
    item.parentNode.removeChild(item);
  } else {
    item.childNodes[3].innerHTML = 'X' + getCombo;
  }
  calculateTotalAndTax();
}

function calculateTotalAndTax(){
  var dishes = document.getElementById('order_content');
  if (dishes.childNodes.length > 0) {
    var sum = [];
    for (var i = 0; i < dishes.childNodes.length; i++) {
      var item = dishes.childNodes[i];
      var price = parseFloat(item.childNodes[2].innerHTML.slice(2));
      var combo = parseFloat(item.childNodes[3].innerHTML.slice(1));
      sum.push((price*combo));
    }
    var subtotal = 0;
    for (var i = 0; i < sum.length; i++) {
      subtotal += sum[i];
    }
    var tax = (subtotal * 16)/100;
    var total = tax + subtotal;
    document.getElementById('tax-number').innerHTML = '$ ' + tax.toFixed(2);
    document.getElementById('subtotal-number').innerHTML = '$ ' + subtotal.toFixed(2);
    document.getElementById('total-number').innerHTML = '$ ' + total.toFixed(2);
  } else {
    document.getElementById('tax-number').innerHTML = '$ 0';
    document.getElementById('subtotal-number').innerHTML = '$ 0';
    document.getElementById('total-number').innerHTML = '$ 0';
  }
}

function accept() {
  var dishes = document.getElementById('order_content');
  var form = document.getElementById('form');
  if (dishes.childNodes.length > 0) {
    for (var i = 0; i < dishes.childNodes.length; i++) {
      var item = dishes.childNodes[i];
      create(form, 'input', ['type', 'name', 'value'], ['hidden', 'dishes[]', item.id.slice(1)]);
      create(form, 'input', ['type', 'name', 'value'], ['hidden', 'combos[]', item.childNodes[3].innerHTML.slice(1)]);
    }
    create(form, 'input',['type', 'name', 'value'], ['hidden', 'subtotal', document.getElementById('subtotal-number').innerHTML.slice(2)]);
    create(form, 'input',['type', 'name', 'value'], ['hidden', 'tax', document.getElementById('tax-number').innerHTML.slice(2)]);
    var request = new XMLHttpRequest();
    request.open('POST', 'api/v1/add_order.php', true);
    var data = new FormData(form);
    request.send(data);
    request.onreadystatechange = function() {
      if (request.status == 200 && request.readyState == 4) {
        console.log(request.responseText);
      }
    }
  }
}

function cancel(){
  alert('cancel')
}

function initOrders() {
    document.getElementById('main_content').innerHTML = '';
    // obtener las ordenes
    var ordersRequest = new XMLHttpRequest();
    ordersRequest.open('GET', 'api/v1/get_orders.php', true);
    ordersRequest.send();
    ordersRequest.onreadystatechange = function() {
        if (ordersRequest.status == 200 && ordersRequest.readyState == 4) {
            var json = JSON.parse(ordersRequest.responseText);
            if (json.status == 0) {
                var orders = json.orders;
                //console.log(orders);
                for (var i = 0; i < orders.length; i++) {
                    var order = new Order(orders[i]);
                    order.draw(document.getElementById('main_content'));
                }
            }
        }
    }
}

// para armar las ordenes
class Order {
    constructor(jsonOrderObj) {
        this._no = jsonOrderObj.id;
        this._dishes = jsonOrderObj.details;
        this._subtotal = jsonOrderObj.subtotal;
        this._tax = jsonOrderObj.taxAmount;
        this._total = jsonOrderObj.total;

        this.div = document.createElement('div');
        this.divHeader = document.createElement('div');
        this.dishes = new DishList(this._dishes);
        this.divBill = document.createElement('div');
        this.divSubtotal = document.createElement('div');
        this.divTax = document.createElement('div');
        this.divTotal = document.createElement('div');
        this.divTitle = document.createElement('div');
        this.pTitle = document.createElement('p');
        this.pSubtotalTitle = document.createElement('p');
        this.pTaxTitle = document.createElement('p');
        this.pTotalTitle = document.createElement('p');
        this.pSubtotal = document.createElement('p');
        this.pTax = document.createElement('p');
        this.pTotal = document.createElement('p');

        this.div.appendChild(this.divHeader);
        this.dishes.draw(this.div);
        this.div.appendChild(this.divBill);

        this.divHeader.appendChild(this.pTitle);
        this.divBill.appendChild(this.divSubtotal);
        this.divBill.appendChild(this.divTax);
        this.divBill.appendChild(this.divTotal);

        this.divSubtotal.appendChild(this.pSubtotalTitle);
        this.divSubtotal.appendChild(this.pSubtotal);
        this.divTax.appendChild(this.pTaxTitle);
        this.divTax.appendChild(this.pTax);
        this.divTotal.appendChild(this.pTotalTitle);
        this.divTotal.appendChild(this.pTotal);
        this.pTotal.innerHTML = this._total;

        this.div.setAttribute('class', 'order');
        this.divHeader.setAttribute('class', 'header');
        this.pTitle.setAttribute('class', 'title');
        this.divBill.setAttribute('class', 'bill');
        this.divSubtotal.setAttribute('class', 'subtotal');
        this.divTax.setAttribute('class', 'tax');
        this.divTotal.setAttribute('class', 'total');
        this.pSubtotalTitle.setAttribute('class', 'title');
        this.pTaxTitle.setAttribute('class', 'title');
        this.pTotalTitle.setAttribute('class', 'title');
        this.pSubtotal.setAttribute('class', 'money');
        this.pTax.setAttribute('class', 'money');
        this.pTotal.setAttribute('class', 'money');

        this.pTitle.innerHTML = 'Order #' + this._no;
        this.pSubtotalTitle.innerHTML = 'Subtotal';
        this.pTaxTitle.innerHTML = 'Tax';
        this.pTotalTitle.innerHTML = 'Total';
        this.pSubtotal.innerHTML = this._subtotal;
        this.pTax.innerHTML = this._tax;
    }

    draw(parent) {
        parent.appendChild(this.div);
    }

    toString() {
        return this._no;
    }
}

class DishList {
    constructor(jsonDishesArray) {
        this._dishes = jsonDishesArray;

        this.div = document.createElement('div');
        this.divHeader = document.createElement('div');
        this.divList = document.createElement('div');
        this.pName = document.createElement('p');
        this.pQuantity = document.createElement('p');
        this.pPrice = document.createElement('p');
        this.pSubtotal = document.createElement('p');

        this.divHeader.appendChild(this.pName);
        this.divHeader.appendChild(this.pQuantity);
        this.divHeader.appendChild(this.pPrice);
        this.divHeader.appendChild(this.pSubtotal);
        this.div.appendChild(this.divHeader);
        this.div.appendChild(this.divList);

        // llenar la lista de platillos
        for (var i = 0; i < this._dishes.length; i++) {
            var dish = new Dish(this._dishes[i]);
            dish.draw(this.divList);
        }

        this.div.setAttribute('class', 'dishes');
        this.divHeader.setAttribute('class', 'header');
        this.divList.setAttribute('class', 'list');
        this.pName.setAttribute('class', 'name');
        this.pQuantity.setAttribute('class', 'quantity');
        this.pPrice.setAttribute('class', 'price');
        this.pSubtotal.setAttribute('class', 'subtotal');

        this.pName.innerHTML = 'Name';
        this.pQuantity.innerHTML = 'Quantity';
        this.pPrice.innerHTML = 'Price';
        this.pSubtotal.innerHTML = 'Subtotal';
    }

    draw(parent) {
        parent.appendChild(this.div);
    }

    add(dishObj) {
        dishObj.draw(this.div);
    }
}

class Dish {
    constructor(jsonDishObj) {
        this._name = jsonDishObj.dish.name;
        this._quantity = jsonDishObj.quantity;
        this._price = jsonDishObj.dish.price;
        this._subtotal = this._quantity * this._price;

        this.div = document.createElement('div');
        this.pName = document.createElement('p');
        this.pQuantity = document.createElement('p');
        this.pPrice = document.createElement('p');
        this.pSubtotal = document.createElement('p');

        this.div.appendChild(this.pName);
        this.div.appendChild(this.pQuantity);
        this.div.appendChild(this.pPrice);
        this.div.appendChild(this.pSubtotal);

        this.div.setAttribute('class', 'dish');
        this.pName.setAttribute('class', 'name');
        this.pQuantity.setAttribute('class', 'quantity');
        this.pPrice.setAttribute('class', 'price');
        this.pSubtotal.setAttribute('class', 'subtotal');

        this.pName.innerHTML = this._name;
        this.pQuantity.innerHTML = this._quantity;
        this.pPrice.innerHTML = '$' + this._price;
        this.pSubtotal.innerHTML = '$' + this._subtotal;
    }

    draw(parent) {
        parent.appendChild(this.div);
    }
}
