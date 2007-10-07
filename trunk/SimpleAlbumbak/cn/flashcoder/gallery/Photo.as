package cn.flashcoder.gallery
{
	import flash.display.Sprite;
	import flash.net.URLRequest;
	import flash.events.*;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	
		
	public class Photo extends Sprite
	{
		private var _src : String;
		private var _name : String ;
		private var origX : Number , origY:Number ;
		public function Photo(src:String,name:String)
		{
			_src = src ;
			_name = name ;
			var thisLdr : Loader = new Loader();
			thisLdr.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderCompleteHandler);
			thisLdr.load(new URLRequest(_src));
			addChild(thisLdr);
		}
		
		private function loaderCompleteHandler(evt:Event):void 
		{
			var thisLdr:Loader = evt.target.loader as Loader;
			
			// set local variables for the target movie clip's width and height,
			// and the desired settings for the image stroke and border.
			var thisWidth:Number = thisLdr.width;
			var thisHeight:Number = thisLdr.height;
			var borderWidth:Number = 2;
			var marginWidth:Number = 8;
			var totalMargin:Number = borderWidth + marginWidth;
			var totalWidth:Number = thisWidth + (totalMargin * 2);
			var totalHeight:Number = thisHeight + (totalMargin * 2);
		
			// draw a white rectangle with a black stroke around the images.
			this.graphics.lineStyle(borderWidth, 0x000000, 100);
			this.graphics.beginFill(0xFFFFFF, 100);
			this.graphics.drawRect(-totalMargin, -totalMargin, totalWidth, totalHeight);
			this.graphics.endFill();
		
			// scale the target movie clip so it appears as a thumbnail. 
			// This allows users to quickly view a full image without downloading it every time, 
			// but unfortunaltey also causes a large initial download.
			this.scaleX = 0.2;
			this.scaleY = 0.2;
		
			// rotate the current image (and borders) anywhere from -5 degrees to +5 degrees.
			this.rotation = Math.round(Math.random() * - 10) + 5;
		
			this.origX = this.x;
			this.origY = this.y;
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			this.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
		}
	
		private function mouseDownHandler(evt:MouseEvent):void
		{
			//var thisMC:Sprite = evt.target as Sprite;
			this.startDrag();
			this.scaleX = 1;
			this.scaleY = 1;
			//setChildIndex(thisMC, numChildren - 1);
		
			this.x = int((stage.stageWidth - this.width + 20) / 2);
			this.y = int((stage.stageHeight - this.height + 20) / 2);
		/*
			var transitionProps:Object = {type:Photo, direction:0, duration:1, easing:Strong.easeOut};
			TransitionManager.start(thisMC, transitionProps);
		*/
		}
		private function mouseUpHandler(evt:MouseEvent):void 
		{
			this.stopDrag();
			this.x = int(this.origX);
			this.y = int(this.origY);
			this.scaleX = 0.2;
			this.scaleY = 0.2;
		}
	
		private function mouseMoveHandler(event:MouseEvent):void 
		{
			event.updateAfterEvent();
		}

	}
	
}