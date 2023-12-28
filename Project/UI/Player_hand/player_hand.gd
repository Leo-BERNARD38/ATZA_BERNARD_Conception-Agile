extends Node2D

@export var DEBUG_TEXT: Label
@onready var scene_partie = self.get_parent()
@export var ID_joueur: MarginContainer
var num_identifier

@onready var took_a_card = false
var active_card_node

var current_card_count
var round_counter = 0

@onready var index_who_plays = 0
#COMMENTAIRE D'EN-TÊTE
#... NODE QUI NOUS SERVIRA A ENVOYER LES INFOS DU JOUEUR A LA SCENE DE LA PARTIE EN COURS

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func init_names():
	scene_partie.initialisation_pseudos()
	pass

func set_player_name(nom):
	ID_joueur.get_child(0).text = str(nom)

func set_debug_text(a):
	DEBUG_TEXT.text = str(a)

func _process(delta):
	pass

func _physics_process(delta):
	pass
