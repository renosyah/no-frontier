extends Control

const edit_map_button = preload("res://menu/editor_menu/button/edit_map_button.tscn")

onready var grid_container = $CanvasLayer/Control/VBoxContainer/ScrollContainer/GridContainer
onready var loaded_maps = []
onready var loaded_maps_edit_buttons = []

func _ready():
	get_tree().set_quit_on_go_back(false)
	get_tree().set_auto_accept_quit(false)
	
	_load_maps()
	_show_maps()
	
func _load_maps():
	# load maps from disk
	# added it to array of loaded_maps
	pass
	
func _show_maps():
	for i in loaded_maps_edit_buttons:
		grid_container.remove_child(i)
	loaded_maps_edit_buttons.clear()
	
	for i in loaded_maps:
		var loaded_maps_edit_button = edit_map_button.instance()
		loaded_maps_edit_button.connect("pressed", self, "_loaded_maps_edit_button_pressed", [i])
		grid_container.add_child(loaded_maps_edit_button)
		grid_container.move_child(loaded_maps_edit_button, 0)
		loaded_maps_edit_buttons.append(loaded_maps_edit_button)
	
func _notification(what):
	match what:
		MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
			on_back_pressed()
			return
			
		MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST: 
			on_back_pressed()
			return
			
func on_back_pressed():
	get_tree().change_scene("res://menu/main/main.tscn")

func _on_back_pressed():
	on_back_pressed()
	
func _loaded_maps_edit_button_pressed(map):
	# set map to EditorGlobal map data
	get_tree().change_scene("res://menu/editor/editor.tscn")
	
func _on_add_map_button_pressed():
	Global.empty_map_data()
	get_tree().change_scene("res://menu/editor/editor.tscn")
