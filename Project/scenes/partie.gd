extends Node2D

@export var timer_label: Label
@export var droping_area: Area2D
@export var hand_anim: AnimationPlayer
@export var bulle_de_tache: Node2D
@export var tour_label: Label
@export var manche_label: Label

@onready var player_hand1 = self.get_node("PlayerHand1")
@onready var player_hand2 = self.get_node("PlayerHand2")
@onready var player_hand3 = self.get_node("PlayerHand3")
@onready var player_hand4 = self.get_node("PlayerHand4")
@onready var player_hand5 = self.get_node("PlayerHand5")
@onready var player_hand6 = self.get_node("PlayerHand6")
@onready var player_hand7 = self.get_node("PlayerHand7")
@onready var player_hand8 = self.get_node("PlayerHand8")


@onready var game_instance = self.get_parent()

var curr_GAMEDATA
var game_results = ["","","","","","","","","","",""]


var game_name
var nbr_joueur
var gametime_s
var gametime_m
var manche
var tour
var gamemode = ""
var manche_result_moy
var manche_result_med
var current_task



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init_vars(GAMEDATA):
	curr_GAMEDATA = GAMEDATA
	print(GAMEDATA)
	gametime_s = GAMEDATA["rules"]["s"]
	gametime_m = GAMEDATA["rules"]["m"]
	manche = GAMEDATA["rules"]["manche"]
	tour = GAMEDATA["rules"]["tour"]
	manche_result_moy = GAMEDATA["rules"]["mancheresMOY"]
	manche_result_med = GAMEDATA["rules"]["mancheresMED"]
	nbr_joueur = GAMEDATA["rules"]["nbrjoueurs"]
	gamemode = GAMEDATA["rules"]["gamemode"]
	for i in range(11):
		game_results[i] =  GAMEDATA["resultats"][i]
	for i in range(nbr_joueur):
		get_node("PlayerHand" + str(i+1)).set_player_name(GAMEDATA["Joueurs"][str(i+1)])
		get_node("PlayerHand" + str(i+1)).num_identifier = i
	refresh_timer(false)
	game_start_or_reloaded()

func input_value_for_current_task(value):
	if(gamemode == "Moyenne"):
		manche_result_moy += value
		curr_GAMEDATA["rules"]["mancheresMOY"] = manche_result_moy
		if (tour == (nbr_joueur-1)):
			manche_result_moy = roundf(manche_result_moy/nbr_joueur*100)/100
			game_results[manche] = str(current_task) + "... score obtenu : " + str(manche_result_moy)
			manche_result_moy = 0
	else:
		manche_result_med.append(value)
		manche_result_med.sort_custom(func(a, b): return a.naturalnocasecmp_to(b) < 0)
		curr_GAMEDATA["rules"]["mancheresMED"] = manche_result_med
		if (tour == (nbr_joueur-1)):
			manche_result_med.sort_custom(func(a, b): return a.naturalnocasecmp_to(b) < 0)
			game_results[manche] = str(current_task) +"Score obtenu : " + str(manche_result_med[round((nbr_joueur-1)/2)])
			manche_result_med = []

func pop_task():
	if(manche == 0):
		current_task = curr_GAMEDATA["tasks"][str(randi_range(1,15))]
	else:
		var truc = randi_range(0,14)
		var already_here = true
		while already_here:
			truc = randi_range(0,14)
			for i in range(14):
				if (already_here):
					if(curr_GAMEDATA["tasks"][str(truc)] == game_results[i+1]):
						already_here = true
					else:
						already_here = false
		current_task = curr_GAMEDATA["tasks"][str(truc)]
	
	bulle_de_tache.change_task(current_task)
	pass

func game_start_or_reloaded():
	pop_task()
	player_taking_cards()
	tour_debug()
	pass

func next_turn():
	tour+=1
	if(tour>(nbr_joueur-1)):
		tour = 0
		next_round()
	curr_GAMEDATA["rules"]["tour"] = tour
	player_taking_cards()
	tour_debug()
	pass

func tour_debug():
	tour_label.text = "Tour : " + str(tour)
	manche_label.text = "Manche : " + str(manche)
	pass

func player_taking_cards():
	print("prends les cartes")
	for i in range(nbr_joueur):
		if (tour == get_node("PlayerHand" + str(i+1)).num_identifier):
			hand_anim.play("hand_drawn_J" + str(i+1))
			print(str("hand_drawn_J" + str(i+1)) + " prends ses cartes")
		else:
			hand_anim.play("hand_drawn_J" + str(i+1))
			print(str("hand_drawn_J" + str(i+1)) + " range ses cartes")
	for i in range(8-nbr_joueur):
		print(str("hand_drawn_J" + str(i+1+nbr_joueur)) + " n'a pas de carte")
	pass

func next_round():
	if(manche>15):
		gameover()
	else:
		pop_task()
		if gamemode == "Moyenne":
			manche_result_moy = 0
		else:
			for i in range(nbr_joueur):
				manche_result_med[i] = -1
	manche+=1
	curr_GAMEDATA["rules"]["manche"] = manche
pass

func gameover():
	print("partie terminé")
	get_tree().quit()
	pass

func save_game():
	var save = FileAccess.open(str("user://saves/")+str(game_name + ".json"),FileAccess.WRITE)
	var json_string = JSON.stringify(curr_GAMEDATA)
	save.store_line(json_string)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	pass

func refresh_timer(boolean):
	if boolean:
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
	
	curr_GAMEDATA["rules"]["s"] = gametime_s
	curr_GAMEDATA["rules"]["m"] = gametime_m
	pass

func _on_timer_timeout():
	refresh_timer(true)


func _on_save_button_pressed():
	save_game()
	pass # Replace with function body.


func _on_quit_button_pressed():
	game_instance.main_menu()
	pass # Replace with function body.
