//******************************************
//	123 Flash Chat Software
//	Copyright (c) 2006 TopCMM SOFTWARE
//******************************************
/** 
 * 此类是XML格式和Object之间的转换。
 * 但是XML和Object之间的转换并不是互逆的。
 * 此类的转换主要目的是用于和服务器交互的数据处理。
 * 也就是说，如果将一个XML文件通过此类转换成Object，然后再通过此类转换成XML，和最开始的XML不相等。
 * 如果要得到XML和Object的互逆转换，请使用ObjectParser类。
 * @author		Tim
 * @version		123flashchat 7.0, ActionScript 2.0, FlashPlayer 8.0
 */
class topcmm.datas.XMLParser {
	//----------------------------------	variable	-----------------------------------
	private static var __xmlObj:Object;
	private static var __xml:XML;
	
	/**
	 * 将一个XML文件转换成Object 
	 * @param   xml 必须，XML格式的数据。
	 * @return  通过XML转换而成的Object对象。
	 */
	public static function XML2Object(xml:XML):Object {
		if (xml != null) {
			return parseXml(xml.firstChild);
		}else{
			return null;
		}
	}
	
	/**
	 * 将Object转换成XML格式
	 * @param obj 一个需要转换成XML对象的Object对象
	 * @param xmlName XML对象的根节点名称
	 * @return 返回通过Object对象转换而成的XML对象
	 */
	public static function Object2XML(obj:Object, xmlName:String):XML{
		return beginParseObject(obj, xmlName);
	}

	private static function parseXml(xml:XMLNode):Object {
		var nodeObj:Object = new Object();
		nodeObj.attrib = xml.attributes;
		nodeObj.value = xml.firstChild.nodeValue;
		if(nodeObj.value == null){
			nodeObj.value = "";
		}
		var thisNode:XMLNode = xml.firstChild;
		while(thisNode != null){
			var newName:String = thisNode.nodeName;
			if (nodeObj[newName] == null) {
				nodeObj[newName] = parseXml(thisNode);
				nodeObj[newName + "0"] = nodeObj[newName];
			} else {
				var nodeCount:Number = 1;
				while(nodeObj[newName + nodeCount] != null){
					nodeCount++;
				}
				nodeObj[newName + nodeCount] = parseXml(thisNode);
			}
			thisNode = thisNode.nextSibling;
		}
		return nodeObj;
	}

	private static function beginParseObject(obj:Object, xmlName:String):XML{
		__xml = new XML(parseObject(obj, xmlName));
		return __xml;
	}

	private static function parseObject(obj:Object, nodeName:String):String{
		var str:String = "<" + nodeName + " ";
		var str1:String = "";
		var str2:String = "";
		for(var v in obj){
			switch(typeof obj[v]){
				case "number":
				case "string":
					str1 += v + "=\"" + obj[v].toString() + "\" ";
					break;
				case "boolean":
				if(obj[v]){
						str1 += v + "=\"1\" ";
				}else{
						str1 += v + "=\"0\" ";
				}
					break;
				case "object":
				if(obj[v] instanceof Array){
						for(var i = obj[v].length ; --i >= 0 ; ){
							str2 += parseObject(obj[v][i], nodeName + i.toString());	
					}
				}else{
						str2 += parseObject(obj[v], v);
				}
					break;
			}
		}
		str += str1 + ">" + str2 + "</" + nodeName + ">";
		return str;
	}
}
