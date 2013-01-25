package StrangeDungeon.Gui 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import StrangeDungeon.Assets;
	import StrangeDungeon.Global;
	/**
	 * ...
	 * @author ...
	 */
	public class ResultsGui extends Gui 
	{
		public var complete:Boolean;
		
		public function ResultsGui(victory:Boolean) 
		{
			super();
			complete = false;
			
			if (victory)
			{
				var exp_bar_back:GuiElement = new GuiElement(FP.screen.width/2-Assets.exp_bar_back_image.width/2, 150, Assets.exp_bar_back_image);
				addElement(exp_bar_back);
				
				var text:Text = new Text("VICTORY!", 0, 0, { "size":42 } );
				addElement(new GuiElement(FP.screen.width / 2 - text.textWidth / 2, 50, text));
				addElement(new BarElement(exp_bar_back.x + 8, exp_bar_back.y + 17, "exp", 155, 13));
			}
			
		}
		
		private function completed():void 
		{
			complete = true;
		}
	}

}