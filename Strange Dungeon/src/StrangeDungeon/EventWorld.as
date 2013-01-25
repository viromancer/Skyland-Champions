package StrangeDungeon 
{
	import DungeonEvents.DungeonEvent;
	import Enemies.Enemy;
	import flash.events.Event;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	import StrangeDungeon.Gui.CombatGui;
	import StrangeDungeon.Gui.Gui;
	import StrangeDungeon.Gui.ResultsGui;
	
	/**
	 * ...
	 * @author ...
	 */
	public class EventWorld extends World 
	{
		private var _event:DungeonEvent;
		private var _gui:Gui;
		private var _resultsDisplayed:Boolean;
		
		private var _resultTicker:Number;
		
		public var numEnemies:int;
		
		public var experienceEarned:int, damageDealt:int, damageReceived:int;
		
		public function EventWorld(event:DungeonEvent) 
		{
			_event = event;
			_resultsDisplayed = false;
			experienceEarned = 0;
			damageDealt = 0;
			damageReceived = 0;
			_resultTicker = 0;
		}
		
		override public function begin():void 
		{
			super.begin();
			
			addGraphic(_event.background);
			
			Global.player.x = FP.screen.width / 2 - (16);
			Global.player.y = FP.screen.height - (150);
			
			_event.begin();
			//if (_event.eventType.type == "combat")
			//{
				//loadEnemies();
				//_gui = new CombatGui();
				//_gui.start();
			//}
			//else if (_event.eventType.type == "loot")
			//{
				//loadLoot();
			//}
			
			add(Global.player);
		}
		
		override public function update():void 
		{
			super.update();
			_event.update();
			
			if (Input.pressed(Key.BACKSPACE))
			{
				FP.world = Global.dungeonWorld;
				removeAll();
			}
		}
		
		private function loadLoot():void 
		{
			add(new Chest(Global.player.x, Global.player.y - 128));
		}
		
		public function get event():DungeonEvent 
		{
			return _event;
		}
	}

}