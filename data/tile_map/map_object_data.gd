extends BaseData
class_name MapObjectData

var id :Vector2
var pos :Vector3
var scene :Resource

# categorize if this object block tile navigation
# or not, for example : grass & tree
var is_blocking :bool

func from_dictionary(_data : Dictionary):
	id = _data["id"]
	pos = _data["pos"]
	scene = load(_data["scene"])
	is_blocking = _data["is_blocking"]
	
func to_dictionary() -> Dictionary :
	var _data :Dictionary = {}
	_data["id"] = id
	_data["pos"] = pos
	_data["scene"] = scene.resource_path
	_data["is_blocking"] = is_blocking
	return _data
