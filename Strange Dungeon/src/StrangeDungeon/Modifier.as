package StrangeDungeon
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author ...
	 */
	public class Modifier 
	{
		private var _image:Class, _frames:int, _immediate:Boolean;
		
		//mod name
		public var name:String;
		
		//ticks for mod to stick around -1 for "until cured"
		public var ticks:int;
		
		//value of the mod for damage related mods (eg. 50 bleed damage over 3 seconds would have 50 for value and 3 for time.
		//some mods will have no use for value.
		public var value:int;
		
		//how many stacks are allowed
		public var maxStacks:int;
		
		//how many stacks a modifier currently has
		public var stacks:int;
		
		//the spritemap for the animation to play when a character is under the effect of this modifier
		public var spriteMap:Spritemap;
		
		//the current time passed on the modifier
		public var ticker:Number;
		/**
		 * 
		 * @param	name name of the status effect
		 * @param	immediate should the effect start immediately, or after the first tick
		 * @param	ticks number of ticks for the effect to be applied
		 * @param	value varies per effect.  can be used for damage / healing over time, etc
		 * @param	maxStacks the number of stacks this modifier can have applied
		 * @param	image the image to use for the spritemap (the animation will always be named "default"
		 * @param	frames the number of frames in the animation
		 */
		public function Modifier(name:String = "error", immediate:Boolean=false, ticks:int = 0, value:int = 0, maxStacks:int = 1, image:Class=null, frames:int=0 )
		{
			this.name 	= name;
			this.value	= value;
			this.ticks	= ticks;
			this.maxStacks = maxStacks;
			this.stacks = 1;
			_image = image;
			_frames = frames;
			_immediate = immediate;
			
			if (immediate)
			{
				ticker = 1;
			}
			else
			{
				ticker = 0;
			}
			
			if (image != null)
			{
				var imageWidthTest:Image = new Image(image);
				this.spriteMap = new Spritemap(image, imageWidthTest.width / frames, imageWidthTest.height);
				imageWidthTest = null;
				var frameArray:Array = new Array();
				for (var i:int = 0; i < frames; i++) 
				{
					frameArray.push(i);
				}
				spriteMap.add("default", frameArray, 4, true);
			}
			
			
		}
		
		public function spawnModifier():Modifier
		{
			return new Modifier(name, _immediate, ticks + 1, value, maxStacks, _image, _frames );
		}
		
		public function ready(elapsed:Number):Boolean 
		{
			ticker += elapsed;
			if (ticker >= 1)
			{
				ticker = 0;
				return true;
			}
			else
			{
				return false;
			}
		}
	}

}