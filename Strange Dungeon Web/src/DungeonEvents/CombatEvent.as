package DungeonEvents 
{
	import Enemies.Enemy;
	import Enemies.EnemyType;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import StrangeDungeon.Global;
	import StrangeDungeon.Gui.CombatGui;
	import StrangeDungeon.Gui.Gui;
	import StrangeDungeon.Gui.ResultsGui;
	/**
	 * ...
	 * @author ...
	 */
	public class CombatEvent extends DungeonEvent
	{
		public var enemyList:Vector.<Enemy>;
		private var _enemyTypeList:Vector.<EnemyType>;
		
		private var _resultTicker:Number, _resultsDisplayed:Boolean;
		private var _enemySpots:Array = [ { x:FP.screen.width / 2 - (16), y:FP.screen.height / 2 }, { x:FP.screen.width / 2 - (48), y:FP.screen.height / 2 },  { x:FP.screen.width / 2 - (80), y:FP.screen.height / 2 } ];
		public var experienceEarned:int;
		/**
		 * 
		 * @param	gui the gui to use for this event
		 */
		public function CombatEvent(gui:Gui, enemyTypeList:Vector.<EnemyType>, name:String, background:Image) 
		{
			background.scale = .5;
			
			_enemyTypeList = enemyTypeList;
			_resultTicker = 0;
			
			this.enemyList = new Vector.<Enemy>;
			
			for each (var enemyType:EnemyType in enemyTypeList) 
			{
				this.enemyList.push(enemyType.spawnEnemy());
			}
			super(gui, name, background, "combat");
		}
		
		override public function update():void 
		{
			super.update();
			
			if (enemyList.length == 0)
			{
				_resultTicker += FP.elapsed;
				
				if (!_resultsDisplayed)
				{
					_resultsDisplayed = true;
					_gui.clear();
					_gui = new ResultsGui(true);
					_gui.start();
				}
				
				if (_resultTicker >= .05 && experienceEarned > 0)
				{
					Global.player.experience++;
					Global.player.totalExperience++;
					experienceEarned--;
					_resultTicker = 0;
					trace(Global.player.experience);
				}
				
				if (Input.mouseReleased && _resultTicker > .5)
				{
					FP.world.removeAll();
					FP.world = Global.dungeonWorld;
					
				}
				
			}
			else 
			{
				if (CombatGui(gui).showArrows)
				{
					CombatGui(gui).showTargetArrows(enemyList);
				}
			}
		}
		
		override public function begin():void 
		{
			super.begin();
			loadEnemies();
		}
		
		public function loadEnemies():void 
		{
			for (var i:int = 0; i < enemyList.length; i++) 
			{
				enemyList[i].x = _enemySpots[i].x;
				enemyList[i].y = _enemySpots[i].y;
				FP.world.add(enemyList[i]);
			}
		}
		
		public function spawnEvent():CombatEvent
		{
			return new CombatEvent(gui, _enemyTypeList, name, background);
		}
	}

}