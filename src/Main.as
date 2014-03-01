package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class Main extends Sprite 
	{
		private var bulletLayer:BulletLayer;
		private var scoreText:TextField;
		private var startText:TextField;
		private var brandingText:TextField;
		private var player:Player;
		private var score:int = 0;
		private var running:Boolean = false;
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			bulletLayer = new BulletLayer();
			player = new Player();
			scoreText = new TextField();
			brandingText = new TextField();
			scoreText.defaultTextFormat = new TextFormat('Verdana', 24, 0xDEDEDE);
			scoreText.text = "Score: " + 0;
			scoreText.textColor = 0xFFFFFFFF;
			scoreText.width = 500;
			startText = new TextField();
			startText.defaultTextFormat = new TextFormat('Verdana', 24, 0xDEDEDE);
			startText.text = "I swear, the rain is out to get me.\nClick to start";
			startText.textColor = 0xFFFFFFFF;
			startText.width = 500;
			startText.x = 100;
			startText.y = 200;
			brandingText.defaultTextFormat = new TextFormat('Verdana', 12, 0xDEDEDE);
			brandingText.text = "By: Shalmezad\nFor GiTD #38";
			brandingText.x = 530;
			brandingText.y = 440;
			brandingText.textColor = 0xFFFFFFFF;
			addChild(bulletLayer);
			addChild(player);
			addChild(scoreText);
			addChild(startText);
			addChild(brandingText);

			addEventListener(Event.ENTER_FRAME, update);
			addEventListener(MouseEvent.CLICK, startGame);
			
		}
		
		private function startGame(me:MouseEvent):void
		{
			if (!running)
			{
				player.reset();
				bulletLayer.spawning = true;
				running = true;
				startText.visible = false;
				score = 0;
				bulletLayer.ammountToSpawn = 1;
				player.alpha = 1;
			}
		}
		private function update(e:Event):void
		{
			scoreText.text = "Score: " + score.toString();
			bulletLayer.update(e);
			player.update(e);
			player.setPos(mouseX, mouseY);
			
			if (running)
			{
				//only increment score if running
				score += 1;
				if (score % 500 == 0)
				{
					bulletLayer.ammountToSpawn+=.5;
				}
				//check kill condition
				var pixel:uint = bulletLayer.getPixel(mouseX, mouseY);
				//ARGB
				var alpha:uint = pixel >> 24 & 255;
				if (alpha > 100)
				{
					//kill
					stopGame();
				}
				trace(alpha);
			}
		}
		
		private function stopGame():void
		{
			player.kill();
			bulletLayer.spawning = false;
			running = false;
			startText.visible = true;
		}

	}
	
}