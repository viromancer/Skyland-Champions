package StrangeDungeon.Inventory 
{
	/**
	 * ...
	 * @author ...
	 */
	public class Equipment extends Item 
	{
		private var _name;
		
		private var _bonusStats:Object;
		
		public function Equipment() 
		{
			
		}
		
		public function hp():int
		{
			return _bonusStats.hp;
		}
		
		public function mana():int
		{
			return _bonusStats.mana;
		}
		
		public function str():int
		{
			return _bonusStats.str;
		}
		
		public function wis():int
		{
			return _bonusStats.wis;
		}
		
		public function cons():int
		{
			return _bonusStats.cons;
		}
		
		public function agi():int
		{
			return _bonusStats.agi;
		}
		
		public function dex():int
		{
			return _bonusStats.dex;
		}
	}

}