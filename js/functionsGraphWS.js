//Ging
var Ging = [];
var Size = 0;
//Data for graph
var Gdata = [];


//setInterval(updateGraph,1000);

//API STUFF
var urlApis = 'api/v1/';

function loadWS() {
    var x = new XMLHttpRequest(); //ajax request
    x.open('GET', urlApis + 'getWstockstats.php', true);
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
                console.log(Ging);
                //draw chart
                var svg = document.createElementNS("http://www.w3.org/2000/svg", "svg");
                svg.setAttribute('id', 'svg');
                svg.setAttribute('width', '700px');
                svg.setAttribute('height', '700px');
                document.getElementById('main_content').appendChild(svg);
                chartRange();
                drawWStockChart(document.getElementById('svg'), document.getElementById('main_title'));
                addWChartValues(rangee);
            } else
                alert(JSONuser.errorMessage);

        }
    }
}


function addWChartValues(Grange) {
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

function drawWStockChart(svgParent, titleParent) {
    //header
    titleParent.innerHTML = '<p>Current Warehouse Stock</p>';
    // y axis
    drawLine(svgParent, '30%', '70px', '30%', '600px', 'axis');
    drawLine(svgParent, '30%', '600px', '90%', '600px', 'axis');
    var count = 0;
    for (var i = 0; i <= 10; i++) {
        drawLine(svgParent, (30 + count) + '%', '600px', (30 + count) + '%', '610px', 'axis');
		var st = Math.round(i*(valrangee * (pow / 10)));
        writeText(svgParent, 'name' + i, (30 + count) + '%', '625', st, '');
        count += 6;
    }
    count = 0;
    var verticalLine = document.getElementsByTagName('line')[0];
    var separator = ((parseInt(verticalLine.getAttribute('y2')) - 75) / Ging.length);

    for (var i = 0; i < Ging.length; i++) {
        drawRectangle(svgParent, 'bar' + i, '30%', (count + 70), '1%', separator - 5, 'bar');
        writeText(svgParent, 'name' + i, '28%', (count + 70) + (separator / 2), Ging[i], 'name');
        count += separator;
    }
}
