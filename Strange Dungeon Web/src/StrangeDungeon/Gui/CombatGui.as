package StrangeDungeon.Gui 
{
	import Enemies.Enemy;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.tweens.misc.VarTween;
	import StrangeDungeon.Assets;
	import StrangeDungeon.Global;
	import StrangeDungeon.Skill;
	
	/**
	 * ...
	 * @author ...
	 */
	public class CombatGui extends Gui
	{
		public var pickTarget:Boolean = false, showArrows:Boolean, showingTargetArrow:Boolean = false;
		
		private var hpmp_bar:GuiElement;
		private var hp_bar:BarElement;
		
		public function CombatGui() 
		{
			super();
			
			hpmp_bar = new GuiElement(0, 0, Assets.hpmp_bar_back_image);
			addElement(hpmp_bar);
			
			//addElement(new BouncingArrow(10, 10, Assets.target_arrow_image));
			
			hp_bar = new BarElement(hpmp_bar.x + 26, hpmp_bar.y + 4, "hp", 55, 13, null, 0xFFFF0000);
			addElement(hp_bar);
			
			var skill1:SkillGuiElement = new SkillGuiElement(FP.screen.width / 2 - (42 * 2) - 21, FP.screen.height - (64 ), Global.player.skills[0]);//Skill.spawnSkill(Global.basicAttack));
			addElement(skill1);
			var skill2:SkillGuiElement = new SkillGuiElement(FP.screen.width / 2 - (42) - 21, FP.screen.height - (64 ), Global.player.skills[1]);
			addElement(skill2);
			var skill3:SkillGuiElement = new SkillGuiElement(FP.screen.width / 2 - 21, FP.screen.height - (64 ), Global.player.skills[2]);
			addElement(skill3);
			var skill4:SkillGuiElement = new SkillGuiElement(FP.screen.width / 2 + (42) - 21, FP.screen.height - (64 ), Global.player.skills[3]);
			addElement(skill4);
			var skill5:SkillGuiElement = new SkillGuiElement(FP.screen.width / 2 + (42*2) - 21, FP.screen.height - (64 ), Skill.spawnSkill(Global.stabSkill));
			addElement(skill5);
		}
		
		override public function start():void 
		{
			super.start();
			removeArrows();
			hpmp_bar.x = Global.player.x - 32;
			hpmp_bar.y = Global.player.y + 36;
			hp_bar.x = hpmp_bar.x + 26;
			hp_bar.y = hpmp_bar.y + 4;
			
		}
		
		public function selectSkill(selectedElement:SkillGuiElement):void
		{
			for each (var guiElement:GuiElement in guiElements) 
			{
				if (guiElement.type != "skill")
					continue;
				
				if (guiElement != selectedElement)
				{
					SkillGuiElement(guiElement).selected = false;
				}
				else
				{
					SkillGuiElement(guiElement).selected = true;
				}
			}
			
		}
		
		public function showTargetArrows(enemies:Vector.<Enemy>):void 
		{
			if (showArrows == true)
			{
				FP.world.add(addElement(new DialogBox(FP.screen.width / 2 - 32, 80, "Choose Target")));
				for each (var enemy:Enemy in enemies) 
				{
					FP.world.add(addElement(new BouncingArrow(enemy.startX + Assets.target_arrow_image.width/2, enemy.startY-Assets.target_arrow_image.height, Assets.target_arrow_image)));
				}
				showArrows = false;
			}
		}
		
		public function showArrowAtEnemy(enemy:Enemy):void
		{
			if(!showingTargetArrow)
			{
				FP.world.add(addElement(new BouncingArrow(enemy.startX+18, enemy.startY+18, Assets.target_reticule_image, true )));
				showingTargetArrow = true;
			}
		}
		
		public function removeArrows():void
		{
			for each (var element:GuiElement in guiElements) 
			{
				if (element.type == "bouncingArrow" || element.type == "dialogBox")
					removeElement(element);
			}
			
			showingTargetArrow = false;
		}
		
	}

}