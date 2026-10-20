class_name Player
extends Node2D

@export var speed : float = 60
@onready var detecteur_mur : RayCast2D = $DetecteurMur
@onready var detecteur_plancher : RayCast2D = $DetecteurPlancher
@onready var detecteur_joueur : RayCast2D = $DetecteurJoueur
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
var player : Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#animated_sprite.rotate(10 * delta);
	handle_player()
	
	if not detecteur_plancher.is_colliding():
		inverser_tout()
	
	if detecteur_mur.is_colliding():
		inverser_tout()
		
	position.x += speed * delta
	pass
	

func inverser_tout() -> void:
	speed = -speed
	animated_sprite.flip_h = !animated_sprite.flip_h
	detecteur_mur.target_position.x *= -1
	detecteur_plancher.target_position.x *= -1
	detecteur_joueur.target_position.x *= -1
	
func set_player(player : Player) -> void:
	self.player = player

func handle_player() -> void:
	if player == null:
		return

	if (detecteur_joueur.is_colliding()):
		# On récupère le noeud avec lequel le rayon entre en collision
		var collider = detecteur_joueur.get_collider()

		if collider == player:
			# Player détecté
			# On change d'état
			print("faire qqchose")
