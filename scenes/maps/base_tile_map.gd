extends Spatial
class_name BaseTileMap

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

# return all adjacent tiles
# with range and type of direction
# only returned tile that registered in Astar navigation
func get_astar_adjacent_tile(navigation_id: int, navigation :AStar2D, radius: int = 1, blocked_nav_ids :Array = []) -> Array:
	var visited := {}
	var result := []
	var queue := [navigation_id]
	visited[navigation_id] = 0
	
	while not queue.empty():
		var current_id = queue.pop_front()
		var current_depth = visited[current_id]
		
		if current_depth >= radius:
			continue
			
		for neighbor_id in navigation.get_point_connections(current_id):
			if neighbor_id in visited:
				continue
				
			if navigation.is_point_disabled(neighbor_id):
				continue
				
			if blocked_nav_ids.has(neighbor_id):
				continue
				
			visited[neighbor_id] = current_depth + 1
			queue.append(neighbor_id)
			result.append(navigation.get_point_position(neighbor_id))
			
	visited.clear()
	queue.clear()
	
	return result # [Vector2]
	
# return all adjacent tiles
# with range and type of direction
func get_adjacent_tiles(directions :Array, from: Vector2, radius: int = 1) -> Array:
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
		
	visited.erase(from)
	return visited.keys()
