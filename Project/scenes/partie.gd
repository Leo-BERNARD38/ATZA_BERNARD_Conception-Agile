extends Node2D

@export var timer_label: Label
@export var droping_area: Area2D
@export var hand_anim: AnimationPlayer
@export var bulle_de_tache: Node2D
@export var tour_label: Label
@export var manche_label: Label
@export var table_score: Node2D
@export var draw_card_timer: Timer
@export var player_name_label: Label

@export var debug_label: Label

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
	manche = int(GAMEDATA["rules"]["manche"])
	tour = GAMEDATA["rules"]["tour"]
	manche_result_moy = GAMEDATA["rules"]["mancheresMOY"]
	manche_result_med = GAMEDATA["rules"]["mancheresMED"]
	nbr_joueur = GAMEDATA["rules"]["nbrjoueurs"]
	gamemode = GAMEDATA["rules"]["gamemode"]
	for i in range(11):
		game_results[i] =  GAMEDATA["resultats"][i]
		table_score.add_line(game_results[i],i+1)
	refresh_timer(false)
	game_start_or_reloaded()

func initialisation_pseudos():
	draw_card_timer.start()
	pass

func input_value_for_current_task(value):
	if(gamemode == "Moyenne"):
		manche_result_moy += value
		curr_GAMEDATA["rules"]["mancheresMOY"] = manche_result_moy
		if (tour == (nbr_joueur-1)):
			manche_result_moy = roundf(manche_result_moy/nbr_joueur*100)/100
			game_results[manche-1] = str(current_task) + "... score obtenu : " + str(manche_result_moy)
			curr_GAMEDATA["resultats"][manche-1] = game_results[manche-1]
			table_score.add_line(game_results[manche-1],manche)
			manche_result_moy = 0
	else:
		manche_result_med.append(value)
		manche_result_med.sort_custom(func(a, b): return a.naturalnocasecmp_to(b) < 0)
		curr_GAMEDATA["rules"]["mancheresMED"] = manche_result_med
		if (tour == (nbr_joueur-1)):
			manche_result_med.sort_custom(func(a, b): return a.naturalnocasecmp_to(b) < 0)
			game_results[manche-1] = str(current_task) +"Score obtenu : " + str(manche_result_med[round((nbr_joueur-1)/2)])
			curr_GAMEDATA["resultats"][manche-1] = game_results[manche-1]
			table_score.add_line(game_results[manche-1],manche+1)
			manche_result_med = []

func pop_task():
	if(manche == 0):
		current_task = curr_GAMEDATA["tasks"][str(randi_range(1,15))]
	else:
		var truc = randi_range(0,14)+1
		var already_here = true
		while already_here:
			truc = randi_range(0,14) +1
			for i in range(11):
				if (already_here):
					if(curr_GAMEDATA["tasks"][str(truc)] == game_results[i]):
						already_here = true
					else:
						already_here = false
		current_task = curr_GAMEDATA["tasks"][str(truc)]
	
	bulle_de_tache.change_task(current_task)
	pass

func game_start_or_reloaded():
	pop_task()
	tour_debug()
	if(game_results[10] != ""):
		gameover()
	else:
		if(manche<11):
			draw_card_timer.start()
	pass

func next_turn():
	tour+=1
	if(tour>(nbr_joueur-1)):
		tour = 0
		next_round()
	curr_GAMEDATA["rules"]["tour"] = tour
	if(manche<11):
		draw_card_timer.start()
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
			get_node("PlayerHand" + str(i+1)).visible = true
			print(str("hand_drawn_J" + str(i+1) ) + " prends ses cartes")
		else:
			get_node("PlayerHand" + str(i+1)).visible = false
			print(str("hand_drawn_J" + str(i+1)) + " range ses cartes")
	for i in range(8-nbr_joueur):
		print(str("hand_drawn_J" + str(i+1+nbr_joueur)) + " n'a pas de carte")
	pass

func next_round():
	if(manche>10):
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
	table_score.change_gamemode(gamemode)
	bulle_de_tache.get_child(0).text = ""
	for i in range(nbr_joueur):
		get_node("PlayerHand" + str(i+1)).visible = false
	print("partie terminé")
	hand_anim.play("table_scroll")
	pass

func save_game():
	var save = FileAccess.open(str("user://saves/")+str(game_name + ".json"),FileAccess.WRITE)
	var json_string = JSON.stringify(curr_GAMEDATA)
	save.store_line(json_string)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("test_key")):
#		draw_card_timer.start()
#		hand_anim.play("hand_drawn_J"+ str(tour+1))
#	if(tour != null):
#		debug_label.text = str(get_node("PlayerHand" + str(tour+1)).global_position.y)
#		debug_label.text = str(get_node("PlayerHand" + str(tour+1)))
#		debug_label.text = str(draw_card_timer.time_left)
		pass
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
	if (game_results[10] == ""):
		refresh_timer(true)


func _on_save_button_pressed():
	save_game()
	pass # Replace with function body.


func _on_quit_button_pressed():
	game_instance.main_menu()
	pass # Replace with function body.


func _on_draw_card_timer_timeout():
	if(manche<11):
		player_name_label.text = str("Joueur actuel : " + curr_GAMEDATA["Joueurs"][str(tour+1)])
		for i in range(nbr_joueur):
			print(str(curr_GAMEDATA["Joueurs"][str(i+1)]))
			get_node("PlayerHand" + str(i+1)).num_identifier = i
		player_taking_cards()
	else:
		player_name_label.text = ""
	pass # Replace with function body.
