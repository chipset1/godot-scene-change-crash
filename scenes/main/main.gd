extends Node2D

@onready var player : CharacterBody2D = $Player
var _full_screen_size = Vector2(1920, 1080)
var _windowed_size := Vector2(_full_screen_size.x*0.6, _full_screen_size.y*0.6)
@onready var _current_level = $Levels/StartLevel

## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.change_level.connect(_main_change_level)
	_set_player_start_position("StartLevel")
	player.disable_camera_follow()

func _unhandled_input(_event: InputEvent) -> void:
	# todo should I be doing this instead of using the _event
	if Input.is_action_just_pressed("fullscreen"):
		var mode := DisplayServer.window_get_mode()
		if  mode != DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode( DisplayServer.WINDOW_MODE_WINDOWED)
			get_viewport().get_window().size = _windowed_size

func _main_change_level(level_path : String):
	var s = "res://scenes/levels/" + level_path + ".tscn"
	_goto_scene(s)

func _set_player_start_position(scene_name):
	print(scene_name)
	var player_start_position_node = _current_level.get_node(scene_name+"Enter");
	if(player_start_position_node != null):
		player.transform.origin = player_start_position_node.transform.origin


func _goto_scene(path):
	# It is now safe to remove the current scene.
	var previous_name = _current_level.name
	_current_level.free()
	# Load the new scene.
	var s = ResourceLoader.load(path)
	# Instance the new scene.
	_current_level = s.instantiate()
	_set_player_start_position(previous_name)
	# Add it to the active scene, as child of root.
	$Levels.add_child(_current_level)
