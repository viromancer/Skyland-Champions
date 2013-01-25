package StrangeDungeon 
{
	import DungeonEvents.CombatEvent;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.utils.Input;
	import DungeonEvents.DungeonEvent;
	/**
	 * ...
	 * @author ...
	 */
	public class DungeonNode extends Entity
	{
		[Embed(source = "../../assets/Level/node_unvisited.png")]
		private const unvisited_png:Class;
		
		[Embed(source = "../../assets/Level/node_unvisited.png")]
		private const debug_node_png:Class;
		
		private var adjacentNodes:Vector.<DungeonNode>;
		private var debugNode:Image;
		private var nodeTheme:String;
		private var _event:DungeonEvent;
		
		public function DungeonNode(x:int, y:int, eventType:String) 
		{
			debugNode = new Image(debug_node_png);
			this.x = x;
			this.y = y;
			this.graphic = debugNode;
			this.mask = new Pixelmask(debug_node_png);
			adjacentNodes = new Vector.<DungeonNode>();
			this.visible = false;
			layer = 1;
			switch (eventType) 
			{
				case "monster_minor":
					_event = Global.forest_monster_rat.spawnEvent();
				break;
				//case "loot_minor":
					//_event = Global.forest_loot_minor.spawnDungeonEvent();
					//trace("spawned loot at: " + x + ", " + y);
				//break;
				default:
					_event = Global.forest_monster_rat.spawnEvent();
			}
		}
		
		override public function render():void 
		{
			super.render();
			
			Draw.line(	DungeonWorld(world).getSelectedNode().x + DungeonWorld(world).getSelectedNode().halfWidth,
						DungeonWorld(world).getSelectedNode().y + DungeonWorld(world).getSelectedNode().halfHeight,
						x+halfWidth, y+halfWidth, 0xFFFFFF);
			
			//Draw.line(25 + camera.x, 0 + camera.y, 25 + camera.x, FP.screen.height + camera.y);
			//Draw.line(FP.screen.width - 25 + camera.x, 0 + camera.y, FP.screen.width - 25 + camera.x, FP.screen.height + camera.y);
			//Draw.line(0 + camera.x, 25+camera.y, FP.screen.width + camera.x, 25 + camera.y);
			//Draw.line(0 + camera.x, FP.screen.height - 25 + camera.y, FP.screen.width + camera.x, FP.screen.height - 25 + camera.y);
			//
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Input.mousePressed) 
			{
				if (collidePoint(x, y, Input.mouseX + FP.camera.x, Input.mouseY + FP.camera.y) && DungeonWorld(this.world).getSelectedNode().getAdjacent().indexOf(this) != -1 && !DungeonWorld(this.world).inMotion)
				{
					DungeonWorld(this.world).selectNode(this);
				}
			}
		}
		
		public function addAdjacent(node:DungeonNode):void
		{
			adjacentNodes.push(node);
		}
		
		public function getAdjacent():Vector.<DungeonNode> 
		{
			return adjacentNodes;
		}
		
		public function get event():DungeonEvent 
		{
			return _event;
		}
		
		public function selectNode():void
		{
			debugNode.color = 0x000000;
			this.visible = true;
			for each (var node:DungeonNode in adjacentNodes) 
			{
				node.visible = true;
			}
			
		}
	}

}