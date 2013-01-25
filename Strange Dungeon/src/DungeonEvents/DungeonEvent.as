package DungeonEvents 
{
	import Enemies.Enemy;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import StrangeDungeon.Gui.Gui;
	/**
	 * ...
	 * @author ...
	 */
	public class DungeonEvent 
	{
		private static var allowInstantiation:Boolean = false;
		private var _name:String;
		public var looted:Boolean;
		protected var _gui:Gui;
		private var _background:Image
		private var _type:String;
		
		public function DungeonEvent(gui:Gui, name:String, background:Image, type:String) 
		{
			_background = background;
			_name = name;
			_gui = gui;
			_type = type;
		}
		
		public function update():void 
		{
			
		}
		
		public function begin():void 
		{
			_gui.start();
		}
		
		public function get gui():Gui 
		{
			return _gui;
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function get background():Image 
		{
			return _background;
		}
		
		public function get type():String 
		{
			return _type;
		}
	}

}