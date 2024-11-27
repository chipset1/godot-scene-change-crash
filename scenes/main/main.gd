extends Node2D

@onready var player : CharacterBody2D = $Player
var _full_screen_size = Vector2(1920, 1080)
var _windowed_size := Vector2(_full_screen_size.x*0.6, _full_screen_size.y*0.6)

## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.transform.origin = Vector2(1920/2, 1080/2)

func _unhandled_input(_event: InputEvent) -> void:
	# todo should I be doing this instead of using the _event
	if Input.is_action_just_pressed("fullscreen"):
		var mode := DisplayServer.window_get_mode()
		if  mode != DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode( DisplayServer.WINDOW_MODE_WINDOWED)
			get_viewport().get_window().size = _windowed_size
