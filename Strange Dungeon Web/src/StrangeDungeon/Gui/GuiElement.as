package StrangeDungeon.Gui 
{
	import flash.display.Graphics;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	/**
	 * ...
	 * @author ...
	 */
	public class GuiElement extends Entity
	{
		public var gui:Gui;
		
		public function GuiElement(x:int, y:int, graphic:Graphic, mask:Mask=null)
		{
			super(x,y,graphic, mask);
		}
		
	}

}