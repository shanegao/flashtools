var debugConn:LocalConnection;
var txts = new Array(panel.allTxt, panel.sendTxt, panel.getTxt, panel.outputTxt, panel.errorTxt);
var btns = new Array(panel.allBtn, panel.sendBtn, panel.getBtn, panel.outputBtn, panel.errorBtn);
var btnNames = new Array("All", "Send", "Get", "Output", "Error");
init();
function init() {
	debugConn = new LocalConnection();
	debugConn.addMsg = function(txt, className, fileName, num) {
		addMsg(txt, className, fileName, num);
	};
	debugConn.connect("showLogInDebugPanel");
	//
	Stage.align = "TL";
	Stage.scaleMode = "noScale";
	var stageLis = new Object();
	stageLis.onResize = reSize;
	Stage.addListener(stageLis);
}
function reSize() {
	var w = Stage.width;
	var h = Stage.height;
	//
	panel.back._width = w;
	panel.back._height = h;
	//
	for (var i = txts.length; --i >= 0; ) {
		txts[i].setSize(w - 20, h - txts[i]._y - 10);
	}
}
function addMsg(txt:String, className:String, fileName:String, num:Number) {
	className = className == null ? "":className;
	fileName = fileName == null ? "":fileName;
	num = num == null ? -1:num;
	//
	txt = parseTxt(txt);
	var str:String = "";
	var color:String;
	var type:String;
	//
	var titleArray:Array = ["[SEND]", "[GET]", "[ERROR]"];
	var typeArray:Array = ["send", "get", "error"];
	var colorArray:Array = ["#009900", "#FF9900", "#FF0000"];
	//
	var finded:Boolean = false;
	for(var i = 0 ; i < titleArray.length ; i++)
	{
		if(txt.indexOf(titleArray[i]) != -1)
		{
			color = colorArray[i];
			type = typeArray[i];
			finded = true;
			break;
		}
	}
	if(!finded)
	{
		color = "#3079BC";
		type = "output";
	}
	str += "<font color='" + color + "'><b>" + txt + "</b></font>";
	str += "  <font size='-2' color='#CCCCCC'>[" + className + " " + num + "]</font>";
	panel[type + "Txt"].text += str;
	panel.allTxt.text += str;
	panel[type + "Txt"].vPosition = panel[type + "Txt"].maxVPosition;
	panel.allTxt.vPosition = panel.allTxt.maxVPosition;
}
function hideAll() {
	for (var i = txts.length; --i >= 0; ) {
		txts[i]._visible = false;
		btns[i].txt = txts[i];
		btns[i].label = btnNames[i];
	}
}
function showHideBtn(val) {
	for (var i = btns.length; --i >= 0; ) {
		btns[i]._visible = val;
	}
}
function parseTxt(str):String {
	while (str.indexOf("<") != -1) {
		var pos = str.indexOf("<");
		//trace(pos);
		str = str.substring(0, pos) + "&lt;" + str.substring(pos + 1);
	}
	while (str.indexOf(">") != -1) {
		var pos = str.indexOf(">");
		//trace(pos);
		str = str.substring(0, pos) + "&gt;" + str.substring(pos + 1);
	}
	return str;
}
