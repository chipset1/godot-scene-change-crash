class_name ChargeComponent
extends RefCounted

var _player : CharacterBody2D
var _speed : float

func _init(player : CharacterBody2D, speed : float) -> void:
	print("in charge component")
	_player = player
	_speed = speed
	
func get_velocity(character_body : CharacterBody2D):
	var target = _player.global_position - character_body.global_position
	target = target.normalized()
	target = target * _speed
	return target
