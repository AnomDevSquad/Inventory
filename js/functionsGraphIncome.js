//Wdays
var Wdays = []; 
var Size = 0;
//Data for graph
var Gdata = [];

//API STUFF
var urlApis = 'http://localhost:8080/svg/';

function init()
{
	var x = new XMLHttpRequest(); //ajax request
	x.open('GET', urlApis + 'getweeksumsales.php', true);
	x.send();
	x.onreadystatechange = function()
	{
		if (x.status == 200 && x.readyState == 4)
		{
			console.log(x.responseText);
			var jso = JSON.parse(x.responseText);
			if (jso.status == 0)
			{
				var array = jso.totals;
				Size = array.length;
				for(var i=0; i<array.length;i++)
				{
					var data = array[i].total;
					Gdata.push(data);
					var data = array[i].day;
					Wdays.push(data);
					
				}
				console.log(Wdays);
				//draw chart
				drawChart(document.getElementById('svg'));
				defineLocation(document.getElementById('svg'),1000);
			}
			else
				alert(jso.errorMessage);
			
		}
	}
	
	
	
	
}

function drawChart(svgParent){
	//header
	writeText(svgParent,'' ,'50%', '50px', 'Income'+' ('+Wdays[0]+' To '+Wdays[6]+')', 'header');
	// y axis
	
	drawLine(svgParent, '30%', '70px', '30%', '600px', 'axis');
	drawLine(svgParent, '30%', '600px', '90%', '600px', 'axis');
	var count = 0;
	//horizontal lane
	for (var i = 0; i <= Wdays.length; i++) {
		drawLine(svgParent,(30 + count) + '%', '600px', (30 + count) + '%', '610px', 'axis');
		writeText(svgParent,'name' + i, (30 + count) + '%', '625', Wdays[i], '');
		count += 10;
	}
	count = 0;
	var verticalLine = document.getElementsByTagName('line')[0];
	var separator = ((parseInt(verticalLine.getAttribute('y2')) - 230) / Wdays.length);
	//vertical lane
	for (var i = 10; i >= 0; i--) {
		drawLine(svgParent,'30%',(count + 65) + (separator / 2),'30.5%',(count + 65) + (separator / 2),'axis');
		writeText(svgParent, 'name' + i, '29%', (count + 70) + (separator / 2), '$'+i * 100, 'name');
		
		count += separator;
	}
}

function defineLocation(svgParent,d){
	var count = 0;
	var verticalLine = document.getElementsByTagName('line')[0];
	var topl = parseInt(verticalLine.getAttribute('y1'));
	var base = parseInt(verticalLine.getAttribute('y2'));
	var p = (base - topl)/d;
	var c = 15;
	for(var i=0; i< Wdays.length; i++)
	{
		var ordN = Gdata[i];
		drawCircle(svgParent,(30 + count) + '%', base + c - (p * ordN),ordN,3);
		count+=10;
	}
	count=0;
	for(var i=0; i< Wdays.length; i++)
	{
		var ordN = Gdata[i];
		var next = Gdata[i+1];
		if(i < Wdays.length-1)
		drawLine(svgParent,(30 + count) + '%', base + c - (p * ordN),(30 + count +10) + '%',base + c - (p * next),'axis');
		count+=10;
	}
}



































