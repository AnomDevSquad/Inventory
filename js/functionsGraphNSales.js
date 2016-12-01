//Wdays
var Wdays = [];
var Size = 0;
//Data for graph
var Gdata = [];
//Graph lines
var y1 = 170;
var y2 = 470;

//setInterval(updateGraph,1000);

//API STUFF
var urlApis = 'http://localhost:8080/Inventory/api/v1/';

function loadGNS() {
    var x = new XMLHttpRequest(); //ajax request
    x.open('GET', urlApis + 'getweeksales.php', true);
    x.send();
    x.onreadystatechange = function() {
        if (x.status == 200 && x.readyState == 4) {
            console.log(x.responseText);
            var jso = JSON.parse(x.responseText);
            if (jso.status == 0) {
                var array = jso.totals;
                Size = array.length;
                for (var i = 0; i < array.length; i++) {
                    var data = array[i].total;
                    Gdata.push(data);
                    var data = array[i].day;
                    var d = new Date(data);
                    Wdays.push(Ndays[i] + ' ' + (d.getDate() + 1));

                }
                console.log(Wdays);
                //draw chart
                var svg = document.createElementNS("http://www.w3.org/2000/svg", "svg");
                svg.setAttribute('id', 'svg');
                svg.setAttribute('width', '700px');
                svg.setAttribute('height', '700px');
                document.getElementById('main_content').appendChild(svg);
                drawNSalesChart(document.getElementById('svg'), document.getElementById('main_title'));
                addChartValues();
            } else
                alert(JSONuser.errorMessage);

        }
    }
}


function addChartValues() {
    //read values
    for (var i = 0; i < Wdays.length; i++) {
        var ordN = Gdata[i];
        //validations
        if (isNaN(ordN)) ordN = 0; //if invalid then 0

        var bar = document.getElementById('bar' + i);


        if (ordN == 0) {
            bar.setAttribute('class', 'bar');
            bar.setAttribute('width', '1%');
        }

        var barWidth = ordN * 6;
        if (barWidth != 0) bar.setAttribute('width', barWidth + '%');
    }
    clean();
}

function drawNSalesChart(svgParent, titleParent) {
    //header
    //writeText(svgParent, '', '50%', '50px', 'Daily Sales' + ' (' + Wdays[0] + ' To ' + Wdays[6] + ')', 'header');
    titleParent.innerHTML = '<p>Daily Sales' + ' (' + Wdays[0] + ' To ' + Wdays[6] + ')</p>';
    // y axis
    drawLine(svgParent, '30%', '70px', '30%', '600px', 'axis');
    drawLine(svgParent, '30%', '600px', '90%', '600px', 'axis');
    var count = 0;
    for (var i = 0; i <= 10; i++) {
        drawLine(svgParent, (30 + count) + '%', '600px', (30 + count) + '%', '610px', 'axis');
        writeText(svgParent, 'name' + i, (30 + count) + '%', '625', i, '');
        count += 6;
    }
    count = 0;
    var verticalLine = document.getElementsByTagName('line')[0];
    var separator = ((parseInt(verticalLine.getAttribute('y2')) - 75) / Wdays.length);

    for (var i = 0; i < Wdays.length; i++) {
        drawRectangle(svgParent, 'bar' + i, '30%', (count + 70), '1%', separator - 5, 'bar');
        writeText(svgParent, 'name' + i, '28%', (count + 70) + (separator / 2), Wdays[i], 'name');
        count += separator;
    }
}
