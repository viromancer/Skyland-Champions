package StrangeDungeon.Gui 
{
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Mask;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GuiButton extends GuiElement 
	{
		private var _buttonText:Text;
		
		public function GuiButton(x:int, y:int, text:String, onRelease:Function) 
		{
			_buttonText = new Text(text, 0, 0);
			setHitbox(_buttonText.width, _buttonText.height);
			
			super(x, y, graphic);
			
		}
		
		override public function update():void 
		{
			super.update();
			
			
		}
		
	}

}