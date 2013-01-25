package StrangeDungeon
{
	import Enemies.Enemy;
	import flash.utils.getQualifiedClassName;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Anim;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Skill
	{
		private var _modifier:Modifier;
		private var _name:String;
		private var _value:int;
		private var _modSuccess:Number;
		private var _successRate:Number;
		private var _cooldown:Number;
		private var _cooldownRemaining:Number;
		private var _element:String;
		private var _image:Image;
		
		public var graphic:Image;
		public var self:Boolean;
		
		/**
		 * 
		 * @param	name
		 * @param	modifier
		 * @param	value
		 * @param	cooldown
		 * @param	image
		 * @param	modSuccess
		 * @param	successRate
		 * @param	element
		 */
		public function Skill(	name:String, modifier:Modifier, value:int, cooldown:Number, image:Image,
								targetSelf:Boolean = false, modSuccess:Number = 1.0, successRate:Number = 1.0,
								element:String = "none"
								)
		{
			_name = name;
			_modifier = modifier;
			_value = value;
			_modSuccess = modSuccess;
			_successRate = successRate;
			_cooldown = cooldown;
			_cooldownRemaining = 0;
			_element = element;
			_image = image;
			
			this.self = targetSelf;
			graphic = image;
		}
		
		public function useSkill(user:Character, target:Character = null):void 
		{
			var skillRoll:Number = FP.random;
			var modRoll:Number = FP.random;
			var damage:int = 0;
			
			
			if (user.attackTween.active)
				return;
			
			//null target means global skill
			if (target != null)
			{
				var missChance:Number = target.currentStats.eva/100;
				damage = -1;
				if (target.targetable) 
				{
					
					if (skillRoll >= missChance)
					{
						if (skillRoll < _successRate)
						{
							if (name == "basic_attack")
							{
								damage = 5 + user.currentStats.atk;
							}
							if (_modifier)
							{
								if (modRoll < _modSuccess)
								{
									target.addModifier(_modifier);
								}
							}
						}
					}
				}
				user.attack(target, damage, _element);
				
				
			}
			else if (self)
			{
				if (_modifier)
					{
						if (modRoll < _modSuccess)
						{
							user.addModifier(_modifier);
							user.waiting = user.currentStats.waiting;
						}
					}
			}
			
			//user.waiting = user.currentStats.waiting;
			
			_cooldownRemaining = _cooldown;
		}
		
		public function resetCooldown():void
		{
			_cooldownRemaining = 0;
		}
		
		public function updateCooldown(time:Number):void
		{
			_cooldownRemaining = Math.max(_cooldownRemaining - time, 0);
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function get cooldownRemaining():Number
		{
			return _cooldownRemaining;
		}
		
		public function get element():String 
		{
			return _element;
		}
		
		public function get cooldown():Number 
		{
			return _cooldown;
		}
		
		public function get successRate():Number 
		{
			return _successRate;
		}
		
		public function get modSuccess():Number 
		{
			return _modSuccess;
		}
		
		public function get value():int 
		{
			return _value;
		}
		
		public function get modifier():Modifier 
		{
			return _modifier;
		}
		
		public function get image():Image 
		{
			return _image;
		}
		
		public static function spawnSkill(skill:Skill):Skill 
		{
			var skillToReturn:Skill = new Skill(skill.name, skill.modifier, skill.value, skill.cooldown, skill.image,
												skill.self, skill.modSuccess, skill.successRate, skill.element);
			return skillToReturn;
			
		}
	}

}