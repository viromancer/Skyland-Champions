package StrangeDungeon 
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.tweens.motion.LinearMotion;
	import net.flashpunk.tweens.motion.LinearPath;
	import StrangeDungeon.Gui.FloatingCombatText;
	import StrangeDungeon.Gui.Gui;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Character extends Entity 
	{
		protected var paused:Boolean = false;
		
		public var skills:Vector.<Skill>;
		
		private var _target:Character;
		private var _damage:int;
		private var _element:String;
		
		protected var modifiers:Object;
		
		private var _startX:int, _startY:int;
		
		public var currentStats:Object = { atk:0, def:0, eva:0, hp:0, mana:0, maxHP:0, str:0, cons:0, agi:0, wis:0, dex:0, maxMana:10, waiting:4.0 };
		public var baseStats:Object = { atk:0, def:0, eva:0, hp:10, mana:10, maxHP:10, str:0, cons:0, agi:0, wis:0, dex:0, maxMana:10, waiting:4.0 };
		
		public var targetable:Boolean = true;
		public var waiting:Number;
		
		protected var _attackTween:LinearPath;
		private var modTicker:Number;
		
		private var _waitBarData:BitmapData;
		private var _waitBar:Image;
		
		private var _modsChecked:Boolean = false;
		
		public function Character(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			this.graphic = new Graphiclist(graphic);
			
			super(x, y, this.graphic, mask);
			
			skills = new Vector.<Skill>;
			modifiers = new Object();
			modTicker = 0;
			
			_attackTween = new LinearPath(unwait, Tween.ONESHOT);
			addTween(_attackTween);
			
			baseStats.waiting = 4 - (3*(baseStats.agi/100));
			waiting = baseStats.waiting;
			
			_waitBarData = new BitmapData((waiting / baseStats.waiting) * 16, 3, true, 0xFFFFFFFF);
			_waitBar = new Image(_waitBarData);
			_waitBar.x = this.halfWidth - _waitBar.width/2;
			_waitBar.y = -6;
			
			addGraphic(_waitBar);
		}
		
		public function addModifier(modifier:Modifier):void 
		{
			if (modifiers[modifier.name] != null && Modifier(modifiers[modifier.name]).name == modifier.name)
			{
				trace("modifier already found");
				if (Modifier(modifiers[modifier.name]).stacks < Modifier(modifiers[modifier.name]).maxStacks)
				{
					Modifier(modifiers[modifier.name]).stacks++;
					Modifier(modifiers[modifier.name]).ticks = modifier.ticks;
					if(modifiers[modifier.name].spriteMap != null)
						modifiers[modifier.name].spriteMap.rate = modifiers[modifier.name].stacks;
					trace("total stacks: " + Modifier(modifiers[modifier.name]).stacks);
					
				}
				else
				{
					Modifier(modifiers[modifier.name]).stacks = Modifier(modifiers[modifier.name]).maxStacks;
					Modifier(modifiers[modifier.name]).ticks = modifier.ticks;
				}
			}
			else
			{
				trace("modifier not found, adding")
				
				modifiers[modifier.name] = modifier.spawnModifier();
				trace("modifier ticks remaining: " + Modifier(modifiers[modifier.name]).ticks);
				
				if (modifiers[modifier.name].spriteMap != null && Graphiclist(graphic).children.indexOf(modifiers[modifier.name].spriteMap) == -1)
				{
					this.addGraphic(modifiers[modifier.name].spriteMap);
					modifiers[modifier.name].spriteMap.play("default");
				}
			}
			
			trace("current rate: " + modifiers[modifier.name].spriteMap.rate);
			
		}
		
		private function runModifiers():void
		{
			
			for each (var modifier:Modifier in modifiers) 
			{
				trace(modifier.name + " ticks remaining: " + modifier.ticks);
				if (modifier.ticks > 0)
				{
					checkModifiers(modifier);
					//remove one tick
					modifier.ticks--;
				}
				else
				{
					if(modifier.spriteMap != null)
						Graphiclist(graphic).remove(modifier.spriteMap);
					
					if (modifier.name == "stealth")
					{
						targetable = true;
					}
					
					delete modifiers[modifier.name];
					
				}
			}
		}
		
		private function checkModifiers(modifier:Modifier):void 
		{
				
			var modifiedStats:Object = { atk:baseStats.atk, def:baseStats.def, eva:baseStats.eva, maxHP:baseStats.maxHP, waiting:baseStats.waiting };
			
			for (var i:int = 0; i < modifier.stacks; i++) 
			{
				//bleed damage each turn
				if (modifier.name == "bleed")
				{
					currentStats.hp -= modifier.value;
					world.add(new FloatingCombatText(x, y, modifier.value.toString()));
					
					//trace(this.type + " lost: " + modifier.value + " hp");
				}
				
				if (modifier.name == "berserk")
				{
					modifiedStats.atk += 15;
				}
				
				if (modifier.name == "stealth")
				{
					modifiedStats.eva += 35;
				}
			}
			
			this.currentStats.atk = modifiedStats.atk;
			this.currentStats.def = modifiedStats.def;
			this.currentStats.maxHP = modifiedStats.maxHP;
			this.currentStats.eva = modifiedStats.eva;
			this.currentStats.waiting = modifiedStats.waiting;
		}
		
		override public function added():void 
		{
			super.added();
			_startX = x;
			_startY = y;
			waiting = baseStats.waiting;
			modifiers = new Object();;
		}
		
		override public function update():void 
		{
			super.update();
			
			if (!paused)
			{
				waiting -= FP.elapsed;
				waiting = Math.max(waiting, 0);
				try 
				{
					if (waiting <= 0.01)
					{
						_waitBarData = new BitmapData(1, 3, true, 0xFFFFFFFF);
					}
					else
					{
						_waitBarData = new BitmapData(Math.ceil((waiting / baseStats.waiting) * 16), 3, true, 0xFFFFFFFF);
					}
				}
				catch (err:Error)
				{
					_waitBarData = new BitmapData(1, 3, true, 0xFFFFFFFF);
				}
				
				Graphiclist(graphic).remove(_waitBar);
				_waitBar = new Image(_waitBarData);
				_waitBar.x = 8;
				_waitBar.y = -6;
				addGraphic(_waitBar);
				
				if (waiting <= 0 && !_modsChecked)
				{
					runModifiers();
					_modsChecked = true;
				}
				
				if (waiting > 0 && _modsChecked)
				{
					_modsChecked = false;
				}
			}
			
			if (_attackTween.active)
			{
				x = _attackTween.x;
				y = _attackTween.y;
			}
		}
	
		protected function resetStats():void 
		{
			currentStats.atk = baseStats.atk;
			currentStats.def = baseStats.def;
			currentStats.maxHP = baseStats.maxHP;
			currentStats.waiting = baseStats.waiting;
			currentStats.eva = baseStats.eva;
		}
		
		public function attack(target:Character, damage:int, element:String="none"):void 
		{
			_target = target;
			_damage = damage;
			_element = element;
			
			_attackTween = new LinearPath(unwait, Tween.ONESHOT);
			addTween(attackTween);
			attackTween.addPoint(_startX, _startY);
			attackTween.addPoint(target.x, target.y);
			attackTween.addPoint(_startX, _startY);
			attackTween.setMotion(.5);
		}
		
		/**
		 * 
		 * @param	damage damage given, prior to defense
		 */
		public function takeDamage(damage:int, element:String="none"):void
		{
			var damageTaken:int = Math.max((damage - currentStats.def), 0);
			if (damage >= 0)
			{
				currentStats.hp -= damageTaken;
				world.add(new FloatingCombatText(x, y, damageTaken.toString()));
			}
			else
			{
				world.add(new FloatingCombatText(x, y, "miss"));
			}
			
			//trace(this.type + " takes " + Math.max((damage - currentStats.def), 0) + " damage.");
		}
		
		private function unwait():void 
		{
			if(_damage != 0)
				_target.takeDamage(_damage, _element);
			
			this.waiting = currentStats.waiting;
		}
		
		public function get attackTween():LinearPath 
		{
			return _attackTween;
		}
	}

}