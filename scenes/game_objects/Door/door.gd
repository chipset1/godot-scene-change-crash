extends Area2D

@export var level_name : String
var _has_body_entered := false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(level_name != "")
	body_entered.connect(func(body): _has_body_entered = true )
	body_exited.connect(func(body): _has_body_entered = false )


func _process(_delta: float) -> void:
	if _has_body_entered and Input.is_action_just_pressed("interact"):
		print("change level")
		SignalBus.change_level.emit(level_name)
