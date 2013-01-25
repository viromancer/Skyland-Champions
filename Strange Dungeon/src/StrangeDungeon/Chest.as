package StrangeDungeon 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Input;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Chest extends Entity 
	{
		private var _spriteMap:Spritemap;
		
		public function Chest(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			
			_spriteMap = new Spritemap(Assets.chest_jpg, 64, 64, showLoot);
			_spriteMap.add("open", [0, 1, 2], 12, false);
			this.graphic = _spriteMap;
			setHitboxTo(_spriteMap);
			
			super(x, y, this.graphic, mask);
			
		}
		
		override public function update():void 
		{
			super.update();
			
			if (collidePoint(x, y, Input.mouseX, Input.mouseY))
			{
				if (Input.mousePressed) 
				{
					_spriteMap.play("open");
				}
			}
		}
		
		private function showLoot():void
		{
			EventWorld(world).event.looted = true;
			trace("found loot");
		}
		
	}

}