extends Node2D

@onready var pipe_scene = preload("res://scenes/pipe.tscn")
@onready var pipes = $Pipes
@onready var grass_scene = preload("res://scenes/grass.tscn")
@onready var grass = $Grass
@onready var cloud_scene = preload("res://scenes/cloud.tscn")
@onready var clouds = $Clouds


var spawn_timer = 0.0
var score = 0

func _ready():
	spawn_grass()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	spawn_timer += delta
	
	if spawn_timer > 1.0:
		spawn_pipe()
		spawn_grass()
		spawn_cloud()
		spawn_timer = 0.0

func spawn_pipe():
	var pipe = pipe_scene.instantiate()
	
	pipe.position.x = 600
	pipe.position.y = randf_range(100, 200)
	
	pipes.add_child(pipe)

func spawn_grass():
	var grass_instance = grass_scene.instantiate()
	
	grass_instance.position.x = 0
	grass_instance.position.y = 290
	
	grass.add_child(grass_instance)

func spawn_cloud():
	var cloud_instance = cloud_scene.instantiate()
	
	cloud_instance.position.x = randf_range(300, 600)
	cloud_instance.position.y = randf_range(50, 150)
	
	clouds.add_child(cloud_instance)

func add_score():
	score += 1
	$UI/Label.text = str(score)
