extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -300.0
const GRAVITY = 900.0


func _physics_process(delta):
	if get_parent().current_state == get_parent().GameState.PLAYING:
		velocity.y += GRAVITY * delta

		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_VELOCITY

		move_and_slide()
