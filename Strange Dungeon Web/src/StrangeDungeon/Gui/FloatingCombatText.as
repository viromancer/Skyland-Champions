package StrangeDungeon.Gui 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	/**
	 * ...
	 * @author ...
	 */
	public class FloatingCombatText extends GuiElement 
	{
		private var _text:Text, startY:int, fadeTime:Number, _direction:int;
		
		public function FloatingCombatText(x:int, y:int, text:String, direction:int=1, color:uint=0xffffff)
		{
			fadeTime = 1;
			startY = y;
			_direction = direction;
			_text = new Text(text, 0, 0, { "color":color } );
			graphic = _text;
			
			super(x, y, graphic, mask);
		}
		
		override public function update():void 
		{
			super.update();
			fadeTime -= FP.elapsed;
			
			_text.alpha = fadeTime;
			y-- //= -_direction * (y + FP.elapsed * 2);
			
			//if (y <= startY - 20)
				//world.remove(this);
		}
		
	}

}