extends Node

onready var ui = $ui
onready var movable_camera = $movable_camera

func _ready():
	ui.movable_camera_ui.target = movable_camera
