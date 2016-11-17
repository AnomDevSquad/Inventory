var total = 0;

function init() {
    loadDishes();
}

function loadDishes() {
    var table = document.getElementById('table');
    var request = new XMLHttpRequest();
    request.open('GET', 'http://localhost:8080/4to/Inventory/api/v1/get_all_dishes.php', true);
    request.send();
    request.onreadystatechange = function() {
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
                button.setAttribute('onclick', 'addToForm(this.id)');

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

function addToForm(id) {
    var form = document.getElementById('form');
    var item = document.getElementById(id);
    var label = createLabel(form, item.getAttribute('id'), item.innerHTML);
    var input = createInput(form, item.getAttribute('id'), 'number', item.innerHTML);
    createDiv(form, [label, input], '', 'input-field');
}

class Order {
    constructor(jsonOrder) {
        this._order = document.createElement('div');
        var title = document.createElement('div'),
            details = document.createElement('div'),
            headers = document.createElement('div'),
            content = document.createElement('div')
            bill = document.createElement('div');
    }

    draw(parent) {
        parent.appendChild(this._order);
    }
}
