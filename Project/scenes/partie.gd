extends Node2D

@export var timer_label: Label
@export var player_hand: Node2D
@export var droping_area: Area2D
@export var hand_anim: AnimationPlayer

var scene = "res://scenes/test_scene.tscn"


var nbr_joueur
var gametime_s
var gametime_m

var is_loaded

#COMMENTAIRE D'EN-TÊTE
#... ON FAIT PAS GRAND CHOSE ICI, A PART DU DEBUG, POUR LE MOMENT...


# Called when the node enters the scene tree for the first time.
func _ready():
	if is_loaded:
		#ON LOAD LES VARIABLE A PARTIR DU JSON
		init_vars(nbr_joueur,gametime_m, gametime_s)
		pass
	else:
		gametime_m = 0
		gametime_s = 0
		is_loaded = true
		pass
	pass # Replace with function body.

func init_vars(nbrj,gtm,gts):
	pass

func next_turn():
	player_hand.next_turn_phase()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("reload")):
		get_tree().change_scene_to_file(scene) #ça nous permet de changer la scene actuelle en la scene de la variable du même nom, vu que c'est la même on reload simplement.
	pass

func _physics_process(delta):
	pass


func _on_timer_timeout():
	gametime_s += 1
	if gametime_s == 60:
		gametime_s = 0
		gametime_m += 1
	
	if gametime_m<10:
		timer_label.text = "0" + str(gametime_m) + ":"
	else:
		timer_label.text = str(gametime_m) + ":"
	
	if gametime_s < 10:
		timer_label.text += "0" + str(gametime_s)
	else:
		timer_label.text += str(gametime_s)
	pass # Replace with function body.
