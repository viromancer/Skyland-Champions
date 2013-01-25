package StrangeDungeon.Screens 
{
	import net.flashpunk.World;
	import punk.ui.PunkUI;
	import punk.ui.PunkWindow;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GameSelect extends World 
	{
		private var saveSlots:Vector.<PunkWindow>;
		
		public function GameSelect(isNewGame:Boolean) 
		{
			saveSlots = new Vector.<PunkWindow>();
			
			for (var i:int = 0; i < 3; i++) 
			{
				var window:PunkWindow = new PunkWindow(20, (128 * i) + 10, 200, 128, "", false);
				saveSlots.push(window);
				add(saveSlots[i]);
			}
		}
		
	}

}