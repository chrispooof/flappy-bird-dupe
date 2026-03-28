extends Node2D

const SPEED = 200.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$GrassBody.get_node('HitBox').body_entered.connect(_on_hit_ground)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= SPEED * delta

	if position.x < -1500:
		queue_free()

func _on_hit_ground(body):
	if body.name == "Player":
		get_tree().reload_current_scene()
