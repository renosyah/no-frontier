extends BaseTileMap

const land_tile = preload("res://scenes/tiles/grand_tile/land_tile.tscn")
const water_tile = preload("res://scenes/tiles/grand_tile/water_tile.tscn")

# override
func _spawn_tile(data :TileMapData) -> BaseTile:
	var tile_scene = water_tile if data.tile_type == 2 else land_tile
	var tile :BaseTile = tile_scene.instance()
	add_child(tile)
	tile.translation = data.pos
	return tile
