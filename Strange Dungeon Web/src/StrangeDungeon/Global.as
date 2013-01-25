package StrangeDungeon 
{
	import DungeonEvents.CombatEvent;
	import DungeonEvents.DungeonEvent;
	import DungeonEvents.DungeonEventType;
	import Enemies.Enemy;
	import flash.geom.Rectangle;
	import net.flashpunk.graphics.Anim;
	import net.flashpunk.graphics.Image;
	import playerio.Client;
	import playerio.Connection;
	import Enemies.EnemyType;
	import StrangeDungeon.Gui.CombatGui;
	import StrangeDungeon.Gui.Gui;
	/**
	 * ...
	 * @author ...
	 */
	public class Global 
	{
		public static var connection:Connection;
		public static var client:Client;
		
		public static var player:Player = new Player();
		
		public static var dungeonWorld:DungeonWorld;
		public static var eventWorld:EventWorld = new EventWorld(null);
		
		//enemy types - should be named the same as the enemy type name
		public static var rat:EnemyType;
		public static var troll:EnemyType;
		public static var spinyFrog:EnemyType;
		public static var anaconda:EnemyType;
		public static var giantAnt:EnemyType;
		
		
		//modifiers - should be named the same as the modifier followed by Mod
		public static var bleed:Modifier;
		public static var berserk:Modifier;
		public static var stealth:Modifier;
		
		//skills - name of the skill followed by Skill
		public static var stabSkill:Skill;
		public static var basicAttack:Skill;
		public static var goBerserk:Skill;
		public static var vanish:Skill;
		
		//monsters - should be named by their type and number
		public static var forestEnemies:Vector.<EnemyType> = new Vector.<EnemyType>();
		
		//events - should be named with a unique name, followed by their category
		public static var forest_monster_rat:CombatEvent;
		public static var forest_loot_minor:DungeonEventType;
		
		//guis
		public static var combatGui:CombatGui;
		
		public function Global() 
		{
			
		}
		
		/**
		 * Initialize all the game data objects
		 */
		public static function initAll():void 
		{
			
			
			initDungeon();
			initModifiers();
			initSkills();
			
			player.skills.push(Skill.spawnSkill(basicAttack));
			player.skills.push(Skill.spawnSkill(stabSkill));
			player.skills.push(Skill.spawnSkill(goBerserk));
			player.skills.push(Skill.spawnSkill(vanish));
			
			combatGui = new CombatGui();
			
			initEnemyTypes();
			initEnemies();
			initEvents();
		}
		
		public static function initDungeon():void
		{
			dungeonWorld = new DungeonWorld();
		}
		
		public static function initEnemyTypes():void 
		{
			rat = new EnemyType("rat", 55, 0, 7, 2.0, 2, new Image(Assets.forest_monsters_png, new Rectangle(3 * 32, 1 * 32, 32, 32)), 0, new <Skill>[Skill.spawnSkill(basicAttack)]);
			troll = new EnemyType("troll", 25, 0, 10, 3.5, 2, new Image(Assets.forest_monsters_png, new Rectangle(0 * 32, 2 * 32, 32, 32)), 0, new <Skill>[Skill.spawnSkill(basicAttack)]);
		}
		
		public static function initEnemies():void
		{
			//enemies in the forest zone
			forestEnemies.push(rat);
			forestEnemies.push(troll);
		}
		
		public static function initEvents():void
		{
			forest_monster_rat = new CombatEvent(combatGui, new <EnemyType>[rat, rat], "forest_monster_rat", Assets.forest_back_image);
			//forest_monster_minor = new DungeonEventType("forest_monster_minor", "combat", Assets.forest_back_image, forestEnemies);
			//forest_loot_minor = new DungeonEventType("forest_loot_minor", "loot", Assets.forest_back_image);
		}
		
		public static function initModifiers():void 
		{
			bleed = new Modifier("bleed", false, 5, 10, 2, Assets.blood_drop_png, 2);
			berserk = new Modifier("berserk", true, 10, 5, 5, Assets.berserked_png, 2);
			stealth = new Modifier("stealth", true, 1, 0, 1, Assets.stealth_cloud_png, 1);
		}
		
		public static function initSkills():void
		{
			stabSkill = new Skill("stab", bleed, 0, 0, new Image(Assets.icons_png, new Rectangle(6 * 34, 25 * 34, 34, 34)));
			basicAttack = new Skill("basic_attack", null, 1, 0, new Image(Assets.icons_png, new Rectangle(0 * 34, 5 * 34, 34, 34)));
			goBerserk = new Skill("berserk", berserk, 0, 0, new Image(Assets.icons_png, new Rectangle(0 * 34, 26 * 34, 34, 34)), true);
			vanish = new Skill("vanish", stealth, 0, 0, new Image(Assets.icons_png, new Rectangle(0 * 34, 21 * 34, 34, 34)), true);
		}
	}

}