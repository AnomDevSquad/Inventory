function actionsInit(){
  document.getElementById('orders').addEventListener('click', go_orders);
  document.getElementById('inventory').addEventListener('click', go_inventory);
  document.getElementById('graphs').addEventListener('click', go_graphs);
}

function go_orders(){
  location = 'orders.html';
}
function go_inventory(){
  location = 'inventory.html';
}
function go_graphs(){
  location = 'graphs.html';
}
