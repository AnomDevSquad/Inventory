function init() {
    initOrdersTemplate();
    initOrders();
}

function initOrders() {
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

function initOrdersTemplate() {
    document.getElementById('id')
    document.getElementById('action_1').innerHTML = 'New Order';
    document.getElementById('action_2').innerHTML = '';
    document.getElementById('action_3').innerHTML = '';
    document.getElementById('action_4').innerHTML = 'Order list';
    var p1 = document.createElement('p'),
        p2 = document.createElement('p'),
        pLogout = document.createElement('p');
    p1.innerHTML = 'Inventory';
    p2.innerHTML = 'Graphs';
    pLogout.innerHTML = 'Logout';
    document.getElementById('opt_1').innerHTML = '';
    document.getElementById('opt_2').innerHTML = '';
    document.getElementById('opt_3').innerHTML = '';
    document.getElementById('opt_1').appendChild(p1);
    document.getElementById('opt_2').appendChild(p2);
    document.getElementById('opt_3').appendChild(pLogout);
    p1.addEventListener('click', goInventory);
    p2.addEventListener('click', goGraphs);
    pLogout.addEventListener('click', closeSession);
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
