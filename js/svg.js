function drawLine(svgParent,x1,y1,x2,y2,cssClass)
{
	//create element
	var line = document.createElementNS('http://www.w3.org/2000/svg','line');
	//start point and end point
	line.setAttribute('x1',x1);
	line.setAttribute('y1',y1);
	line.setAttribute('x2',x2);
	line.setAttribute('y2',y2);
	//class
	line.setAttribute('class',cssClass);
	//add to parent
	svgParent.appendChild(line);
}

function writeText(svgParent,id,x,y,innerText,cssClass)
{
	//create element
	var t= document.createElementNS('http://www.w3.org/2000/svg','text');
	//position
	t.setAttribute('x',x);
	t.setAttribute('y',y);
	//text
	t.innerHTML = innerText;
	//class
	t.setAttribute('class',cssClass);
	//add to parent
	svgParent.appendChild(t);
}

function drawRectangle(svgParent,id,x,y,width,height,cssClass)
{
	var rect = document.createElementNS('http://www.w3.org/2000/svg','rect');
	rect.setAttribute('id',id);
	rect.setAttribute('x',x);
	rect.setAttribute('y',y);
	rect.setAttribute('width',width);
	rect.setAttribute('height',height);
	rect.setAttribute('class',cssClass);
	
	svgParent.appendChild(rect);
	
}

function drawCircle(svgParent,cx,cy,dataValue,r)
{
	//create element
	var circle = document.createElementNS('http://www.w3.org/2000/svg','circle');
	//position, value and radiues
	circle.setAttribute('cx',cx);
	circle.setAttribute('cy',cy);
	circle.setAttribute('data-value',dataValue);
	circle.setAttribute('r',r);
	//add to parent
	svgParent.appendChild(circle);
}







