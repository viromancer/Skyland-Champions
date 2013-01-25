package StrangeDungeon.Gui 
{
	import DungeonEvents.CombatEvent;
	import Enemies.Enemy;
	import flash.display.BitmapData;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Input;
	import StrangeDungeon.Assets;
	import StrangeDungeon.EventWorld;
	import StrangeDungeon.Global;
	import StrangeDungeon.Skill;
	/**
	 * ...
	 * @author ...
	 */
	public class SkillGuiElement extends GuiElement 
	{
		private var _skill:Skill;
		public var selected:Boolean;
		
		public function SkillGuiElement(x:int, y:int, skill:Skill) 
		{
			_skill = skill;
			selected = false;
			var graphicList:Graphiclist =  new Graphiclist(Assets.skill_back_up_image, skill.graphic);
			graphic = graphicList;
			setHitbox(skill.graphic.width, skill.graphic.height);
			type = "skill";
			super(x, y, graphic, mask);
			
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Global.player.target != null && selected && !_skill.self && Global.player.waiting <= 0)
			{
				trace("player using skill: " + _skill.name);
				_skill.useSkill(Global.player, Global.player.target);
				Global.player.target = null;
				selected = false;
				CombatGui(gui).removeArrows();
			}
			else if (_skill.self && selected && Global.player.waiting <= 0)
			{
				trace("player using skill: " + _skill.name);
				_skill.useSkill(Global.player);
				Global.player.target = null;
				selected = false;
				CombatGui(gui).removeArrows();
			}
			
			if (collidePoint(x, y, Input.mouseX, Input.mouseY))
			{
				var graphicList:Graphiclist;
				
				if (Input.mouseDown)
				{
					graphicList =  new Graphiclist(Assets.skill_back_down_image, _skill.graphic);
					graphic = graphicList;
				}

				if (Input.mouseReleased) 
				{
					Global.player.target = null;
					CombatGui(gui).removeArrows();
					
					if (!_skill.self && CombatEvent(EventWorld(FP.world).event).enemyList.length > 1)
					{
						trace("need a target for: " + _skill.name);
						CombatGui(gui).pickTarget = true;
						CombatGui(gui).showArrows = true;
					}
					else if (!_skill.self && CombatEvent(EventWorld(FP.world).event).enemyList.length == 1)
					{
						Global.player.target = CombatEvent(EventWorld(FP.world).event).enemyList[0];
						CombatGui(gui).showArrowAtEnemy(Enemy(Global.player.target));
					}
					CombatGui(gui).selectSkill(this);
				}
			}
			
			if (Input.mouseUp && !selected)
			{
				graphicList =  new Graphiclist(Assets.skill_back_up_image, _skill.graphic);
				graphic = graphicList;
			}
			else if (selected)
			{
				Assets.skill_selected_image.x = -2;
				Assets.skill_selected_image.y = -2;
				graphicList =  new Graphiclist(Assets.skill_selected_image, _skill.graphic);
				graphic = graphicList;
			}
		}
		//else
		//{
			//var cd:Text = new Text(Math.ceil(_skill.cooldownRemaining).toString(), 0, 0, { "size":20, "color":0xFF0000 } );
			//cd.x = Assets.skill_back_down_image.width / 2 - cd.textWidth / 2;
			//cd.y = Assets.skill_back_down_image.height / 2 - cd.textHeight / 2;
			//var greyOut:Image = new Image(new BitmapData(34, 34, true, 0x99FFFFFF));
			//greyOut.originX = -1;
			//greyOut.originY = -1;
			//graphicList = new Graphiclist(Assets.skill_back_down_image, _skill.graphic, greyOut, cd);
			//graphic = graphicList;
		//}
		
	}

}