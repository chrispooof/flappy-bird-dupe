extends Node2D

const SPEED = 200.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HitBox.body_entered.connect(_on_hit_ground)

func _on_hit_ground(body):
	if body.name == "Player":
		get_parent().game_over()
