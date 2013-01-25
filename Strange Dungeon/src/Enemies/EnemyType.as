package Enemies
{
	import flash.display.Graphics;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import StrangeDungeon.Skill;
	/**
	 * ...
	 * @author ...
	 */
	public class EnemyType 
	{
		public var name:String, hp:int, def:int, atk:int, graphic:Graphic, rarity:int, experienceValue:int, waiting:Number;
		
		internal var skills:Vector.<Skill>;
		
		/**
		 * 
		 * @param	name
		 * @param	hp
		 * @param	def
		 * @param	atk
		 * @param	waiting the amount of time to wait between attacks
		 * @param	graphic
		 * @param	rarity rarity of the monster, 0 - common, 1 - uncommon, 2 - rare, 3 - epic
		 */
		public function EnemyType(name:String, hp:int, def:int, atk:int, waiting:Number, experienceValue:int, graphic:Graphic, rarity:int, skills:Vector.<Skill>=null) 
		{
			this.name = name;
			this.hp = hp;
			this.def = def;
			this.atk = atk;
			this.graphic = graphic;
			this.rarity = rarity;
			this.skills = skills;
			this.waiting = waiting;
			this.experienceValue = experienceValue;
		}
		
		public function spawnEnemy():Enemy 
		{
			return Enemy.getNewInstance(this);
		}
		
	}

}