package StrangeDungeon.Gui 
{
	import net.flashpunk.FP;
	import StrangeDungeon.Global;
	/**
	 * ...
	 * @author ...
	 */
	public class Gui 
	{
		protected var guiElements:Vector.<GuiElement>;
		
		public function Gui() 
		{
			guiElements = new Vector.<GuiElement>;
		}
		
		public function addElement(elementToAdd:GuiElement):GuiElement
		{
			elementToAdd.gui = this;
			guiElements.push(elementToAdd);
			return(elementToAdd);
		}
		
		public function start():void 
		{
			for each (var element:GuiElement in guiElements) 
			{
				FP.world.add(element);
			}
		}
		
		public function clear():void
		{
			for each (var element:GuiElement in guiElements) 
			{
				FP.world.remove(element);
			}
		}
		
		public function removeElement(element:GuiElement):void 
		{
			FP.world.remove(element);
		}
	}

}