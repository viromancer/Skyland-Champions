package StrangeDungeon 
{
	import adobe.utils.CustomActions;
	import DungeonEvents.CombatEvent;
	import DungeonEvents.DungeonEvent;
	import flash.display.BlendMode;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.TiledSpritemap;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.tweens.motion.LinearMotion;
	import net.flashpunk.tweens.motion.LinearPath;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Touch;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author ...
	 */
	public class DungeonWorld extends World 
	{
		[Embed(source = "../../assets/Level/grass0.png")]
		private const grass_png:Class;
		
		//private var level:Level;
		private var dungeonLevel:DungeonLevel;
		private var timer:Number;
		private var selectedNode:DungeonNode;
		private var mapBackground:Entity;
		private var playerRep:Entity;
		private var path:LinearMotion;
		private var _nodeToSelect:DungeonNode;
		
		public var inMotion:Boolean = false;
		
		private var empty:Boolean;
		
		public function DungeonWorld() 
		{
			empty = true;
			playerRep = new Entity(0, 0, Assets.player_icon_image);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (path.active)
			{
				playerRep.x = path.x;
				playerRep.y = path.y;
				inMotion = true;
			}
			else
			{
				inMotion = false;
			}
			camera.x = playerRep.x - FP.screen.width/2;
			camera.y = playerRep.y - FP.screen.height/2;
			//checkMouseInput();
			
		}
		
		override public function render():void 
		{
			super.render();
			//
			for each (var adjNode:DungeonNode in selectedNode.getAdjacent()) 
			{
				//Draw.text(node.x + ", " + node.y, node.x + 5, node.y - 5, { size:8 } );
				
				Draw.text(adjNode.event.name, adjNode.x + 5, adjNode.y - 5, { size:8 } );
				//Draw.line(selectedNode.x+selectedNode.halfWidth, selectedNode.y+selectedNode.halfHeight, adjNode.x+adjNode.halfWidth, adjNode.y+adjNode.halfWidth, 0xFF0000);
				
			}
			
			//Draw.circle(selectedNode.x, selectedNode.y, 141);
			//Draw.circle(selectedNode.x, selectedNode.y, 113);
			//
			//Draw.line(25 + camera.x, 0 + camera.y, 25 + camera.x, FP.screen.height + camera.y);
			//Draw.line(FP.screen.width - 25 + camera.x, 0 + camera.y, FP.screen.width - 25 + camera.x, FP.screen.height + camera.y);
			//Draw.line(0 + camera.x, 25+camera.y, FP.screen.width + camera.x, 25 + camera.y);
			//Draw.line(0 + camera.x, FP.screen.height - 25 + camera.y, FP.screen.width + camera.x, FP.screen.height - 25 + camera.y);
			//
		}
		
		override public function begin():void 
		{
			super.begin();
			timer = 0;
			
			if (empty)
			{
				//createBackground();
				addGraphic(Assets.forest_foreground_image).layer=2;
				spawnDungeon();
				empty = false;
			}
			
		}
		
		private function spawnDungeon():void
		{
			
			
			dungeonLevel = null;
			dungeonLevel = new DungeonLevel();
			selectedNode = dungeonLevel.dungeonNodes[0];
			selectedNode.visible = true;
			
			playerRep.y = selectedNode.y - playerRep.height - selectedNode.halfHeight;
			playerRep.x = selectedNode.x;
			
			path = new LinearMotion(switchWorld);
			playerRep.addTween(path, true);
			
			for each (var adjnode:DungeonNode in selectedNode.getAdjacent()) 
			{
				adjnode.visible = true;
			}
			
			for each (var node:DungeonNode in dungeonLevel.dungeonNodes) 
			{
				add(node);
			}
			
			add(playerRep);
		}
		
		public function selectNode(nodeToSelect:DungeonNode):void
		{
			_nodeToSelect = nodeToSelect;
			
			path.setMotionSpeed(playerRep.x, playerRep.y, nodeToSelect.x, nodeToSelect.y - playerRep.height - selectedNode.halfHeight, 100);
			//playerRep.y = selectedNode.y - playerRep.height - selectedNode.halfHeight;
			//playerRep.x = selectedNode.x;
			
			trace(CombatEvent(nodeToSelect.event).enemyList);
			//if(Global.eventWorld.event.enemyList.length > 0 || Global.eventWorld.event.eventType.type != "combat")
				//FP.world = Global.eventWorld;
					
			//check the event attached to the selected node
			
		}
		
		public function getSelectedNode():DungeonNode
		{
			return selectedNode;
		}
		
		private function checkMouseInput():void
		{
			var moving:Boolean = false;
			
			if (Input.mouseFlashX > FP.screen.width - 25 && Input.mouseDown) {
				moving = true;
				camera.x+=2;
			}
			if (Input.mouseFlashX < 25 && Input.mouseDown) {
				moving = true;
				camera.x-=2;
			}
			if (Input.mouseFlashY > FP.screen.height - 25 && Input.mouseDown) {
				moving = true;
				camera.y+=2;
			}
			if (Input.mouseFlashY < 25 && Input.mouseDown) {
				moving = true;
				camera.y -= 2;
			}
				
			if (Input.mouseDown && !moving) {
				timer += FP.elapsed;
				//trace(Input.mouseFlashX);
				//trace(Input.mouseFlashY);
				if (timer > 2) 
				{
					Global.eventWorld = new EventWorld(selectedNode.event);
					FP.world = Global.eventWorld;
					//removeAll();
					//spawnDungeon();
					//timer = 0;
				}
			}
		}
		
		private function checkTouchInput():void
		{
			var moving:Boolean = false;
			
			if (Input.touch[0].x > FP.screen.width - 25 && Input.touch[0].touchDown) {
				moving = true;
				camera.x+=2;
			}
			if (Input.touch[0].x < 25 && Input.touch[0].touchDown) {
				moving = true;
				camera.x-=2;
			}
			if (Input.touch[0].y > FP.screen.height - 25 && Input.touch[0].touchDown) {
				moving = true;
				camera.y+=2;
			}
			if (Input.touch[0].y < 25 && Input.touch[0].touchDown) {
				moving = true;
				camera.y -= 2;
			}
				
			if (Touch(Input.touch[0]).touchDown && !moving) {
				timer += FP.elapsed;
				//trace(Input.touch[0].x);
				//trace(Input.touch[0].y);
				if (timer > 2) 
				{
					//remove(level);
					//level = Level.createLevel(25, 25, "tomb");
					//add(level);
					timer = 0;
				}
			}
		}
		
		private function createBackground():void
		{
			var mapWidth:int = FP.width / 32;
			var mapHeight:int = FP.height / 32;
			
			var backgroundTileMap:Tilemap = new Tilemap(grass_png, FP.width, FP.height, 32, 32);
			
			for (var i:int = 0; i < mapHeight; i++) 
			{
				for (var j:int = 0; j < mapWidth; j++) 
				{
					backgroundTileMap.setTile(j, i, 0);
				}
				
			}
			
			mapBackground = new Entity(0, 0, backgroundTileMap);
			mapBackground.setHitbox(FP.width, FP.height);
		}
		
		private function switchWorld():void 
		{
			for each (var node:DungeonNode in selectedNode.getAdjacent()) 
			{
				node.visible = false;
			}
			
			selectedNode = _nodeToSelect;
			
			Global.eventWorld = new EventWorld(selectedNode.event);
			
			if (Global.eventWorld.event.type == "combat")
			{
				if (CombatEvent(Global.eventWorld.event).enemyList.length > 0) 
				{
					FP.world = Global.eventWorld;
				}
			}
			//else if (Global.eventWorld.event.eventType.type == "loot" && !Global.eventWorld.event.looted)
			//{
				//FP.world = Global.eventWorld;
			//}
			
			selectedNode.selectNode();
		}
	}

}