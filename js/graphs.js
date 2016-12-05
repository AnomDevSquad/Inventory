function init() {
    document.getElementById('title').innerHTML = 'CHARTS';
    var a = ['Sales','Income','Kitchen Stock','Warehouse Stock'];
    var v = ['sales();','income();','kitchenS();','warehouseS();'];
    for(var x = 0; x < 4; x++){
      var id = document.getElementById('action_'+(x+1));
      id.innerHTML = a[x];
      id.setAttribute('onClick', v[x]);
    }


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

function kitchenS() {
    document.getElementById('main_title').innerHTML = '';
    document.getElementById('main_content').innerHTML = '';
    loadKS();
}

function warehouseS() {
    document.getElementById('main_title').innerHTML = '';
    document.getElementById('main_content').innerHTML = '';
    loadWS();
}
