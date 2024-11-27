extends Node

var _enemy = preload("res://scenes/game_objects/enemy/enemy.tscn")
@onready var _player : CharacterBody2D = get_tree().get_first_node_in_group("player")

func _ready() -> void:
	_create_enemy()
	
func _create_enemy():
	var e : CharacterBody2D = _enemy.instantiate();
	var s = Sprite2D.new()
	var m = ChargeComponent.new(_player, 100.0)
	e.get_node("CollisionShape2D").shape = RectangleShape2D.new()
	e.move_component = m
	s.texture = load("res://assets/player/walk1.png")
	e.add_child(s)
	e.global_position = Vector2(500, 500)
	add_child(e)
	
