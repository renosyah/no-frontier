extends Node

export var cam_pos :Vector3
onready var spot_light = $SpotLight

func _process(_delta):
	spot_light.translation.x = cam_pos.x
	spot_light.translation.z = cam_pos.z
