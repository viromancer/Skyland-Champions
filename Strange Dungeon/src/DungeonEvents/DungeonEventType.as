package DungeonEvents 
{
	import Enemies.Enemy;
	import Enemies.EnemyType;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author ...
	 */
	public class DungeonEventType 
	{
		private var _eventName:String;
		private var _lootList:Vector.<Object>;
		private var _quest:Object;
		private var _description:String;
		private var _background:Image;
		private var _commonEnemyList:Vector.<EnemyType>;
		private var _uncommonEnemyList:Vector.<EnemyType>;
		private var _rareEnemyList:Vector.<EnemyType>;
		private var _epicEnemyList:Vector.<EnemyType>;
		private var _type:String;
		
		/**
		 * 
		 * @param	eventName	the event name
		 * @param	type		type of event ("combat", "shop", "treasure", "empty")
		 * @param	background
		 * @param	allEnemyList
		 * @param	lootList
		 * @param	quest
		 * @param	description
		 */
		public function DungeonEventType(eventName:String, type:String, background:Image = null, allEnemyList:Vector.<EnemyType> = null, lootList:Vector.<Object> = null,
										 quest:Object = null, description:String = null)
		{
			_eventName = eventName;
			_commonEnemyList = new Vector.<EnemyType>;
			_uncommonEnemyList = new Vector.<EnemyType>;
			_rareEnemyList = new Vector.<EnemyType>;
			_epicEnemyList = new Vector.<EnemyType>;
			_type = type;
			_background = background;
			_background.scale = 1 / 2;
			
			if (type == "combat")
			{
				for each (var enemyType:EnemyType in allEnemyList) 
				{
					var enemyRarity:int = enemyType.rarity;
					switch (enemyRarity)
					{
						case 0:
							_commonEnemyList.push(enemyType);
						break;
						case 1:
							_uncommonEnemyList.push(enemyType);
						break;
						case 2:
							_rareEnemyList.push(enemyType);
						break;
						case 3:
							_epicEnemyList.push(enemyType);
						break;
						default:
							_commonEnemyList.push(enemyType);
					}
				}
			}
			
			_lootList = lootList;
			_quest = quest;
			_description = description;
		}
		
		public function get eventName():String 
		{
			return _eventName;
		}
		
		public function get commonEnemyList():Vector.<EnemyType>
		{
			return _commonEnemyList;
		}
		
		public function get uncommonEnemyList():Vector.<EnemyType>
		{
			return _uncommonEnemyList;
		}
		
		public function get rareEnemyList():Vector.<EnemyType> 
		{
			return _rareEnemyList;
		}
		
		public function get epicEnemyList():Vector.<EnemyType>
		{
			return _epicEnemyList;
		}
		
		public function get background():Image 
		{
			return _background;
		}
		
		public function get type():String 
		{
			return _type;
		}
	}

}