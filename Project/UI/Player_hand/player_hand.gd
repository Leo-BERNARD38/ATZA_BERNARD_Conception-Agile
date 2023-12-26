extends Node2D

@export var current_hand: HBoxContainer
@export var DEBUG_TEXT: Label
@export var timer_turn: Timer
@export var scene_partie: Node2D 
@export var ID_joueur: Label

var nom_joueur = []

var took_a_card = false
var active_card_node

var round_counter = 0

var your_turn
@onready var index_who_plays = 0
@onready var base_ID_joueur_pos = ID_joueur.position
#COMMENTAIRE D'EN-TÊTE
#... NODE QUI NOUS SERVIRA A ENVOYER LES INFOS DU JOUEUR A LA SCENE DE LA PARTIE EN COURS

# Called when the node enters the scene tree for the first time.
func _ready():
	nom_joueur = ["Max","Léo","Antoine","Marwan","Ma Bite"]
	ID_joueur.text = nom_joueur[0]
	pass # Replace with function body.

func your_turn_animation(boolean):
	if boolean:
		scene_partie.hand_anim.play("hand_drawn")
	else:
		scene_partie.hand_anim.play_backwards("hand_drawn")
	pass


func next_turn_phase():
	
	timer_turn.start()
	your_turn = false
	your_turn_animation(your_turn)
	#CHANGEMENT DE JOUEUR
	#SI ON A FAIT LE TOUR DE TOUS LES JOUEURS (if joueur == joueur4) ON FAIT endround()
	pass

func endround():
	round_counter += 1
	#on revient au joueur1
	pass

func envoyer_donnees():
	pass


func set_debug_text(a):
	DEBUG_TEXT.text = str(a)

func _process(delta):
	ID_joueur.position = base_ID_joueur_pos
	pass

func _physics_process(delta):
	pass


func _on_switch_time_timeout():
	index_who_plays += 1
	if (index_who_plays >= nom_joueur.size()):
		index_who_plays = 0
	ID_joueur.text = nom_joueur[index_who_plays]
	your_turn = true
	your_turn_animation(your_turn)
	pass # Replace with function body.
