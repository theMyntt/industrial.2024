extends CharacterBody2D

const SPEED = 250.0
const JUMP_VELOCITY = -400.0

@onready var animation := $AnimatedSprite2D as AnimatedSprite2D

var isJumping = false

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		isJumping = true
	elif is_on_floor():
		isJumping = false

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if !isJumping:
			animation.play("running")
		animation.scale.x = direction 
	else:
		animation.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if isJumping:
		animation.play("jump")

	move_and_slide()
