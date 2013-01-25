package StrangeDungeon.Gui 
{
	import flash.display.BitmapData;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	import StrangeDungeon.Global;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BarElement extends GuiElement 
	{
		private var maxLength:int, maxHeight:int, _color:uint, _stat:String;
		
		
		public function BarElement(x:int, y:int, stat:String, maxLength:int = 0, maxHeight:int = 0, graphic:Graphic = null, color:uint=0xFFFFFFFF) 
		{
			this.maxLength = maxLength
			this.maxHeight = maxHeight;
			_color = color;
			var barBitmap:BitmapData;
			_stat = stat;
			
			switch (_stat) 
			{
				case "hp":
					if (Global.player.currentStats.hp  <= 0)
					{
						barBitmap = new BitmapData(1, maxHeight, true, color);
					}
					else
					{
						barBitmap = new BitmapData((Global.player.currentStats.hp / Global.player.baseStats.hp) * maxLength, maxHeight, true, color);
					}
				break;
				case "mana":
					if (Global.player.currentStats.mana  <= 0)
					{
						barBitmap = new BitmapData(1, maxHeight, true, color);
					}
					else
					{
						barBitmap = new BitmapData((Global.player.currentStats.mana / Global.player.baseStats.mana) * maxLength, maxHeight, true, color);
					}
				break;
				case "exp":
					if (Global.player.experience  <= 0)
					{
						barBitmap = new BitmapData(1, maxHeight, true, color);
					}
					else
					{
						barBitmap = new BitmapData((Global.player.experience / Global.player.experienceAmounts[Global.player.level]) * maxLength, maxHeight, true, color);
					}
				break;
				case "waiting":
					if (Global.player.waiting <= 0)
					{
						barBitmap = new BitmapData(1, maxHeight, true, color);
					}
					else
					{
						barBitmap = new BitmapData((Global.player.waiting / Global.player.baseStats.waiting) * maxLength, maxHeight, true, color);
					}
					
				break;
				default:
			}
			
			graphic = new Image(barBitmap);
			
			super(x, y, graphic, mask);
			
		}
		
		override public function update():void 
		{
			super.update();
			
			var newBitmap:BitmapData;
			
			switch (_stat) 
			{
				case "hp":
					if (Global.player.currentStats.hp  <= 0)
					{
						newBitmap = new BitmapData(1, maxHeight, true, _color);
					}
					else
					{
						newBitmap = new BitmapData((Global.player.currentStats.hp / Global.player.baseStats.hp) * maxLength, maxHeight, true, _color);
					}
				break;
				case "mana":
					if (Global.player.currentStats.mana  <= 0)
					{
						newBitmap = new BitmapData(1, maxHeight, true, _color);
					}
					else
					{
						newBitmap = new BitmapData((Global.player.currentStats.mana / Global.player.baseStats.mana) * maxLength, maxHeight, true, _color);
					}
				break;
				case "exp":
					if (Global.player.experience  <= 0)
					{
						newBitmap = new BitmapData(1, maxHeight, true, _color);
					}
					else
					{
						newBitmap = new BitmapData((Global.player.experience / Global.player.experienceAmounts[Global.player.level]) * maxLength, maxHeight, true, _color);
					}
				break;
				case "waiting":
					if (Global.player.waiting <= 0.1)
					{
						newBitmap = new BitmapData(1, maxHeight, true, _color);
					}
					else
					{
						newBitmap = new BitmapData((Global.player.waiting / Global.player.baseStats.waiting) * maxLength, maxHeight, true, _color);
					}
					
				break;
				default:
			}
			
			graphic = new Image(newBitmap);
		}
		
	}

}