package StrangeDungeon.Gui 
{
	import Enemies.Enemy;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.VarTween;
	import StrangeDungeon.Assets;
	/**
	 * ...
	 * @author ...
	 */
	public class BouncingArrow extends GuiElement 
	{
		private var _startY:int, _direction:String, _rotateTween:VarTween;
		
		public var noBounce:Boolean;
		
		public function BouncingArrow(x:Number, y:Number, graphic:Graphic, noBounce:Boolean=false) 
		{
			Image(graphic).angle = 0;
			
			type = "bouncingArrow";
			this.noBounce = noBounce;
			
			_startY = y;
			_direction = "down";
			
			if (noBounce)
			{
				Image(graphic).originX = Image(graphic).width / 2;
				Image(graphic).originY = Image(graphic).height / 2;
				_rotateTween = new VarTween(null, Tween.LOOPING);
				_rotateTween.tween(graphic, "angle", 360, 3.2);
				addTween(_rotateTween, true);
			}
			super(x, y, graphic, null);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (noBounce) 
			{
				return;
			}
			
			if (y < _startY - 10 && _direction == "up")
			{
				_direction = "down";
			}
			else if (y >= _startY && _direction == "down")
			{
				_direction = "up"
			}
			
			if (_direction == "up") 
			{
				y -= FP.elapsed*60;
			}
			else
			{
				y += FP.elapsed*60;
			}
		}
		
	}

}