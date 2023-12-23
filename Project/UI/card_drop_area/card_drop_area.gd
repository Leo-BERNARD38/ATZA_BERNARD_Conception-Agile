extends Area2D

@export var player_hand_node: Control
@export var label_debug: Label 
@export var scene_partie: Node2D 
var is_taken = false
var card_node
var card_value
var is_hovered

#COMMENTAIRE D'EN-TÊTE
#... CE SCRIPT DEVRA ENVOYER LES DONNEES DE LA CARTE PLACEE A LA PARTIE (scene_partie)
#... IL INTERVIENT AUSSI DANS LA NODE DE LA MAIN DU JOUEUR (player_hand_node) POUR ACTUALISER LA MAIN UNE FOIS QUE LA CARTE EST PLACEE (LIGNE 30-36 ici)

# Called when the node enters the scene tree for the first time.
func _ready():
	is_hovered = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#Pour du debug
	if (!is_taken):
		label_debug.text = "case prise"
		if (is_hovered):
			label_debug.text = "ça hover"
		else:
			label_debug.text = ""
	
	#Si le joueur vient de lâcher le click gauche et que la zone n'est pas prise, que la zone est survolée et que le joueur (player_hand_node) a pris une carte
	#... alors la carte prise par le joueur (player_hand_node.active_card_node) est définie comme placée
	#... la valeur de la carte placée dans la case (card_value dans CE script) devient la valeur de la carte (via player_hand_node.active_card_node.valeur_carte)
	#... la case est donc prise donc is_taken = true
	#... la nouvelle position de la carte prise par le joueur (player_hand_node.active_card_node.new_pos) devient celle de CETTE case
	#... le joueur n'a donc plus de carte en main car la carte a été placée, plus de carte active ni de carte prise par le joueur (on pourrait sans doute dégager la variable took_a_card de la node player_hand_node)
	if (Input.is_action_just_released("left_click") and (is_taken == false) and (is_hovered) and (player_hand_node.took_a_card)):
		#Input.is_action_just_released("left_click") et (is_hovered) non suspects
		player_hand_node.active_card_node.is_placed = true
		card_value = player_hand_node.active_card_node.valeur_carte
		is_taken = true
		player_hand_node.active_card_node.new_pos = self.global_position
		label_debug.text = str(player_hand_node.active_card_node.valeur_carte)
		player_hand_node.took_a_card = false
		player_hand_node.active_card_node = null
		pass
	pass




#LES DEUX FONCTIONS SUIVANTES SONT DES FONCTIONS SIGNAL, ELLES S'ENCLENCHENT DANS CERTAINES CONDITIONS
#Ici c'est quand une zone physic 2D entre en contact avec la zone physique de la case

func _on_area_entered(area):
	#fonctionne comme un bouton On, sinon le jeu ne va déclencher cette fonction qu'une fois (sur un seul tick), au moment où une carte est entrée dans la zone de la case
	#... donc la variable is_hovered s'active ici
	if (!is_taken):
		is_hovered = true
	pass # Replace with function body.

func _on_area_exited(area):
	#fonctionne comme un bouton Off, sinon le jeu ne va déclencher cette fonction qu'une fois (sur un seul tick), au moment où une carte est entrée dans la zone de la case
	#... donc la variable is_hovered se désactive ici
	if (!is_taken):
		is_hovered = false
	pass # Replace with function body.
