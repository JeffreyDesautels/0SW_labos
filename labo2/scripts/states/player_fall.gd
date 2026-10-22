class_name PlayerFall
extends BaseState

@export var player : Player
var anim_player : AnimationPlayer

var dir : float = 0.0

func enter() -> void:
	if not anim_player :
		anim_player = player.animation_player
	anim_player.play("fall")
	

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

	player.velocity.x = dir * player.SPEED
	
	if (player.is_on_floor()):
		if (dir != 0):
			Transitioned.emit(self, "PlayerRun")
		else:
			Transitioned.emit(self, "PlayerIdle")

func exit() -> void:
	pass
