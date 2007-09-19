package {
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.display.Graphics;
	import flash.events.MouseEvent;


	public class SimpleAlbum extends Sprite
	{
		public function SimpleAlbum()
		{
			var a:Sprite = createPhoto();
			a.addEventListener(MouseEvent.CLICK,onClick);
			a.addEventListener(MouseEvent.MOUSE_UP,onRelease);
			addChild(a);
		}
		private function createPhoto():Sprite
		{
			var photo:Sprite = new Sprite();
			var bg:Graphics = photo.graphics;
			createPhotobg(bg);
			return photo ;	
		}
		private function createPhotobg(bg:Graphics):void
		{
			bg.beginFill(0xffffff);
			bg.lineStyle(1,0x999999);
			bg.drawRect(0,0,100,200);
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
