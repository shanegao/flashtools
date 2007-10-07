package {
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.display.Graphics;
	import flash.events.MouseEvent;
	import flash.display.Loader;
	import flash.net.URLLoader ;
	import flash.net.URLRequest;
	import flash.events.Event;
	import cn.flashcoder.gallery.Photo;


	public class SimpleAlbum extends Sprite
	{
		private var thisX : Number = 30;
		private var thisY : Number = 70;
		public function SimpleAlbum()
		{
			var xmlLdr:URLLoader = new URLLoader();
			xmlLdr.addEventListener(Event.COMPLETE, completeHandler);
			xmlLdr.load(new URLRequest("images/gallery_tween.xml"));
		}
		
		private function completeHandler(event:Event):void 
		{
			try 
			{
				var gallery_xml:XML = new XML(event.target.data);
				var images:XMLList = gallery_xml.img;
				var gallery_array:Array = new Array();
				var i:int;
				var galleryLength:int = images.length();
				for (i = 0; i < galleryLength; i++) 
				{
					trace(i,images[i].text());
					gallery_array.push({src:images[i].text()});
				}
				displayGallery(gallery_array);
			} 
			catch (error:Error) 
			{
				trace(error.message);
			}
		}
		private function displayGallery(listAll:Array):void
		{
			var i:int;
			var galleryLength:Number = listAll.length;
			// loop through each of the images in the gallery_array.
			for (i = 0; i<galleryLength; i++) 
			{
				var src:String = "images/" + listAll[i].src ;
				var photo:Photo = new Photo(src,"photo"+i);
				photo.x = thisX;
				photo.y = thisY;
				addChild(photo);
		
				// if you've displayed 5 columns of images, start a new row.
				if (((i + 1) % 5) == 0) 
				{
					// reset the X and Y positions
					thisX = 20;
					thisY += 80;
				} 
				else 
				{
					thisX += 80 + 20;
				}
			}
		}
	}
}
