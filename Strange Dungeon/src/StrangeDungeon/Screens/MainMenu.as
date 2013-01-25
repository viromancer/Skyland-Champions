package StrangeDungeon.Screens 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	import punk.ui.PunkButton;
	import punk.ui.PunkUI;
	import punk.ui.skins.BrownGrey;
	import punk.ui.skins.RolpegeBlue;
	
	/**
	 * ...
	 * @author ...
	 */
	public class MainMenu extends World 
	{
		private var _newGame:PunkButton, _loadGame:PunkButton;
		PunkUI.skin = new BrownGrey;
		
		public function MainMenu() 
		{
			_newGame = new PunkButton(100, 100, 60, 32, "New Game", startNewGame);
			_loadGame = new PunkButton(100, 148, 60, 32, "Load Game", startLoadGame);
		}
		
		override public function begin():void 
		{
			super.begin();
			
			add(_newGame);
			add(_loadGame);
		}
		
		private function startNewGame():void 
		{
			FP.world = new GameSelect(true);
		}
		
		private function startLoadGame():void
		{
			FP.world = new GameSelect(false);
		}
	}

}