extends Spatial
class_name BaseTileMap

signal on_map_ready

var _click_position :Vector3
var _spawned_tiles :Dictionary = {} # { Vector2 : BaseTile }
var _tile_map_data :TileMapFileData
var _is_editor :bool = false

onready var _navigation :AStar2D = AStar2D.new()
onready var _air_navigation :AStar2D = AStar2D.new()

func generate_from_data(data: TileMapFileData, is_editor:bool = false):
	_clean()
	
	_is_editor = is_editor
	_tile_map_data = data
	
	_spawn_tiles()
	_spawn_objects()
	_update_navigations()
	
	yield(get_tree(),"idle_frame")
	emit_signal("on_map_ready")
	
func export_data() -> TileMapFileData:
	return _tile_map_data
	
func get_tiles() -> Array:
	return _spawned_tiles.values() # [ Tile ]
	
func has_tile(id :Vector2) -> bool:
	return _spawned_tiles.has(id)
	
func get_tile(id :Vector2) -> BaseTile:
	return _spawned_tiles[id] # Tile
	
func update_spawned_tile(data :TileMapData):
	var _spawned_tile :BaseTile = _spawned_tiles[data.id]
	
	# remove old
	_spawned_tile.queue_free()
	_spawned_tiles.erase(data.id)
	
	# spawn new
	var tile :BaseTile = _spawn_tile(data)
	tile.visible = true
	_spawned_tiles[data.id] = tile
	
	# update to _tile_map_data
	if _is_editor:
		var pos = 0
		for i in _tile_map_data.tiles:
			var x :TileMapData = i
			if x.id == data.id:
				_tile_map_data.tiles[pos] = data
				return
				
			pos += 1
			
func update_navigation_tile(at :Vector2, enable :bool, _is_air :bool = false):
	var _nav :AStar2D = _air_navigation if _is_air else _navigation
	_enable_nav_tile(_nav, at, enable)
	
	if _is_editor:
		for i in _tile_map_data.navigations:
			if i.id == at:
				i.enable = enable
				return
				
func get_closes_tile_instance(from :Vector3) -> BaseTile:
	var tiles :Array = get_tiles()
	if tiles.empty():
		return null
		
	var current :BaseTile = tiles[0]
	for i in tiles:
		if i == current:
			continue
			
		var dist_1 = current.translation.distance_squared_to(from)
		var dist_2 = i.translation.distance_squared_to(from)
		if dist_2 < dist_1:
			current = i
			
	return current # BaseTile
	
func get_closes_tile(from :Vector3) -> TileMapData:
	var tiles :Array = _tile_map_data.tiles
	if tiles.empty():
		return null
		
	var current :TileMapData = tiles[0]
	for i in tiles:
		if i == current:
			continue
			
		var dist_1 = current.pos.distance_squared_to(from)
		var dist_2 = i.pos.distance_squared_to(from)
		if dist_2 < dist_1:
			current = i
			
	return current # BaseTile
	
# param blocked_ids is usefull for 
# seting temporary blocked tile
# like ally unit in the way
func get_navigation(start :Vector2, end :Vector2, blocked_ids :Array = [], _is_air :bool = false) -> PoolVector2Array:
	var _blocked_nav_ids :Array = []
	for id in blocked_ids:
		_blocked_nav_ids.append(_tile_map_data.tile_ids[id])
		
	var _nav :AStar2D = _air_navigation if _is_air else _navigation
	return _get_navigation(_nav, _tile_map_data.tile_ids[start],_tile_map_data.tile_ids[end], _blocked_nav_ids) # [ Vector2 ]
	
func _spawn_tiles():
	for i in _tile_map_data.tiles:
		var data :TileMapData = i
		_spawned_tiles[data.id] = _spawn_tile(data)
	
func _spawn_tile(data :TileMapData) -> BaseTile:
	# TODO
	# overide this function to spawn tiles
	# then return spawn tile instance
	return null
	
func _spawn_objects():
	for i in _tile_map_data.objects:
		var data :MapObjectData = i
		_spawn_object(data)
	
func _spawn_object(data :MapObjectData):
	# TODO
	# overide this function to spawn object
	pass
	
func _get_navigation(_nav :AStar2D, start :int, end :int, _blocked_nav_ids :Array) -> PoolVector2Array:
	var paths :PoolVector2Array = PoolVector2Array([])
	if not _nav.has_point(start):
		return paths
		
	if not _nav.has_point(end):
		return paths
		
	var _restored_disabled_point :Array = []
	
	# blocked tile
	for navigation_id in _blocked_nav_ids:
		var has_point :bool = _nav.has_point(navigation_id)
		var is_already_disabled :bool = _nav.is_point_disabled(navigation_id)
		if has_point and not is_already_disabled:
			_restored_disabled_point.append(navigation_id)
			_nav.set_point_disabled(navigation_id, true)
		
	# get path with blocked tiles
	paths = _nav.get_point_path(start, end)
	
	# open blocked tile
	for navigation_id in _restored_disabled_point:
		_nav.set_point_disabled(navigation_id, false)
			
	return paths
	
func _update_navigations():
	var navigation_map :Array = _tile_map_data.navigations
	_add_point(_navigation, navigation_map)
	_connect_point(_navigation,navigation_map)
	_set_obstacle(_navigation,navigation_map)
	
	_add_point(_air_navigation, navigation_map)
	_connect_point(_air_navigation, navigation_map)
	_set_obstacle(_air_navigation, navigation_map)
	
func _add_point(nav :AStar2D, data :Array):
	for i in data:
		var x :NavigationData = i
		nav.add_point(x.navigation_id, x.id)
		
func _connect_point(nav :AStar2D, data :Array):
	for i in data:
		var x :NavigationData = i
		for next_id in x.neighbors:
			nav.connect_points(x.navigation_id, next_id, false)
		
func _set_obstacle(nav :AStar2D, data :Array):
	for i in data:
		var x :NavigationData = i
		_enable_nav_tile(nav, x.id, x.enable)
	
func _enable_nav_tile(nav :AStar2D, id : Vector2, enable :bool = true):
	if _tile_map_data == null:
		return
		
	var navigation_id: int = _tile_map_data.tile_ids[id]
	if nav.has_point(navigation_id):
		nav.set_point_disabled(navigation_id, !enable)
		
func _ids_to_tile_nodes(ids :Array) -> Array:
	var datas = []
	for i in ids:
		datas.append(get_tile(i))
	return datas
	
func _clean():
	_air_navigation.clear()
	_navigation.clear()
	
	for key in _spawned_tiles.keys():
		var tile :BaseTile = _spawned_tiles[key]
		tile.queue_free()
		
	_spawned_tiles.clear()
