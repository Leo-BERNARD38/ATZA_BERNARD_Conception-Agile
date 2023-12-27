extends Area2D

@export var label_debug: Label 
@export var scene_partie: Node2D
var is_hovered
@onready var card_object = null

#COMMENTAIRE D'EN-TÊTE
#... CE SCRIPT DEVRA ENVOYER LES DONNEES DE LA CARTE PLACEE A LA PARTIE (scene_partie)
#... IL INTERVIENT AUSSI DANS LA NODE DE LA MAIN DU JOUEUR (player_hand_node) POUR ACTUALISER LA MAIN UNE FOIS QUE LA CARTE EST PLACEE (LIGNE 30-36 ici)

# Called when the node enters the scene tree for the first time.
func _ready():
	is_hovered = false
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (is_hovered):
		label_debug.text = "ça hover"
		if ((Input.is_action_just_released("left_click"))) :
			card_object.is_placed = true
			scene_partie.input_value_for_current_task(card_object.valeur_carte)
			card_object.suppression()
			scene_partie.next_turn()
	else:
		label_debug.text = ""

func _physics_process(delta):
	
	pass

#LES DEUX FONCTIONS SUIVANTES SONT DES FONCTIONS SIGNAL, ELLES S'ENCLENCHENT DANS CERTAINES CONDITIONS
#Ici c'est quand une zone physic 2D entre en contact avec la zone physique de la case

func _on_area_entered(area):
	card_object = area.get_parent()
	is_hovered = true
	pass # Replace with function body.

func _on_area_exited(area):
	card_object = null
	is_hovered = false
	pass # Replace with function body.
