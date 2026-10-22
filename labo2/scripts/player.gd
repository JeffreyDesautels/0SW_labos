extends CharacterBody2D
class_name Player

const SPEED = 150.0
const JUMP_VELOCITY = -400.0

var facing_right = true

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

#func _ready() -> void:
	#animation_player.play("idle")


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()
