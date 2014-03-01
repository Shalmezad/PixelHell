package  
{
	import flash.events.Event;
	import flash.geom.Point;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.BlurFilter;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Shalmezad
	 */
	public class Player extends Bitmap
	{
		private var canvas:BitmapData;
		private var _colorMatrixFilter:ColorMatrixFilter;
		private var blurFilter:BlurFilter;
		private var originPoint:Point = new Point();
		public var currentPoint:Point = new Point();
		private var flameVelocity:Point = new Point(0, -4);
		[Embed(source = '../res/bullet5.png')] public static const G_PLAYER:Class;
		static var playerSheet:BitmapData = (new G_PLAYER() as Bitmap).bitmapData;
		static var playerRect:Rectangle = playerSheet.rect;
		private var alive:Boolean = false;
		
		public function Player() 
		{
			canvas =  new BitmapData(640, 480, true, 0x000000);
			super(canvas);
			_colorMatrixFilter = new ColorMatrixFilter([ 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0.5, 0 ]);
			blurFilter = new BlurFilter(3, 3, 1);
		}
		
		public function update(e:Event)
		{
			canvas.lock();
			canvas.copyPixels(canvas, canvas.rect, flameVelocity, null, null, true);
			canvas.applyFilter(canvas, canvas.rect, originPoint, blurFilter);
			canvas.applyFilter(canvas, canvas.rect, originPoint, _colorMatrixFilter);
			if (alive)
			{
				canvas.copyPixels(playerSheet, playerRect, currentPoint, null, null, true);
			}
			canvas.unlock();
		}
		
		public function setPos(x:int, y:int)
		{
			currentPoint.x = x - playerRect.width / 2;
			currentPoint.y = y - playerRect.height / 2;
		}
		
		public function kill()
		{
			alive = false;
		}
		public function reset()
		{
			alive = true;
		}
		
	}

}