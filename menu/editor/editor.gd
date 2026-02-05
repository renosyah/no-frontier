extends Node

onready var ui = $ui
onready var movable_camera = $movable_camera
onready var grand_map = $grand_map
onready var clickable_floor = $clickable_floor

func _ready():
	ui.movable_camera_ui.target = movable_camera
	
	get_tree().set_quit_on_go_back(false)
	get_tree().set_auto_accept_quit(false)
	
	# example only
	var data = TileMapUtils.generate_basic_tile_map(2)
	grand_map.generate_from_data(data)
	
func _process(delta):
	clickable_floor.translation = movable_camera.translation * Vector3(1,0,1)

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

func _on_clickable_floor_on_floor_clicked(pos):
	# example only
	var tile = grand_map.get_closes_tile_instance(pos)
	print("tile clicked : %s" % tile.translation)

func _on_ui_on_update_tile(data :TileMapData):
	var old_tile = grand_map.get_closes_tile(data.pos)
	data.id = old_tile.id
	data.pos = old_tile.pos
	grand_map.update_spawned_tile(data)
