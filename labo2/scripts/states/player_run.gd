class_name PlayerRun
extends BaseState

@export var player : Player
var anim_player : AnimationPlayer

var dir : float = 0.0

func enter() -> void:
	if not anim_player:
		anim_player = player.get_node("AnimationPlayer")
		
	anim_player.play("run")

func _input(event: InputEvent) -> void:
	handle_inputs(event)

func handle_inputs(input_event: InputEvent) -> void :
	dir = Input.get_axis("left", "right")
	
	if (dir == 0):
		Transitioned.emit(self, "PlayerIdle")
	elif (Input.is_action_just_pressed("up") and player.is_on_floor()):
		Transitioned.emit(self, "PlayerJump")
	elif (Input.is_action_just_pressed("attack")):
		Transitioned.emit(self, "PlayerAttack")

func update(delta : float) -> void:
	if not anim_player :
		anim_player = player.get_node("AnimationPlayer")

	if dir != 0:
		player.sprite_2d.flip_h = dir < 0

func physics_update(delta: float) -> void:
	if (player.velocity.x != 0):
		player.facing_right = player.velocity.x > 0
		if not anim_player : return		
		
	player.velocity.x = dir * player.SPEED
	
	if (not player.is_on_floor() and player.velocity.y >= 0):
		Transitioned.emit(self, "PlayerFall")

func exit() -> void:
	pass
