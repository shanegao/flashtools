/**
 * @author Gaoxian
 */
class StageListener {
	
	public function StageListener(){
		
		Stage.align = "TL";
		Stage.scaleMode = "noScale";
		Stage.showMenu = false ;
		// create a new stage listener
		var _this = this;
		var lis:Object = new Object();
		lis.onResize = function():Void  {
			var w:Number = Stage.width ;
			var h:Number = Stage.height ;
			//
			DataPool.STAGE_WIDTH = w;
			DataPool.STAGE_HEIGHT = h;
			//
			_this.onResize();			
		};
		Stage.addListener(lis);
		
	}
	public function onResize():Void{		
	}
	
}