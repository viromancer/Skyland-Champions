package net.flashpunk.utils
{
	import flash.geom.Point;

	public class Touch
	{
		/**
		 * Last x coordinate touch input.
		 */
		public var x:int = 0;
		
		/**
		 * Last y coordinate touch input.
		 */
		public var y:int = 0;
		
		/**
		 * If touch input is down.
		 */
		public var touchDown:Boolean = false;
		
		/**
		 * If touch input is up.
		 */
		public var touchUp:Boolean = true;
		
		/**
		 * If touch input was released this frame.
		 */
		public var touchReleased:Boolean = false;
		
		/**
		 * If touch input was pressed this frame.
		 */
		public var touchPressed:Boolean = false;
		
		/**
		 * If touch input was tapped.
		 */
		public var touchTapped:Boolean = false;
		 
		/**
		 * Touch input object
		 */
		public function Touch()
		{
		}
		
		/**
		 * Updates x and y coordinates of touch input.
		 */
		public function update(newX:int, newY:int):void
		{
			x = newX;
			y = newY;
		}
	}
}