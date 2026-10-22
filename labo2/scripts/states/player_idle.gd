class_name PlayerIdle
extends BaseState

@export var player : Player
var anim_player : AnimationPlayer

func enter():
	anim_player = player.get_node("AnimationPlayer")
	anim_player.play("idle")
	player.velocity.x = 0

func _input(event: InputEvent) -> void:
	handle_inputs(event)

func handle_inputs(input_event: InputEvent) -> void :
	var dir : float = Input.get_axis("left", "right")

	if (Input.is_action_just_pressed("attack")):
		Transitioned.emit(self, "PlayerAttack")
	elif Input.is_action_just_pressed("up") and player.is_on_floor():
		Transitioned.emit(self, "PlayerJump")


func update(delta: float) -> void:
	if not anim_player :
		anim_player = player.animation_player

func physics_update(delta: float) -> void:
	if not anim_player : return

	if (not player.is_on_floor() and player.velocity.y >= 0):
		Transitioned.emit(self, "PlayerFall")
	# si maintien touche deplacement apres attack, sinon bloque
	elif (Input.get_axis("left", "right") != 0):
		Transitioned.emit(self, "PlayerRun")
		
func exit() -> void:
	pass
