package StrangeDungeon 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author ...
	 */
	public class DungeonLevel 
	{
		public var dungeonNodes:Vector.<DungeonNode>;
		private var enemies:int;
		private	var shops:int = 0;
		private var sectorRows:int, sectorColumns:int;
		private var width:int = FP.width;
		private var height:int = FP.height;
		private var widthPerSector:int;
		private var heightPerSector:int;
		private var maxXDistance:int;
		private var maxYDistance:int;
		private var totalNodes:int = 0;
		
		public function DungeonLevel() 
		{
			dungeonNodes = new Vector.<DungeonNode>();
			sectorRows = 6;
			sectorColumns = 8;
			enemies = (sectorColumns * sectorRows) / 1.5;
			widthPerSector = width / sectorRows;
			heightPerSector = height / sectorColumns;
			maxXDistance = Math.sqrt(Math.pow((heightPerSector), 2) * 2);
			maxYDistance = Math.sqrt(Math.pow((widthPerSector), 2) * 2);
			createDungeon();
		}
		
		/*
		 * Creates a dungeon.  Each sector is a 10x10 square.
		 * New sectors are created at any of the far ends of 
		 * the previous sector.  The max distance between 2 nodes
		 * is 26. (10-1) * 2 = 18, this is the x and y coordinate
		 * of the furthest possible points in two sectors. Applying
		 * pythagorean's theorem: c=sqrt((18^2) + (18^2)) = 25.45.
		 * Since we're dealing with ints, round up to 26.
		 * 
		 * Fig 1. pixelsPerSector = 3
		 * 0,0
		 * |x| | |
		 * | |\| |
		 * | | |\| 
		 *       |\| | |
		 *       | |\| |
		 *       | | |x|
		 * 	 		   4,4
		 *  Max coordinate formula is (pixelsPerSector) * 2
		 */ 
		private function createDungeon():void
		{
			
			//trace(width + "/" + sectorColumns + "=" + widthPerSector);
			//trace(height + "/" + sectorRows + "=" +heightPerSector);
			
			var sectorsCreated:int = 0;
			
			for (var j:int = 0; j < sectorRows; j++) 
			{
				for (var k:int = 0; k < sectorColumns; k++) 
				{
					//trace("sector: " + j + ", " + k);
					//randomize how many nodes can be in a sector
					var nodes:int = 1;// + FP.rand(2);
					var nodeToAdd:DungeonNode;
					while (nodes > 0) 
					{
						if (j == sectorRows - 1 && k == sectorColumns - 1 && nodes == 1)
						{
							nodeToAdd = pickNodeType(j,k,true);
						}
						else
						{
							nodeToAdd = pickNodeType(j,k);
						}
						
						dungeonNodes.push(nodeToAdd);
						totalNodes++;
						nodes--;
					}
				}
			}
			
			//var bonusNodes:int = 4 + FP.rand(3);
			//
			//trace("bonus nodes:");
			//while (bonusNodes > 0) 
			//{
				//randX = 50 + FP.rand(250);
				//randY = 50 + FP.rand(250);
				//trace(randX + ", " + randY);
				//dungeonNodes.push(new DungeonNode(randX, randY));
				//bonusNodes--;
			//}
				
			
			for (var i:int = 0; i < dungeonNodes.length; i++) 
			{
				for (var l:int = 0; l < dungeonNodes.length; l++) 
				{
					if (Math.abs(FP.distance(dungeonNodes[i].x, 0, dungeonNodes[l].x, 0)) <= maxXDistance)
					{
						if (Math.abs(FP.distance(0, dungeonNodes[i].y, 0, dungeonNodes[l].y)) <= maxYDistance)
						{
							dungeonNodes[i].addAdjacent(dungeonNodes[l]);
						}
					}
				}
			}
			
			for each (var node:DungeonNode in dungeonNodes) 
			{
				if (node.getAdjacent().length == 0)
				{
					dungeonNodes.splice(dungeonNodes.indexOf(node), 1);
				}
				
				if (node.getAdjacent().length == 1)
				{
					var badFriend:DungeonNode = node.getAdjacent().pop();
					if (badFriend.getAdjacent().length == 1)
					{
						dungeonNodes.splice(dungeonNodes.indexOf(node), 1);
						dungeonNodes.splice(dungeonNodes.indexOf(badFriend), 1);
					}
				}
			}
		}
		
		private function pickNodeType(j:int, k:int, end:Boolean=false):DungeonNode
		{
			var nodeToAdd:DungeonNode;
			//the x and y position can be anywhere in the sector.
			var randX:int = ((j*widthPerSector) + FP.rand(widthPerSector));
			var randY:int = ((k*heightPerSector) + FP.rand(heightPerSector));
			//trace(randX + ", " + randY);
			
			if (randX <= 25)
				randX = 25;
			if (randY <= 25)
				randY = 25;
			if (randX >= width - 25)
				randX = width - 25;
			if (randY >= height - 25)
				randY = height - 25;
			var randomizeType:Number = FP.random;
			
			if (totalNodes == 0)
			{
				nodeToAdd = new DungeonNode(randX, randY, "start");
			}
			else if (end == true)
			{
				nodeToAdd = new DungeonNode(randX, randY, "end");
			}
			else if (0 < randomizeType && randomizeType <= .15)
			{
				nodeToAdd = new DungeonNode(randX, randY, "loot_minor");
			}
			else if (.15 < randomizeType && randomizeType <= .4)
			{
				nodeToAdd = new DungeonNode(randX, randY, "monster_minor");
			}
			else if (.4 < randomizeType && randomizeType <= .55)
			{
				nodeToAdd = new DungeonNode(randX, randY, "quest");
			}
			else if (.55 < randomizeType && randomizeType <= .75)
			{
				if (shops >= 2)
				{
					nodeToAdd = pickNodeType(j,k);
				}
				else 
				{
					nodeToAdd = new DungeonNode(randX, randY, "shop");
					shops++;
				}
			}
			else if (.75 < randomizeType && randomizeType <= .85)
			{
				nodeToAdd = new DungeonNode(randX, randY, "none");
			}
			else if (.85 < randomizeType && randomizeType <= .92)
			{
				nodeToAdd = new DungeonNode(randX, randY, "monster_major");
			}
			else if (.92 < randomizeType && randomizeType <= .995)
			{
				nodeToAdd = new DungeonNode(randX, randY, "quest_major");
			}
			else if (.99 < randomizeType && randomizeType <= 1)
			{
				nodeToAdd = new DungeonNode(randX, randY, "loot_epic");
			}
			
			return nodeToAdd;
		}
	}

}