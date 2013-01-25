package StrangeDungeon 
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	/**
	 * This class is mainly used for storing information about the player.
	 * Since there can only ever be one player, we'll store the player in 
	 * the global object for tracking purposes.
	 * @author ...
	 */
	public class Player extends Character
	{
		public var level:int, experienceAmounts:Array, experience:int, totalExperience:int;
		public var target:Character;
		
		private var spriteMap:Spritemap;
		
		public function Player(x:int=0, y:int=0, graphic:Graphic=null, mask:Mask=null) 
		{
			spriteMap = new Spritemap(Assets.player_thief_png, 32, 32);
			spriteMap.add("walk", [0, 1], 3, true );
			spriteMap.play("walk");
			graphic = spriteMap;
			
			layer = -10;
			
			experience = 0;
			totalExperience = 0;
			type = "player";
			level = 1;
			experienceAmounts = [0, 5, 10, 20, 40, 80, 160, 320, 640, 1280, 2560, 5120, 10240, 20480, 40960];
			
			super(x, y, graphic, mask);
			
			setHitbox(32, 32);
			
			baseStats.hp = 200;
			baseStats.mana = 20;
			baseStats.atk = 10;
			baseStats.def = 10;
			currentStats.hp = baseStats.hp;
			currentStats.mana = baseStats.mana;
			
			skills = new Vector.<Skill>();
			
			//set current stats = base stats
			resetStats();
		}
		
		override public function update():void 
		{
			super.update();
			
			if (experience >= experienceAmounts[level])
				levelUp();
			//once we have a skill array, be sure to call updatecooldown each frame
		}
		
		override public function added():void 
		{
			super.added();
			for each (var skill:Skill in skills) 
			{
				skill.resetCooldown();
			}
			resetStats();
		}
		
		private function levelUp():void 
		{
			level++;
			experience = 0;
		}

	}

}