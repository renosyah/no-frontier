extends BaseData
class_name TileMapFileData

var tile_ids :Dictionary # { Vector2: int }
var tiles : Array # [ TileMapData ]

var objects : Array # [ MapObjectData ]
var navigations : Array # [ NavigationData ]

func from_dictionary(_data : Dictionary):
	tile_ids = {} # { Vector2: int }
	for key in _data["tile_ids"].keys():
		tile_ids[key] = _data["tile_ids"][key]
		
	tiles = [] # [ TileMapData ]
	for i in _data["tiles"]:
		var x :TileMapData = TileMapData.new()
		x.from_dictionary(i)
		tiles.append(x)
		
func to_dictionary() -> Dictionary :
	var _data :Dictionary = {}
	_data["tile_ids"] = {} # { Vector2: int }
	for key in tile_ids.keys():
		_data["tile_ids"][key] = tile_ids[key]
		
	_data["tiles"] = [] # [ TileMapData ]
	for i in tiles:
		var x :TileMapData = i
		_data["tiles"].append(x.to_dictionary())
		
	return _data
