extends Node2D

@export var card_text: Label
@onready var audio_node := $Son as AudioStreamPlayer2D
@export var valeur_carte = 0.0
@onready var Player_hand_node := $".." as Node2D
var animation_weight = 0.2
var is_hovered = false
var base_scale = 0.3
var base_size = Vector2.ZERO
@onready var base_pos = self.global_position
var zoom = 1.3
@export var current_state = true
var is_placed = false
var new_pos
# Called when the node enters the scene tree for the first time.

#COMMENTAIRE D'EN-TÊTE
#... CE SCRIPT EST ATTACHE A CHAQUE CARTE, CHAQUE CARTE EXECUTERA DONC CES FONCTIONS INDEPENDAMMENT DES AUTRES


func _ready():
	new_pos = Vector2.ZERO
	base_size.x = 256
	base_size.y = 356
#	var p_px = get_parent().global_position.x
#	var p_py = get_parent().global_position.y
#	var p_sx = get_parent().size.x
#	var p_sy = get_parent().size.y
	valuechange(valeur_carte)
#	changepos((p_px + (p_sx/2)),(p_py + (p_sy/2)))
	pass # Replace with function body.


# La fonction lerpf permet de passer d'une variable à une autre en interpollant (avec la dernière valeur de la fonction)
# en gros ça prend une valeur entre le paramètre 1 et 2 de la fonction et ça en crée une nouvelle valeur qui sera + ou - proche du 1er ou du 2nd paramètre selon le 3ème param
# on peut donc faire évoluer la valeur de sortie de façon fluide, pratique pour les animation, ça fait un peu comme la fonction 1/x en terme d'évolution
# en principe cette fonction n'atteindra donc jamais la valeur du 2nd paramètre, mais elle s'en rapprochera de + en + lentement jusqu'à ce que ce soit parfaitement invisible
# donc ici animation_weight est la variable qui définit la vitesse de l'animation, plus elle est grande plus l'animation est rapide, et inversement.
func reset_pos():
	if current_state:
		global_position.x = lerpf(global_position.x,base_pos.x, animation_weight)
		global_position.y = lerpf(global_position.y,base_pos.y, animation_weight)

#on change la valeur de la carte
func valuechange(a):
	valeur_carte = a
	update_card_state()

#pour le debug, voir si on prend bien la carte
func update_card_state():
	card_text.text = str(valeur_carte)

func drag():
	Player_hand_node.active_card_node = self
	Player_hand_node.took_a_card = true
	global_position.x = get_global_mouse_position().x 
	global_position.y = get_global_mouse_position().y
	pass

func drop():
	#Fonctionnement de la fonction drop
	#... si la carte est placée (dans une case) alors la variable is_placed (booléen) sera changé par la node de la case (cf: card_drop_area.gd)
	#... et donc si la carte est placée alors la carte placée prendra les mêmes coordonnées que la case
	#... sinon elle reviendra à sa position d'origine avec reset_pos()
	if (is_placed):
		queue_free()
	else:
		reset_pos()
	Player_hand_node.active_card_node = null
	Player_hand_node.took_a_card = false
	pass

func resize_animation(boolean):
	if(boolean == true):
		self.scale.x = lerpf(self.scale.x, base_scale * zoom,animation_weight)
		self.scale.y = lerpf(self.scale.y, base_scale * zoom,animation_weight)
	else:
		self.scale.x = lerpf(self.scale.x, base_scale,animation_weight)
		self.scale.y = lerpf(self.scale.y, base_scale,animation_weight)
	pass

func changepos(x,y):
	self.global_position.x = x
	self.global_position.y = y

func get_on_top(a):
	if(a):
		z_index = 2
	else:
		z_index = 1
	pass

func get_to_pos(a):
	is_placed == true
	global_position.x = lerpf(global_position.x,a.x, animation_weight)
	global_position.y = lerpf(global_position.y,a.y, animation_weight)

func suppression():
	get_parent().remove_child(self)
	pass


func _on_clickingarea_mouse_entered():
	if Player_hand_node.took_a_card == false:
		is_hovered = true
		if(current_state == true):
			audio_node.play()
	pass # Replace with function body.

func _on_clickingarea_mouse_exited():
	is_hovered = false
	if(current_state == true):
		audio_node.stop()
	pass # Replace with function body.

func _process(delta):
	
	#Gestion du drag :
	#... Si la carte est survolée, si le joueur appuie sur clic gauche, si l'état de la carte est actif,
	#... si la carte prise par le joueur est cette même carte ou que le joueur n'a pas pris de carte ALORS
	#... la carte active (qu'on est en train de bouger quoi) devient CETTE carte (self) et le joueur prendra donc cette carte
	#... la position de la carte dépendra alors de la position du curseur ( drag() )
	#... la fonction get_on_top change l'ordre des assets 2D, on veut pas que la carte prise par le joueur se retrouve en background
	if current_state:
		if((is_hovered) and (Input.is_action_pressed("left_click")) and (current_state) and ((Player_hand_node.active_card_node == self) or (Player_hand_node.active_card_node == null))):
				drag()
				get_on_top(true)
		
		if(Player_hand_node.active_card_node == null):
			resize_animation(is_hovered)
		if (is_placed):
			drop()
		else:
			if(!Input.is_action_pressed("left_click")):
				drop()
				
				if Player_hand_node.took_a_card == true:
					Player_hand_node.took_a_card = false
				get_on_top(false)
			pass
	pass

func _physics_process(delta):
	
	#Faire des animations par le code demande un rafraîchissement stable
	#... donc on met ces animations dans la fonction physics_process(delta) qui se rafraîchit selon les ticks du projet (qu'on peut changer si on veut)
	#...  
	pass

