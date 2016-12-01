function init() {
    document.getElementById('title').innerHTML = 'CHARTS';
    var id = document.getElementById('action_1');
    id.innerHTML = 'Sales';
    id.setAttribute('onClick', 'sales();');
    var id2 = document.getElementById('action_2');
    id2.innerHTML = 'Income';
    id2.setAttribute('onClick', 'income();');

    var element = document.getElementById('action_3');
    element.parentNode.removeChild(element);
    var element = document.getElementById('action_4');
    element.parentNode.removeChild(element);
    var opt1 = document.createElement('p');
    var opt2 = document.createElement('p');
    opt1.innerHTML = 'Orders';
    opt2.innerHTML = 'Inventory';
    templateElements().options.option1.innerHTML = '';
    templateElements().options.option2.innerHTML = '';
    templateElements().options.option1.appendChild(opt1);
    templateElements().options.option2.appendChild(opt2);

    templateElements().options.option1.addEventListener('click', goOrders);
    templateElements().options.option2.addEventListener('click', goInventory);
}

function sales() {
    document.getElementById('main_title').innerHTML = '';
    document.getElementById('main_content').innerHTML = '';
    loadGNS();
}

function income() {
    document.getElementById('main_title').innerHTML = '';
    document.getElementById('main_content').innerHTML = '';
    loadGI();
}
