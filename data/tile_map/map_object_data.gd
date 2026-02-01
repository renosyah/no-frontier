extends BaseData
class_name MapObjectData

var pos :Vector3
var scene :Resource

func from_dictionary(_data : Dictionary):
	pos = _data["pos"]
	scene = load(_data["scene"])
	
func to_dictionary() -> Dictionary :
	var data :Dictionary = {}
	data["pos"] = pos
	data["scene"] = scene.resource_path
	return data
