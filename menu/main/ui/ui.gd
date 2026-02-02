extends Control

onready var radio_chatters = $radio_chatters
onready var label = $CanvasLayer/Control/VBoxContainer/CenterContainer/Label

func _ready():
	get_tree().set_quit_on_go_back(false)
	get_tree().set_auto_accept_quit(false)
	
	for a in radio_chatters.US_RADIO.keys():
		for k in radio_chatters.US_RADIO[a].keys():
			radio_chatters.play_radio(k, radio_chatters.US_RADIO[a][k])
			
	for a in radio_chatters.VIET_RADIO.keys():
		for k in radio_chatters.VIET_RADIO[a].keys():
			radio_chatters.play_radio(k,radio_chatters.VIET_RADIO[a][k])
	
func _on_radio_chatters_on_radio_played(text):
	label.text = "Radio : %s" % text
	
func _notification(what):
	match what:
		MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
			on_back_pressed()
			return
			
		MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST: 
			on_back_pressed()
			return
			
func on_back_pressed():
	get_tree().quit()
	
func _on_editor_pressed():
	get_tree().change_scene("res://menu/editor_menu/editor_menu.tscn")


func _on_play_pressed():
	get_tree().change_scene("res://menu/lobby/lobby.tscn")



