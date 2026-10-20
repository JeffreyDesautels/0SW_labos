extends CharacterBody2D

enum State { STATE_JUMPING, STATE_IDLE, STATE_RUNNING, STATE_FALLING }
var current_state: State = State.STATE_IDLE

const SPEED = 150.0
const JUMP_VELOCITY = -400.0
var facing_right = true

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		animated_sprite.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animated_sprite.play("idle")

	animated_sprite.flip_h = direction < 0
	
	match current_state:
		State.STATE_FALLING:
			if is_on_floor():
				current_state = State.STATE_IDLE
				animated_sprite.play("Idle")
		
		State.STATE_IDLE:
			if direction != 0:
				current_state = State.STATE_RUNNING
				animated_sprite.play("Run")
			elif Input.is_action_just_pressed("ui_up"):
				current_state = State.STATE_JUMPING
				velocity.y = -JUMP_VELOCITY
				animated_sprite.play("Jump")
			elif not is_on_floor() and velocity.y > 0:
				current_state = State.STATE_FALLING
				animated_sprite.play("Fall")
		
		State.STATE_JUMPING:
			if velocity.y >= 0:
				current_state = State.STATE_FALLING
				animated_sprite.play("Fall")
			else:
				animated_sprite.play("Jump")
		
		State.STATE_RUNNING:
			if direction > 0:
				facing_right = true
			elif direction < 0:
				facing_right = false
			else:
				current_state = State.STATE_IDLE
				animated_sprite.play("Idle")
			
			if not is_on_floor() and velocity.y > 0:
				current_state = State.STATE_FALLING
				animated_sprite.play("Fall")
			elif Input.is_action_just_pressed("ui_jump"):
				current_state = State.STATE_JUMPING
				velocity.y = -JUMP_VELOCITY
				animated_sprite.play("Jump")
		
		_:
			animated_sprite.play("Idle")


	move_and_slide()
