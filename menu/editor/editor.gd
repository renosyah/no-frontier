extends Node

onready var ui = $ui
onready var movable_camera = $movable_camera
onready var grand_map = $grand_map
onready var clickable_floor = $clickable_floor
onready var selection = $selection

onready var allow_nav = preload("res://assets/tile_highlight/allow_nav_material.tres")
onready var blocked_nav = preload("res://assets/tile_highlight/blocked_nav_material.tres")
onready var nav_highlight_holder = {}

onready var grand_map_data = EditorGlobal.grand_map_data
onready var grand_map_mission_data = EditorGlobal.grand_map_mission_data

func _ready():
	ui.movable_camera_ui.target = movable_camera
	
	get_tree().set_quit_on_go_back(false)
	get_tree().set_auto_accept_quit(false)
	
	grand_map.generate_from_data(grand_map_data, true)
	
func _process(_delta):
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

func show_selection(at :Vector3,show :bool):
	selection.visible = show
	selection.translation = at

func _on_clickable_floor_on_floor_clicked(_pos):
	pass

func _on_ui_on_update_tile(data :TileMapData):
	var old_tile = grand_map.get_closes_tile(data.pos)
	data.id = old_tile.id
	data.pos = old_tile.pos
	grand_map.update_spawned_tile(data)
	show_selection(old_tile.pos, false)
	
	grand_map.update_navigation_tile(data.id, data.tile_type == 1)
	
	if data.tile_type == 2:
		grand_map.remove_spawned_object(data.id)

func _on_ui_on_add_object(data :MapObjectData):
	show_selection(Vector3.ZERO, false)
	var tile = grand_map.get_closes_tile(data.pos)
	if tile.tile_type == 2:
		return
		
	data.id = tile.id
	data.pos = tile.pos
	grand_map.update_spawned_object(data)

func _on_ui_on_add_point(data :MapObjectData):
	if grand_map_mission_data.points.size() > 3:
		show_selection(Vector3.ZERO, false)
		return
		
	_on_ui_on_add_object(data)
	grand_map_mission_data.points.append(data.id)
	
func _on_ui_on_add_base(data :MapObjectData):
	if grand_map_mission_data.bases.size() > 1:
		show_selection(Vector3.ZERO, false)
		return
		
	_on_ui_on_add_object(data)
	grand_map_mission_data.bases.append(data.id)
	
func _on_ui_on_remove_object(pos):
	show_selection(Vector3.ZERO, false)
	var tile = grand_map.get_closes_tile(pos)
	grand_map.remove_spawned_object(tile.id)
	
	if grand_map_mission_data.bases.has(tile.id):
		grand_map_mission_data.bases.erase(tile.id)
		
	if grand_map_mission_data.points.has(tile.id):
		grand_map_mission_data.points.erase(tile.id)
		
func _on_ui_on_card_dragging(pos):
	var tile = grand_map.get_closes_tile(pos)
	show_selection(tile.pos, true)

func _on_ui_on_cancel():
	show_selection(Vector3.ZERO, false)

func _on_grand_map_on_navigation_updated(id :Vector2, data :NavigationData):
	nav_highlight_holder[id].set_surface_material(0, allow_nav if data.enable else blocked_nav)
	
func _on_grand_map_on_map_ready():
	for i in grand_map_data.navigations:
		var nav :NavigationData = i
		var nav_highlight = preload("res://assets/tile_highlight/nav_highlight.tscn").instance()
		add_child(nav_highlight)
		nav_highlight.set_text_label("%s\n%s" % [nav.id, nav.navigation_id])
		nav_highlight.set_surface_material(0, allow_nav if nav.enable else blocked_nav)
		nav_highlight.translation = grand_map.get_tile(nav.id).translation
		nav_highlight.visible = false
		nav_highlight_holder[nav.id] = nav_highlight
		
func _on_ui_on_toggle_nav(show):
	for i in nav_highlight_holder.values():
		i.visible = show

func _on_ui_on_zoom_tile(pos):
	show_selection(Vector3.ZERO, false)
	var tile = grand_map.get_closes_tile(pos)
	print("zoom in to : %s" % tile.to_dictionary())
