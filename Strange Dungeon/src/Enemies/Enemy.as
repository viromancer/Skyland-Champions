package Enemies
{
	import DungeonEvents.CombatEvent;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Tween;
	import net.flashpunk.utils.Input;
	import StrangeDungeon.Character;
	import StrangeDungeon.EventWorld;
	import StrangeDungeon.Global;
	import StrangeDungeon.Gui.CombatGui;
	import StrangeDungeon.Modifier;
	import StrangeDungeon.Skill;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Enemy extends Character
	{
		private static var allowInstantiation:Boolean = false;
		
		private var _startX:Number, _startY:Number;
		private var enemyType:EnemyType;
		private var timer:Number;
		
		internal static function getNewInstance(enemyType:EnemyType):Enemy
		{
			allowInstantiation = true;
			var enemy:Enemy = new Enemy(enemyType, enemyType.graphic);
			allowInstantiation = false;
			
			return enemy;
		}
		
		public function Enemy(enemyType:EnemyType, graphic:Graphic) 
		{
			super(x, y, graphic, mask);
			if (!allowInstantiation)
			{
				throw new Error("Use getNewInstance to create new enemy objects", 1);
			}
			type = "enemy";
			this.enemyType = enemyType;	
			this.timer = 0;
			this.setHitbox(32, 32, 0, 0);
			this.name = enemyType.name;
			
			baseStats.hp = enemyType.hp;
			baseStats.atk = enemyType.atk;
			baseStats.def = enemyType.def;
			baseStats.waiting = enemyType.waiting;
			currentStats.hp = baseStats.hp;
			
			//set current stats = base stats
			resetStats();
		}
		
		override public function added():void 
		{
			super.added();
			
			_startX = x;
			_startY = y;
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Global.player.waiting > 0)
			{
				paused = false;
				
				if (currentStats.hp <= 0)
				{
					EventWorld(world).numEnemies--;
					CombatEvent(EventWorld(world).event).enemyList.splice(CombatEvent(EventWorld(world).event).enemyList.indexOf(this), 1);
					CombatEvent(EventWorld(world).event).experienceEarned += this.enemyType.experienceValue;
					world.remove(this);
				}
				
				for each (var skill:Skill in enemyType.skills) 
				{
					skill.updateCooldown(FP.elapsed);
				}
				
				//we'll check each skill in the enemy's skill list here, if one is ready to cast, we'll cast it
				//attacking is just a skill that costs no mana and recharges rather fast.
				if (waiting <= 0) 
				{
					if(!Global.player.attackTween.active)
						action();
				}
			}
			else
			{
				paused = true;
			}
			//if (CombatGui(EventWorld(world).event.gui).pickTarget)
			//{
				if (collidePoint(x, y, Input.mouseX, Input.mouseY))
				{
					if (Input.mouseReleased)
					{
						Global.player.target = this;
						CombatGui(EventWorld(world).event.gui).pickTarget = false;
						CombatGui(EventWorld(world).event.gui).removeArrows();
						CombatGui(EventWorld(world).event.gui).showArrowAtEnemy(Enemy(Global.player.target));
					}
				}
			//}
			
			
		}
		
		private function action():void 
		{
			var skillToUse:Skill;
			skillToUse = Skill(this.enemyType.skills[FP.rand(skills.length)]);
			skillToUse.useSkill(this, Global.player);
			// use the below code to see which skill is being used
			//var skillEntity:Entity = new Entity(x, this.y - this.height - 34, skillToUse._graphic);
		}
		
		public function get rarity():int
		{
			return enemyType.rarity;
		}
		
		override public function get name():String
		{
			return enemyType.name;
		}
		
		public function get startX():Number 
		{
			return _startX;
		}
		
		public function get startY():Number 
		{
			return _startY;
		}
	}

}