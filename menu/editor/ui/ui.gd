extends Control

signal screen_pressed

onready var movable_camera_ui = $CanvasLayer/Control/movable_camera_ui

func _on_clickable_screen_on_screen_clicked(pos):
	var pos3 = Utils.screen_to_world(get_viewport().get_camera(), pos, false, 4)
	print("on screen clicked %s and ray intersect : %s" % [pos, pos3])
	$CanvasLayer/Sprite.position = pos
	emit_signal("screen_pressed", pos3)
