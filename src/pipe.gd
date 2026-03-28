extends Node2D

const SPEED = 200.0


func _ready():
	$ScoreZone.body_entered.connect(_on_score_zone_entered)
	$TopPipe.get_node('HitBox').body_entered.connect(_on_hit_pipe)
	$BottomPipe.get_node('HitBox').body_entered.connect(_on_hit_pipe)

func _process(delta: float) -> void:
	position.x -= SPEED * delta

	if position.x < -100:
		queue_free()

func _on_hit_pipe(body):
	if body.name == "Player":
		get_tree().reload_current_scene()


func _on_score_zone_entered(body):
	if body.name == "Player":
		get_parent().get_parent().add_score()
