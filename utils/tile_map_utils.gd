extends Node
class_name TileMapUtils

const ARROW_DIRECTIONS = [
	Vector2.UP, Vector2.DOWN, 
	Vector2.LEFT, Vector2.RIGHT,
]

const DIAGONAL_DIRECTIONS = [
	Vector2.UP + Vector2.LEFT,
	Vector2.UP + Vector2.RIGHT,
	Vector2.DOWN + Vector2.LEFT,
	Vector2.DOWN + Vector2.RIGHT,
]

static func generate_basic_tile_map(size :int, is_grand_map :bool = true) -> TileMapFileData:
	var tiles = get_adjacent_tiles(get_directions(), Vector2.ZERO, 2)
	tiles.push_front(Vector2.ZERO)
	
	var tile_datas = []
	var navigations = []
	var tile_ids = {}
	var objects = []
	
	for id in tiles:
		var data :TileMapData = TileMapData.new()
		data.tile_type = 1
		data.id = id
		data.pos = Vector3(id.x, 0, id.y) * 1.05
		tile_datas.append(data)
		
		var nav_id = tile_datas.size()
		tile_ids[id] = nav_id
		
		# water
		if id in [Vector2.ZERO , Vector2(-1, 1), Vector2(1, -1)]:
			data.tile_type = 2
			continue
			
		var object = MapObjectData.new()
		object.pos = data.pos
		# bases
		if id in [Vector2(-2,0),Vector2(2,0)]:
			object.scene = preload("res://scenes/tile_objects/grand/faction_base.tscn")
			
		# capture point
		elif id in [Vector2(0,-1),Vector2(0,1)]:
			object.scene = preload("res://scenes/tile_objects/grand/flag_pole.tscn")
			
		else:
			var forests = [
				preload("res://scenes/tile_objects/grand/forest_1.tscn"),
				preload("res://scenes/tile_objects/grand/forest_2.tscn")
			]
			object.scene = forests[randi() % 2]
			
		object.is_blocking = false
		objects.append(object)
		
	for id in tiles:
		var nav_data :NavigationData = NavigationData.new()
		nav_data.id = id
		nav_data.navigation_id = tile_ids[id]
		nav_data.enable = not Vector2.ZERO
		nav_data.neighbors = []
		
		var _tiles = get_adjacent_tiles(ARROW_DIRECTIONS if is_grand_map else get_directions(), id)
		for i in _tiles:
			if tile_ids.has(i):
				nav_data.neighbors.append(tile_ids[i])
	
	var map_data :TileMapFileData = TileMapFileData.new()
	map_data.tiles = tile_datas
	map_data.tile_ids = tile_ids
	map_data.objects = objects
	map_data.navigations = navigations
	
	return map_data
	
# return all adjacent tiles
# with range and type of direction
# only returned tile that registered in Astar navigation
static func get_astar_adjacent_tile(nav :AStar2D, navigation_id: int, radius: int = 1, blocked_nav_ids :Array = []) -> Array:
	var visited := {}
	var result := []
	var queue := [navigation_id]
	visited[navigation_id] = 0
	
	while not queue.empty():
		var current_id = queue.pop_front()
		var current_depth = visited[current_id]
		
		if current_depth >= radius:
			continue
			
		for neighbor_id in nav.get_point_connections(current_id):
			if neighbor_id in visited:
				continue
				
			if nav.is_point_disabled(neighbor_id):
				continue
				
			if blocked_nav_ids.has(neighbor_id):
				continue
				
			visited[neighbor_id] = current_depth + 1
			queue.append(neighbor_id)
			result.append(nav.get_point_position(neighbor_id))
			
	visited.clear()
	queue.clear()
	
	return result # [Vector2]
	
# return all adjacent tiles
# with range and type of direction
static func get_adjacent_tiles(directions :Array, from: Vector2 = Vector2.ZERO, radius: int = 1) -> Array:
	var visited := {}
	var frontier := [from]
	visited[from] = true
	
	for step in range(radius):
		var next_frontier := []
		for current in frontier:
			for dir in directions:
				var neighbor = current + dir
				if not visited.has(neighbor):
					visited[neighbor] = true
					next_frontier.append(neighbor)
		frontier = next_frontier
		
	# just remove from
	visited.erase(from)
	
	var tiles :Array = visited.keys().duplicate()
	visited.clear()
	
	return tiles # [Vector2]
	
static func get_directions() -> Array:
	return ARROW_DIRECTIONS + DIAGONAL_DIRECTIONS
	
