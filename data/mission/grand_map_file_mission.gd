extends BaseData
class_name GrandMapFileMission

# 1 = us macv base, # 2 nva base
var bases :Dictionary # { Vector2: int }
var points :Array # [ Vector2 ]

func from_dictionary(_data : Dictionary):
	bases = _data["bases"]
	points = _data["points"]

func to_dictionary() -> Dictionary :
	var _data :Dictionary = {}
	_data["bases"] = bases
	_data["points"] = points
	return _data
