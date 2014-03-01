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
	
	public class BulletLayer extends Bitmap
	{
		private var canvas:BitmapData;
		private var bullets:Array;
		private var deadBullets:Array;
		private var _colorMatrixFilter:ColorMatrixFilter;
		private var blurFilter:BlurFilter;
		private var originPoint:Point = new Point();
		public var spawning:Boolean = false;
		public var ammountToSpawn:Number = 3;
		private var spawnCounter:Number = 0;
		
		private const USING_BLUR:Boolean = true;
		
		public function BulletLayer() 
		{
			canvas =  new BitmapData(640, 480, true, 0x000000);
			super(canvas);
			if (USING_BLUR)
			{
				_colorMatrixFilter = new ColorMatrixFilter([ 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0.75, 0 ]);
				blurFilter = new BlurFilter(3, 3, 1);
			}
			deadBullets = new Array();
			bullets = new Array();
			/*
			for (var i:int = 0; i < 200; i++)
			{
				bullets.push(new Bullet());
			}
			*/
		}
		
		public function makeBullet():void
		{
			var bullet:Bullet = deadBullets.pop();
			if (bullet == null)
			{
				bullet = new Bullet();
			}
			bullet.reset();
			bullets.push(bullet);
		}
		
		public function update(e:Event):void
		{
			if (spawning)
			{
				spawnCounter += ammountToSpawn;
				var total:int = spawnCounter;
				for (var j:int = 0; j < total; j++)
				{
					makeBullet();
				}
				spawnCounter -= total;
			}
			canvas.lock();
			
			if (USING_BLUR)
			{
				canvas.applyFilter(canvas, canvas.rect, originPoint, blurFilter);
				canvas.applyFilter(canvas, canvas.rect, originPoint, _colorMatrixFilter);
			}
			else
			{
				canvas.fillRect(canvas.rect, 0xFF000000);
			}
			
			for (var i:int = bullets.length-1; i >= 0; i--)
			{
				(bullets[i] as Bullet).update();
				if ((bullets[i] as Bullet).alive == false)
				{
					deadBullets.push(bullets[i]);
					bullets.splice(i,1); 
				}
				else
				{
					(bullets[i] as Bullet).render(canvas);
				}
			}
			
			canvas.unlock();
		}
		
		public function getPixel(x:int, y:int):uint
		{
			return canvas.getPixel32(x, y);
		}
		
	}

}