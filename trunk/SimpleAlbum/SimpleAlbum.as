package {
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.display.Graphics;
	import flash.events.MouseEvent;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.Event;


	public class SimpleAlbum extends Sprite
	{
		public function SimpleAlbum()
		{
			var a:Sprite = createPhoto();
			a.x = 100;
			a.y = 100;
			addChild(a);
			a.addEventListener(MouseEvent.CLICK,onClick);
			a.addEventListener(MouseEvent.MOUSE_UP,onRelease);
			var ldr : Loader = new Loader();
			ldr.loaderInfo.addEventListener(Event.COMPLETE,onLoadComplete);
			var image:URLRequest = new URLRequest("../images/w01.jpg");
			ldr.load(image);
			a.addChild(ldr);
		}
		private function createPhoto():Sprite
		{
			var photo:Sprite = new Sprite();
			var bg:Graphics = photo.graphics;
			createPhotobg(bg);
			return photo ;	
		}
		
		private function onLoadComplete(evt:Event):void
		{
			var loader:Loader = evt.target.loader;
         
			loader.height = loader.width = 80;
		}		

		private function createPhotobg(bg:Graphics):void
		{
			bg.beginFill(0xffffff);
			bg.lineStyle(1,0x999999);
			bg.drawRect(0,0,100,150);
			bg.endFill();
		}
		private function onClick(evt:MouseEvent):void
		{
			evt.target.addEventListener(MouseEvent.MOUSE_MOVE,onDrag);
			
		}
		private function onRelease(evt:MouseEvent):void
		{
			evt.target.removeEventListener(MouseEvent.MOUSE_MOVE,onDrag);
		}
		private function onDrag(evt:MouseEvent):void
		{
			evt.target.x = stage.mouseX;
			evt.target.y = stage.mouseY;
		}
	}
}
