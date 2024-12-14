extends Node2D

@onready var player : CharacterBody2D = $Player
@onready var _camera : Camera2D = $Camera2D
var _full_screen_size = Vector2(1920, 1080)
var _windowed_size := Vector2(_full_screen_size.x*0.6, _full_screen_size.y*0.6)
@onready var _current_level = $Levels/StartLevel


## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.change_level.connect(_main_change_level)
	_set_player_start_position("StartLevel")
	_should_update_camera()

func _unhandled_input(_event: InputEvent) -> void:
	# todo should I be doing this instead of using the _event
	if Input.is_action_just_pressed("fullscreen"):
		var mode := DisplayServer.window_get_mode()
		if  mode != DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode( DisplayServer.WINDOW_MODE_WINDOWED)
			get_viewport().get_window().size = _windowed_size

func _set_camera_center():
	_camera.set_anchor_mode(Camera2D.ANCHOR_MODE_DRAG_CENTER)

func _set_camera_top_left():
	_camera.global_position = Vector2(0, 0)
	_camera.set_anchor_mode(Camera2D.ANCHOR_MODE_FIXED_TOP_LEFT)

func _main_change_level(level_path : String):
	var path = "res://scenes/levels/" + level_path + ".tscn"
		# It is now safe to remove the current scene.
	var previous_name = _current_level.name
	_current_level.free()
	# Load the new scene.
	var l = load(path)
	# Instance the new scene.
	_current_level = l.instantiate()
	_set_player_start_position(previous_name)
	_should_update_camera()
	# Add it to the active scene, as child of root.
	$Levels.add_child(_current_level)


func _set_player_start_position(level_name):
	assert(_current_level.has_node(level_name+"Enter"))
	var player_start_position_node = _current_level.get_node(level_name+"Enter");
	if(player_start_position_node != null):
		player.transform.origin = player_start_position_node.transform.origin
	else:
		push_warning("could not set player position on level change: " + level_name) 

func _should_update_camera():
	if _current_level.has_node("StaticCamera"):
		_set_camera_top_left()
		player.disable_camera_follow()
	else:
		_set_camera_center()
		player.enable_camera_follow()
