class_name PlayerJump
extends BaseState

@export var player : Player
var anim_player : AnimationPlayer

var dir : float = 0.0

func enter() -> void:
	if not anim_player :
		anim_player = player.animation_player
	anim_player.play("jump")
	
	player.velocity.y = player.JUMP_VELOCITY

func _input(event: InputEvent) -> void:
	handle_inputs(event)

func handle_inputs(input_event: InputEvent) -> void :
	dir = Input.get_axis("left", "right")
	
	if (Input.is_action_just_pressed("attack")):
		Transitioned.emit(self, "PlayerAttack")

func update(delta : float) -> void:
	if not anim_player :
		anim_player = player.animation_player

	if dir != 0:
		player.sprite_2d.flip_h = dir < 0

func physics_update(delta: float) -> void:
	if (player.velocity.x != 0):
		player.facing_right = player.velocity.x > 0
		if not anim_player : return

	if not anim_player:
		anim_player = player.animation_player
		
	if player.velocity.y >= 0:
		Transitioned.emit(self, "PlayerFall")
		
	player.velocity.x = dir * player.SPEED

func exit() -> void:
	pass
