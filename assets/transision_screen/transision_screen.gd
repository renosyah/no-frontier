extends CanvasLayer

onready var _animation_player = $AnimationPlayer
onready var _texture_rect = $transision_screen/TextureRect

const bgs = [
	preload("res://assets/background/editor.png"),
	preload("res://assets/background/main_menu.png"),
	preload("res://assets/background/pre_match.png")
]

func change_scene(scene :String, use :bool = false, bg_idx :int = 1):
	if use:
		_texture_rect.texture = bgs[bg_idx]
		_animation_player.play("show")
		
		yield(_animation_player,"animation_finished")
		yield(get_tree().create_timer(1), "timeout")
	
	get_tree().change_scene(scene)
	
func hide_transition():
	_animation_player.play_backwards("show")
