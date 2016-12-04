var idCategory = [1, 2, 3, 4, 5];
var categoryName = ['Entrace', 'Sushi and Sashimi', 'Main Course', 'Tempura', 'Drinks'];
var total = 0;
var iva = 0;
var itemsArray = [];

var urlAPI = 'http://localhost:8080/4to/Inventory/';

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
            loadSections(content);
            loadDishes(request.responseText);
        }
    }
}

function loadSections(content) {
    var menu = create(content, 'div', ['id', 'class'], ['menu', '']);
    for (var i = 0; i < categoryName.length; i++) {
        create(menu, 'div', ['id', 'class'], ["category_" + idCategory[i], 'category'], '<p>' + categoryName[i] + '</p>');
    }
}

function loadDishes(data) {
    var json = JSON.parse(data);
    var dishes = json.dishes;
    for (var i = 0; i < dishes.length; i++) {
        var item = dishes[i];
        var section = document.getElementById('category_' + item.category);
        var button = create(section, 'button', ['id', 'onclick', 'price'], ['dish_' + item.id, 'addDish(this.id)', item.price], '');
        var divContent = create(button, 'div', ['class'], ['picture']);
        create(divContent, 'img', ['src'], ['img/dishes/'+item.id + '.jpg']);
        create(button, 'p', ['class'], ['name'], item.name);
        create(button, 'p', ['class'], ['price'], ' $ ' + item.price + ' DLLS ');
    }
    var content = document.querySelector('#main_content');
    var order = create(content, 'div', ['id', 'class'], ['orders', '']);
    create(order, 'p', ['id'], ['title'], 'Orders');
    create(order, 'div', ['id'], ['dishes']);
    var form = create(order, 'form', ['id', 'method'], ['form', 'post']);
    create(form, 'input', ['id', 'class', 'onclick', 'type', 'value'], ['submit', 'btn', 'buy();', 'button', 'Buy']);
}

function addDish(id) {
    var dishes = document.getElementById('dishes');
    var dish = document.getElementById(id).cloneNode(true);
    dish.setAttribute('id', id.slice(5, id.length));
    dish.setAttribute('onclick', 'removeDish(this.id);');
    dishes.appendChild(dish);
}

function removeDish(id) {
    var item = document.getElementById(id);
    item.parentNode.removeChild(item);
}

function buy() {
    var dishes = document.getElementById('dishes').childNodes;
    for (var i = 0; i < dishes.length; i++) {
        itemsArray.push(dishes[i].getAttribute('id'));
    }
    var form = document.getElementById('form');
    for (var i = 0; i < itemsArray.length; i++) {
        create(form, 'input', ['id', 'type', 'name', 'value'], [itemsArray[i], 'hidden', 'dishes[]', itemsArray[i]]);
    }
    var request = new XMLHttpRequest();
    request.open('POST', 'api/v1/add_order.php', true);
    var data = new FormData(form);
    request.send(data);
    request.onreadystatechange = function() {
        if (request.status == 200 && request.readyState == 4) {
            console.log(request.responseText);
        }
    }
    alert('Gracias por su compra');
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
