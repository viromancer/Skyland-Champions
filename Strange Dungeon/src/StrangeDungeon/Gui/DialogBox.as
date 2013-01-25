package StrangeDungeon.Gui 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Mask;
	import StrangeDungeon.Assets;
	/**
	 * ...
	 * @author ...
	 */
	public class DialogBox extends GuiElement 
	{
		private var _text:Text;
		
		public function DialogBox(x:int=0, y:int=0, text:String="error") 
		{
			
			_text = new Text(text, 0, 0, { "color":0xFFFFFF, "size":8 } );
			graphic = new Graphiclist(new Image(new BitmapData(_text.textWidth, _text.textHeight + 5, false, 0x000000)), _text);
			type = "dialogBox";
			
			super(x, y, graphic, mask);
		}
		
	}

}