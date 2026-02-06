extends BaseData
class_name GrandMapFileManifest

var map_name :String
var map_size :Vector2
var map_image_file_path :String
var map_file_path :String
var mission_file_path :String
var battle_map_files :Dictionary = {} # { Vector2 : String }

func from_dictionary(_data : Dictionary):
	map_name = _data["map_name"]
	map_size = _data["map_size"]
	map_image_file_path = _data["map_image_file_path"]
	map_file_path = _data["map_file_path"]
	mission_file_path = _data["mission_file_path"]
	
	battle_map_files = {}
	for key in _data["battle_map_files"].keys():
		battle_map_files[key] = _data["battle_map_files"][key]

func to_dictionary() -> Dictionary :
	var _data :Dictionary = {}
	_data["map_name"] = map_name
	_data["map_size"] = map_size
	_data["map_image_file_path"] = map_image_file_path
	_data["map_file_path"] = map_file_path
	_data["mission_file_path"] = mission_file_path
	
	_data["battle_map_files"] = {}
	for key in battle_map_files.keys():
		_data["battle_map_files"][key] = battle_map_files[key]
		
	return _data
