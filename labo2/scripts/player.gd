extends CharacterBody2D

enum State { STATE_JUMPING, STATE_IDLE, STATE_RUNNING, STATE_FALLING, STATE_ATTACK }
var current_state: State = State.STATE_IDLE

const SPEED = 150.0
const JUMP_VELOCITY = -400.0
var facing_right = true

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

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
		#animation_player.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		#animation_player.play("idle")

	sprite_2d.scale.x = -1.0 if direction < 0 else 1.0
	
	match current_state:
		State.STATE_FALLING:
			if is_on_floor():
				current_state = State.STATE_IDLE
				animation_player.play("idle")
		
		State.STATE_IDLE:
			if direction != 0:
				current_state = State.STATE_RUNNING
				animation_player.play("run")
			elif Input.is_action_just_pressed("ui_up"):
				current_state = State.STATE_JUMPING
				velocity.y = -JUMP_VELOCITY
				animation_player.play("jump")
			elif Input.is_action_just_pressed("attack"):
				current_state = State.STATE_ATTACK
				animation_player.play("attack")
			elif not is_on_floor() and velocity.y > 0:
				current_state = State.STATE_FALLING
				animation_player.play("fall")
		
		State.STATE_JUMPING:
			if velocity.y >= 0:
				current_state = State.STATE_FALLING
				animation_player.play("fall")
			else:
				animation_player.play("jump")
		
		State.STATE_RUNNING:
			if direction > 0:
				facing_right = true
			elif direction < 0:
				facing_right = false
			else:
				current_state = State.STATE_IDLE
				animation_player.play("idle")
			
			if not is_on_floor() and velocity.y > 0:
				current_state = State.STATE_FALLING
				animation_player.play("fall")
			elif Input.is_action_just_pressed("ui_up"):
				current_state = State.STATE_JUMPING
				velocity.y = -JUMP_VELOCITY
				animation_player.play("jump")
			
			if Input.is_action_just_pressed("attack"):
				current_state = State.STATE_ATTACK
				#animation_player.play("attack")
				
				
		State.STATE_ATTACK:
				animation_player.play("attack")
				current_state = State.STATE_IDLE
				#animation_player.play("idle")
				

				
		_:
			animation_player.play("idle")


	move_and_slide()
