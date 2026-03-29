extends Node2D

enum GameState {
	START,
	PLAYING,
	GAME_OVER
}

@onready var pipe_scene = preload("res://scenes/pipe.tscn")
@onready var pipes = $Pipes
@onready var cloud_scene = preload("res://scenes/cloud.tscn")
@onready var clouds = $Clouds
@onready var start_screen = $UI/StartScreen
@onready var game_over_screen = $UI/GameOverScreen
@onready var score_label = $UI/Label
@onready var player = $Player

var current_state = GameState.START
var spawn_timer = 0.0
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_state(current_state)
	score_label.text = str(score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match current_state:
		GameState.START:
			if Input.is_action_just_pressed("ui_accept"):
				start_game()

		GameState.PLAYING:
			handle_spawning(delta)
		GameState.GAME_OVER:
			start_screen.visible = false
			game_over_screen.visible = true

func handle_spawning(delta):
	spawn_timer += delta
	
	if spawn_timer > 1.0:
		spawn_pipe()
		spawn_cloud()
		spawn_timer = 0.0

func start_game():
	set_state(GameState.PLAYING)

func game_over():
	set_state(GameState.GAME_OVER)

func restart_game():
	get_tree().reload_current_scene()

func set_state(new_state: GameState):
	current_state = new_state

	start_screen.visible = (current_state == GameState.START)
	game_over_screen.visible = (current_state == GameState.GAME_OVER)
	score_label.visible = (current_state == GameState.PLAYING)

	if new_state == GameState.START:
		reset_game()

func reset_game():
	for child in pipes.get_children():
		child.queue_free()
	for child in clouds.get_children():
		child.queue_free()

	score = 0
	score_label.text = str(score)
	spawn_timer = 0.0
	player.position = Vector2(100, 160)
	player.velocity = Vector2.ZERO

func spawn_pipe():
	var pipe = pipe_scene.instantiate()
	
	pipe.position.x = 600
	pipe.position.y = randf_range(100, 200)
	
	pipes.add_child(pipe)

func spawn_cloud():
	var cloud_instance = cloud_scene.instantiate()
	
	cloud_instance.position.x = randf_range(500, 600)
	cloud_instance.position.y = randf_range(50, 150)
	
	clouds.add_child(cloud_instance)

func add_score():
	score += 1
	score_label.text = str(score)
