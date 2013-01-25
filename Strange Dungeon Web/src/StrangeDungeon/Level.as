package StrangeDungeon 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	/**
	 * ...
	 * @author ...
	 */
	public class Level extends Entity
	{
		[Embed(source = "../../assets/Level/tomb1.png")]
		public const tomb1_png:Class;
		
		public var levelArray:Array;
		public var tileMap:Tilemap;
		public var grid:Grid;
		public var startTile:int;
		public var endTile:int;
		
		public function Level() 
		{
			levelArray = new Array();
		}
		
		public static function createLevel(height:int, width:int, type:String):Level
		{
			switch (type) 
			{
				case "tomb":
					return tombLevel(height, width);
				break;
				
				default:
					return null;
			}
			
			
		}
		
		private static function tombLevel(height:int, width:int):Level
		{
			trace("new map");
			var level:Level = new Level();
			level.tileMap = new Tilemap(level.tomb1_png, width * 32, height * 32, 32, 32);
			level.grid = new Grid(width * 32, height * 32, 32, 32, 0, 0);
			
			level.tileMap.setRect(0, 0, width, height, 0);
			level.grid.setRect(0, 0, width, height, true);
			
			var length:int = 0;
			var posX:int = 0;
			var posY:int = level.tileMap.height/64;
			var dir:int = 0;
			var dugDistance:int = 0;
			
			do 
			{
				//trace("tile at: " + posX + ", " + posY);
				level.tileMap.setTile(posX, posY, 1);
				level.grid.setTile(posX, posY, false);
				length++;
				dugDistance++;
				
				if (dugDistance > 3) 
				{
					//trace("running longer than 3");
					var r:int = FP.rand(3);
					
					switch (r) 
					{
						case 0:
							dir += 0;//stay on course
						break;
						case 1:
							dir += 90;//turn 90 degrees positive
							dugDistance = 0;
						break;
						case 2:
							dir -= 90;//turn 90 degrees negative
							dugDistance = 0;
						break;
						default:
							trace("error");
					}
					
					if (dir >= 180)
						dir = 90;
					if (dir <= -180)
						dir = -90;
				}
				
				if (posY + Math.sin(FP.RAD * dir) < 0) 
				{
					trace("move right");
					posY = 0;
					dir = 0; //right
					if (dugDistance > 3)
						dugDistance = 0;
				}
				if (posY + Math.sin(FP.RAD * dir) > (level.tileMap.height / 32) - 1) 
				{
					trace("move left");
					posY = (level.tileMap.height / level.tileMap.tileHeight) - 1
					dir = 0; //right
					if (dugDistance > 3)
						dugDistance = 0;
				}
				
				posY += Math.sin(FP.RAD * dir);
				posX += Math.cos(FP.RAD * dir);
				
			} while(posX != width)
			
			level.setHitbox(32*width, 32*height, 0, 0);
			//level.mask = level.grid;
			level.graphic = level.tileMap;
			level.x = 0;
			level.y = 0;
			
			return level;
		}
		
		private function baseLevel(height:int):Level
		{
			return null;
		}
		
		
	}

}