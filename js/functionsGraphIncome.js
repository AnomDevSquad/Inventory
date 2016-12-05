//Wdays
var Wdays = [];
var Ndays = ['Mon', 'Tues', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun'];
var Size = 0;
//Data for graph
var Gdata = [];

//API STUFF
var urlApis = 'http://localhost:8080/Inventory/api/v1/';

function loadGI() {
    var x = new XMLHttpRequest(); //ajax request
    x.open('GET', urlApis + 'getweeksumsales.php', true);
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
                var svg = document.createElementNS("http://www.w3.org/2000/svg", "svg");
                svg.setAttribute('id', 'svg');
                svg.setAttribute('width', '700px');
                svg.setAttribute('height', '700px');
                document.getElementById('main_content').appendChild(svg);
                //draw chart
                drawIncomeChart(document.getElementById('svg'), document.getElementById('main_title'));
                defineLocation(document.getElementById('svg'), 1000);
            } else
                alert(jso.errorMessage);

        }
    }
}

function drawIncomeChart(svgParent, titleParent) {
    //header
    //writeText(titleParent, '', '50%', '50px', 'Income' + ' (' + Wdays[0] + ' To ' + Wdays[6] + ')', 'header');
    titleParent.innerHTML = '<p>Income' + ' (' + Wdays[0] + ' To ' + Wdays[6] + ')</p>';
    // y axis

    drawLine(svgParent, '20%', '70px', '20%', '600px', 'axis');
    drawLine(svgParent, '20%', '600px', '80%', '600px', 'axis');
    var count = 0;
    //horizontal lane
    for (var i = 0; i <= Wdays.length - 1; i++) {
        drawLine(svgParent, (20 + count) + '%', '600px', (20 + count) + '%', '610px', 'axis');
        writeText(svgParent, 'name' + i, (20 + count) + '%', '625', Wdays[i], '');
        count += 10;
    }
    count = 0;
    var verticalLine = document.getElementsByTagName('line')[0];
    var separator = ((parseInt(verticalLine.getAttribute('y2')) - 230) / Wdays.length);
    //vertical lane
    for (var i = 10; i >= 0; i--) {
        if (i != 0)
            drawLine(svgParent, '20%', (count + 65) + (separator / 2), '20.5%', (count + 65) + (separator / 2), 'axis');
        writeText(svgParent, 'name' + i, '19%', (count + 70) + (separator / 2), '$' + i * 100, 'name');

        count += separator;
    }
}

function defineLocation(svgParent, d) {
    var count = 0;
    var verticalLine = document.getElementsByTagName('line')[0];
    var topl = parseInt(verticalLine.getAttribute('y1'));
    var base = parseInt(verticalLine.getAttribute('y2'));
    var p = (base - topl) / d;
    var c = 15;
    for (var i = 0; i < Wdays.length; i++) {
        var ordN = Gdata[i];
        drawCircle(svgParent, (20 + count) + '%', base + c - (p * ordN), ordN, 3);
        count += 10;
    }
    count = 0;
    for (var i = 0; i < Wdays.length; i++) {
        var ordN = Gdata[i];
        var next = Gdata[i + 1];
        if (i < Wdays.length - 1)
            drawLine(svgParent, (20 + count) + '%', base + c - (p * ordN), (20 + count + 10) + '%', base + c - (p * next), 'axis');
        count += 10;
    }
    clean();
}

function clean() {
    Wdays = [];
    Gdata = [];
    Ging = [];
    pow = 0;
    rangee = 0;
    valrangee = 0;
}
