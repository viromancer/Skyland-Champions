package StrangeDungeon
{
	import flash.desktop.NativeApplication;
	import flash.display.StageDisplayState;
	import flash.display.StageQuality;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Matrix;
	import flash.system.Capabilities;
	import flash.system.MessageChannelState;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import playerio.*;
	
	/**
	 * ...
	 * @author Jake Ford
	 */
	public class Main extends Engine 
	{
		[Embed(source = "../../assets/Fonts/Mecha.ttf", embedAsCFF = "false", fontFamily = "Mecha")] private var mecha_font:Class;
		
		private var gameID:String = "strange-dungeon-u49ycughwkkf0gafvdrlea"
		
		public function Main():void 
		{
			//Text.font = "mecha";
			super(240, 400, 60, false)
			// Resize code
			
			//Get device screen resolution
			//var scrWidth:Number;
			//var scrHeight:Number;
			//scrWidth = Capabilities.screenResolutionX;
			//scrHeight = Capabilities.screenResolutionY;

			//do math to scale window to device size
			//var scaledWidth:Number;
			//var scaledHeight:Number;
			//scaledWidth = (scrWidth / 240);
			//scaledHeight = (scrHeight / 400);

			//scales the swf to the scaled size
			//FP.screen.scaleX = scaledWidth;
			//FP.screen.scaleY = scaledHeight;
			//this.cacheAsBitmap = true;
			//this.cacheAsBitmapMatrix = new Matrix();
			
			FP.screen.scaleX = 2;
			FP.screen.scaleY = 2;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			//stage.quality = StageQuality.LOW;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			FP.console.enable();
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			// entry point
			//PlayerIO.connect(
				//stage,
				//gameID,
				//"public",
				//"GuestUser",
				//"",
				//"",
				//handleConnect,
				//handleError
			//);
		}
		
		private function deactivate(e:Event):void 
		{
			// auto-close
			NativeApplication.nativeApplication.exit();
		}
		
		private function handleConnect(client:Client):void
		{
			trace("Connected to server");
			
			client.multiplayer.developmentServer = "127.0.0.1:8184";
			
			Global.client = client;
			
			client.multiplayer.createJoinRoom(
				"StrangeDungeon",
				"StrangeDungeon",
				false,
				{},
				{},
				handleJoin,
				handleError
			);
			
		}
		
		override public function init():void 
		{
			super.init();
			
			Global.initAll();
			FP.world = Global.dungeonWorld;
		}
		
		//monitor for game pause, world switch, etc
		override public function update():void 
		{
			super.update();
			
		}
		
		private function handleJoin(connection:Connection):void
		{
			Global.connection = connection;
			
			connection.send("MyNameIs", "John");
			
			//this is to handle received messages
			connection.addMessageHandler("Back", function(m:Message):void {
				trace("Hello, " + m.getString(0)); 
			});
			
			FP.world = Global.dungeonWorld;
		}
		
		private function handleError(error:PlayerIOError):void
		{
			trace("Got ", error);
		}
	}
	
}