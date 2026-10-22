class_name PlayerAttack
extends BaseState

@export var player : Player
var anim_player : AnimationPlayer

func enter() -> void:
	if not anim_player :
		anim_player = player.animation_player
		
	player.velocity.x = 0;
	anim_player.play("attack")

func _input(event: InputEvent) -> void:
	handle_inputs(event)

func handle_inputs(input_event: InputEvent) -> void :
	pass

func update(delta : float) -> void:
	if not anim_player :
		anim_player = player.animation_player

func physics_update(delta: float) -> void:
	if not anim_player:
		anim_player = player.animation_player
		
	if not anim_player.is_playing():
		Transitioned.emit(self, "PlayerIdle")
		
func exit() -> void:
	pass
