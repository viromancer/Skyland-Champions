package StrangeDungeon 
{
	import flash.geom.Rectangle;
	import flash.text.Font;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.TiledImage;
	/**
	 * ...
	 * @author ...
	 */
	public class Assets 
	{
		// start event backgrounds
		[Embed(source = "../../assets/Level/forest_back.jpg")]
		private static const forest_back_png:Class;
		//end event backgrounds
		
		// start map foregrounds
		[Embed(source = "../../assets/Level/visibility_circle.png")]
		private static const visibility_circle_png:Class;
		
		[Embed(source = "../../assets/Level/forest_foreground.png")]
		private static const forest_foreground_png:Class;
		// end map foregrounds
		
		[Embed(source = "../../assets/Interface/player_icon.png")]
		private static const player_icon_png:Class;
		
		//different player classes will have different images and animations, we must animate these in the player class
		[Embed(source = "../../assets/Player/thief.png")]
		public static const player_thief_png:Class;
		
		// start monster graphics
		[Embed(source = "../../assets/Monsters/forest_monsters.png")]
		public static const forest_monsters_png:Class;
		
		// end monster graphics
		
		//start interface graphics
		[Embed(source = "../../assets/Interface/420__Pixel_Art__Icons_for_RPG_by_Ails.png")]
		public static const icons_png:Class;
		
		[Embed(source = "../../assets/Interface/exp_bar_back.png")]
		private static const exp_bar_back_png:Class;
		
		[Embed(source = "../../assets/Interface/HPMP_Bar_Back.png")]
		private static const hpmp_bar_back_png:Class;
		
		[Embed(source = "../../assets/Interface/skill_back_up.png")]
		private static const skill_back_up_png:Class;
		
		[Embed(source = "../../assets/Interface/skill_back_down.png")]
		private static const skill_back_down_png:Class;
		
		[Embed(source = "../../assets/Interface/target_arrow.png")]
		private static const target_arrow_png:Class;
		
		[Embed(source = "../../assets/Interface/skill_selected.png")]
		private static const skill_selected_png:Class;
		
		[Embed(source = "../../assets/Interface/target_reticule.png")]
		private static const target_reticule_png:Class;
		
		
		//animated sheets
		[Embed(source = "../../assets/Interface/chest.jpg")]
		public static const chest_jpg:Class;
		
		//end interface
		
		//start modifier animations
		[Embed(source = "../../assets/Interface/blood_drop.png")]
		public static const blood_drop_png:Class;
		
		[Embed(source = "../../assets/Interface/berserked.png")]
		public static const berserked_png:Class;
		
		[Embed(source = "../../assets/Interface/stealth_cloud.png")]
		public static const stealth_cloud_png:Class;
		
		//end modifier animations
		
		public static const target_arrow_image:Image = new Image(target_arrow_png);
		public static const target_reticule_image:Image = new Image(target_reticule_png);
		
		public static const hpmp_bar_back_image:Image = new Image(hpmp_bar_back_png);
		public static const skill_back_up_image:Image = new Image(skill_back_up_png);
		public static const skill_selected_image:Image = new Image(skill_selected_png);
		public static const skill_back_down_image:Image = new Image(skill_back_down_png);
		
		public static const forest_back_image:Image = new Image(forest_back_png);
		public static const player_icon_image:Image = new Image(player_icon_png);
		public static const exp_bar_back_image:Image = new Image(exp_bar_back_png);
		
		public static const forest_foreground_image:Image = new Image(forest_foreground_png);
		public static const visibility_circle_image:Image = new Image(visibility_circle_png);
		
		public function Assets()
		{
			
		}
	}

}