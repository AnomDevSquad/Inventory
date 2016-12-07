//Ging
var Ging = [];
var Size = 0;
//Data for graph
var Gdata = [];
//Graph lines
// var y1 = 170;
// var y2 = 470;

var pow = 0;
var rangee = 0;
var valrangee = 0;

//setInterval(updateGraph,1000);

//API STUFF
var urlApis = 'api/v1/';

function loadKS() {
    var x = new XMLHttpRequest(); //ajax request
    x.open('GET', urlApis + 'getKstockstats.php', true);
    x.send();
    x.onreadystatechange = function() {
        if (x.status == 200 && x.readyState == 4) {
            console.log(x.responseText);
            var jso = JSON.parse(x.responseText);
            if (jso.status == 0) {
                var array = jso.stats;

                for (var i = 0; i < array.length; i++) {
                    var data = array[i].qty;
                    Gdata.push(data);
                    var data = array[i].ing;
                    Ging.push(data);

                }
                console.log(Gdata);
                //draw chart
                var svg = document.createElementNS("http://www.w3.org/2000/svg", "svg");
                svg.setAttribute('id', 'svg');
                svg.setAttribute('width', '700px');
                svg.setAttribute('height', '700px');
                document.getElementById('main_content').appendChild(svg);
                chartRange();
                drawKStockChart(document.getElementById('svg'), document.getElementById('main_title'));
                addKChartValues(rangee);
            } else
                alert(JSONuser.errorMessage);

        }
    }
}


function addKChartValues(Grange) {
    //read values
    for (var i = 0; i < Ging.length; i++) {
        var sV = Gdata[i];
        //validations
        if (isNaN(sV)) sV = 0; //if invalid then 0

        var bar = document.getElementById('bar' + i);


        if (sV == 0) {
            bar.setAttribute('class', 'bar');
            bar.setAttribute('width', '1%');
        }
        var horizontalLine = document.getElementsByTagName('line')[1];
        var maxL = parseInt(horizontalLine.getAttribute('x2'));
        var minL = parseInt(horizontalLine.getAttribute('x1'));
        var space = maxL - minL;
        // var barWidth = sV * 6;
        // var barWidth = sV / 16;
        var barWidth = space * sV / Grange;
        if (barWidth != 0) bar.setAttribute('width', barWidth + '%');
    }
    clean();
}

function drawKStockChart(svgParent, titleParent) {
    //header
    titleParent.innerHTML = '<p>Current Kitchen Stock</p>';

    drawLine(svgParent, '30%', '70px', '30%', '600px', 'axis');
    drawLine(svgParent, '30%', '600px', '90%', '600px', 'axis');
    var count = 0;
    //horizontal
    for (var i = 0; i <= 10; i++) {
        drawLine(svgParent, (30 + count) + '%', '600px', (30 + count) + '%', '610px', 'axis');
		var st = Math.round(i*(valrangee * (pow / 10)));
        writeText(svgParent, 'name' + i, (30 + count) + '%', '625',st, '');
        count += 6;
    }
    count = 0;
    var verticalLine = document.getElementsByTagName('line')[0];
    var separator = ((parseInt(verticalLine.getAttribute('y2')) - 75) / Ging.length);
    //vertical
    for (var i = 0; i < Ging.length; i++) {
        drawRectangle(svgParent, 'bar' + i, '30%', (count + 70), '1%', separator - 5, 'bar');
        writeText(svgParent, 'name' + i, '28%', (count + 70) + (separator / 2), Ging[i], 'name');
        count += separator;
    }
}

function chartRange() {
    var big = Gdata[0];
    var s = 0;
    for (var x = 0; x < Gdata.length; x++) {
        s += Gdata[x];
    }
    //var prom = s / Gdata.length;
    var multi = getMultiplier(big);
    pow = getPower(big);
    if (big - (multi * pow) <= 50)
        rangee = multi * pow;// + 50;
    else
        rangee = multi * pow + 100;

    //rangee = Math.round(((big+pow)/pow)) * pow;
    valrangee = rangee / pow;
    console.log(pow);
    console.log(rangee);
    console.log(valrangee);
}

function getPower(n) {
    var m = 1;
    while ((m * 10) < n) m *= 10;

    return m;
}

function getMultiplier(n) {
    var s = '' + n;
    return parseInt(s[0]);
}
