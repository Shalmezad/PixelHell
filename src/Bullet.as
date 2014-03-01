package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	public class Bullet 
	{
		private var point:Point;
		private var velocity:Point;
		[Embed(source = '../res/bullet4.png')] public static const G_BULLET:Class;
		static var bulletSheet:BitmapData = (new G_BULLET() as Bitmap).bitmapData;
		static var bulletRect:Rectangle = bulletSheet.rect;
		
		public var alive:Boolean;
		
		public function Bullet() 
		{
			point = new Point();
			velocity = new Point();
			reset();
		}
		
		public function reset():void
		{
			point.x = Math.random() * 640;
			point.y = -20;
			//velocity.x = Math.random() * 3;
			velocity.y = Math.random() * 3+2;
			alive = true;
		}
		
		public function update():void
		{
			//velocity.x += .01;
			//velocity.y += .01;
			point.x += velocity.x;
			point.y += velocity.y;
			/*
			if (point.x < 0 || point.x > 640 || point.y < 0 || point.y > 480)
			{
				//reset();
				kill();
			}
			*/
			if (point.y > 480)
			{
				kill();
			}
		}
		
		public function render(canvas:BitmapData)
		{
			canvas.copyPixels(bulletSheet, bulletRect, point, null, null, true);
		}
		
		private function kill()
		{
			alive = false;
		}
		
	}

}