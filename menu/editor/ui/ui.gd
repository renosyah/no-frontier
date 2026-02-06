extends Control

signal on_card_dragging
signal on_update_tile
signal on_add_object
signal on_add_base
signal on_add_point
signal on_remove_object
signal on_cancel
signal on_toggle_nav
signal on_zoom_tile

const forests = [
	preload("res://scenes/tile_objects/grand/forest_1.tscn"),
	preload("res://scenes/tile_objects/grand/forest_2.tscn")
]

onready var movable_camera_ui = $CanvasLayer/movable_camera_ui
onready var tile_options = [$CanvasLayer/Control/VBoxContainer/HBoxContainer2/VBoxContainer/ground_tile, $CanvasLayer/Control/VBoxContainer/HBoxContainer2/VBoxContainer/water_tile, $CanvasLayer/Control/VBoxContainer/HBoxContainer2/VBoxContainer/object_forest]
onready var map_options = [$CanvasLayer/Control/VBoxContainer/HBoxContainer2/VBoxContainer2/faction_base, $CanvasLayer/Control/VBoxContainer/HBoxContainer2/VBoxContainer2/capture_point]
onready var cards = [$CanvasLayer/Control/VBoxContainer/HBoxContainer3/ground_tile_card, $CanvasLayer/Control/VBoxContainer/HBoxContainer3/water_tile_card, $CanvasLayer/Control/VBoxContainer/HBoxContainer3/object_forest_card, $CanvasLayer/Control/VBoxContainer/HBoxContainer3/object_base_card, $CanvasLayer/Control/VBoxContainer/HBoxContainer3/object_capture_card]
onready var floating_image_card = $CanvasLayer/floating_image_card
onready var show_nav = $CanvasLayer/Control/VBoxContainer/HBoxContainer2/VBoxContainer2/show_nav
onready var remove_object_card = $CanvasLayer/Control/VBoxContainer/HBoxContainer2/VBoxContainer2/object_remove_card
onready var zoom_in_card = $CanvasLayer/Control/VBoxContainer/HBoxContainer2/VBoxContainer/zoom_in_card

func _ready():
	for i in tile_options + map_options:
		var btn : Button = i
		btn.connect("pressed", self, "_on_toggle_button_pressed", [btn])
		
	for i in cards + [remove_object_card, zoom_in_card]:
		var card :DragableCard = i
		var icon :StreamTexture = (card.get_child(1) as TextureRect).texture
		card.connect("on_grab", self, "_on_card_grab", [icon])
		card.connect("on_draging", self, "_on_card_grab_draging")
		card.connect("on_release", self, "_on_card_grab_release")
		card.connect("on_cancel", self, "_on_card_grab_cancel")
	
	hide_cards()
	
func on_card_release(id :int, at :Vector2):
	match (id):
		0:
			update_tile_ground(at)
		1:
			update_tile_water(at)
		2:
			add_object_forest(at)
		3:
			add_object_base(at)
		4:
			add_object_capture(at)
		5:
			remove_object(at)
		6:
			zoom_in_tile(at)
			
func update_tile_ground(at :Vector2):
	var pos3 = Utils.screen_to_world(get_viewport().get_camera(), at, false, 4)
	var data :TileMapData = TileMapData.new()
	data.tile_type = 1
	data.id = Vector2.ZERO
	data.pos = pos3
	
	emit_signal("on_update_tile", data)
	
func update_tile_water(at :Vector2):
	var pos3 = Utils.screen_to_world(get_viewport().get_camera(), at, false, 4)
	var data :TileMapData = TileMapData.new()
	data.tile_type = 2
	data.id = Vector2.ZERO
	data.pos = pos3
	
	emit_signal("on_update_tile", data)
	
func add_object_forest(at :Vector2):
	var pos3 = Utils.screen_to_world(get_viewport().get_camera(), at, false, 4)
	var data :MapObjectData = MapObjectData.new()
	data.id = Vector2.ZERO
	data.pos = pos3
	data.scene = forests[randi() % forests.size()]
	data.is_blocking = false
	
	emit_signal("on_add_object", data)
	
func add_object_base(at :Vector2):
	var pos3 = Utils.screen_to_world(get_viewport().get_camera(), at, false, 4)
	var data :MapObjectData = MapObjectData.new()
	data.id = Vector2.ZERO
	data.pos = pos3
	data.scene = preload("res://scenes/tile_objects/grand/faction_base.tscn")
	data.is_blocking = false
	
	emit_signal("on_add_base", data)
	
func add_object_capture(at :Vector2):
	var pos3 = Utils.screen_to_world(get_viewport().get_camera(), at, false, 4)
	var data :MapObjectData = MapObjectData.new()
	data.id = Vector2.ZERO
	data.pos = pos3
	data.scene = preload("res://scenes/tile_objects/grand/flag_pole.tscn")
	data.is_blocking = false
	
	emit_signal("on_add_point", data)
	
func remove_object(at :Vector2):
	var pos3 = Utils.screen_to_world(get_viewport().get_camera(), at, false, 4)
	emit_signal("on_remove_object", pos3)
	
func zoom_in_tile(at :Vector2):
	var pos3 = Utils.screen_to_world(get_viewport().get_camera(), at, false, 4)
	emit_signal("on_zoom_tile", pos3)
	
func untoggle_buttons(exc):
	for i in tile_options + map_options:
		i.set_toggle_button(false)
		
	exc.set_toggle_button(true)
	
func hide_cards(exc = null):
	for i in cards:
		i.visible = (exc == i)
	
func _on_toggle_button_pressed(btn):
	untoggle_buttons(btn)
	hide_cards(cards[btn.id])
	
func _on_card_grab(_card :DragableCard, pos :Vector2, icon :StreamTexture):
	var pos2 = pos # - floating_image_card.rect_pivot_offset
	floating_image_card.texture = icon
	floating_image_card.visible = true
	floating_image_card.rect_position = pos2
	
func _on_card_grab_draging(_card :DragableCard, pos :Vector2):
	var pos2 = pos # - floating_image_card.rect_pivot_offset
	floating_image_card.rect_position = pos2
	var pos3 = Utils.screen_to_world(get_viewport().get_camera(), pos2, false, 4)
	emit_signal("on_card_dragging", pos3)
	
func _on_card_grab_release(card :DragableCard, pos :Vector2):
	floating_image_card.visible = false
	var pos2 = pos # - floating_image_card.rect_pivot_offset
	on_card_release(card.id, pos2)
	
func _on_card_grab_cancel(_card :DragableCard):
	floating_image_card.visible = false
	emit_signal("on_cancel")

func _on_show_nav_pressed():
	emit_signal("on_toggle_nav", not show_nav.is_toggle)
