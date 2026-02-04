extends Node

onready var ui = $ui
onready var movable_camera = $movable_camera
onready var grand_map = $grand_map

func _ready():
	ui.movable_camera_ui.target = movable_camera
	
	get_tree().set_quit_on_go_back(false)
	get_tree().set_auto_accept_quit(false)
	
	grand_map.generate_from_data(TileMapUtils.generate_basic_tile_map(2))

func _notification(what):
	match what:
		MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
			on_back_pressed()
			return
			
		MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST: 
			on_back_pressed()
			return
			
func on_back_pressed():
	get_tree().change_scene("res://menu/editor_menu/editor_menu.tscn")

func _on_grand_map_on_map_ready():
	pass
