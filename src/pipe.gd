extends Node2D

const SPEED = 200.0


func _ready():
	$ScoreZone.body_entered.connect(_on_score_zone_entered)
	$TopPipe/HitBox.body_entered.connect(_on_hit_pipe)
	$BottomPipe/HitBox.body_entered.connect(_on_hit_pipe)

func _process(delta: float) -> void:
	if get_parent().get_parent().current_state != GameState.State.PLAYING:
		return

	position.x -= SPEED * delta

	if position.x < -100:
		queue_free()

func _on_hit_pipe(body):
	if body.name == "Player":
		get_parent().get_parent().game_over()


func _on_score_zone_entered(body):
	if body.name == "Player":
		get_parent().get_parent().add_score()
