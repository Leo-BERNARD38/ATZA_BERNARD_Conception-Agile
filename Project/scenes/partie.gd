extends Node2D

@export var timer_label: Label
@export var player_hand: Node2D
@export var droping_area: Area2D
@export var hand_anim: AnimationPlayer

@onready var game_instance = self.get_parent()

var curr_GAMEDATA
var game_results = ["","","","","","","","","","","","","","",""]


var game_name
var nbr_joueur
var gametime_s = 0
var gametime_m = 0
var manche = 0
var tour = 0
var gamemode = ""
var manche_result_moy = 0
var manche_result_med
var current_task



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init_vars(GAMEDATA):
	gametime_s = GAMEDATA["rules"]["s"]
	gametime_m = GAMEDATA["rules"]["m"]
	manche = GAMEDATA["rules"]["manche"]
	tour = GAMEDATA["rules"]["tour"]
	nbr_joueur = GAMEDATA["rules"]["nbrjoueurs"]
	gamemode = GAMEDATA["rules"]["gamemode"]
	for i in range(nbr_joueur):
		get_node("PlayerHand" + str(i+1)).set_player_name(GAMEDATA["Joueurs"][str(i+1)])

func input_value_for_current_task(value):
	if(gamemode == "Moyenne"):
		manche_result_moy += value
		if (tour == (nbr_joueur-1)):
			manche_result_moy = roundf(manche_result_moy/nbr_joueur*100)/100
			game_results[manche] = str(current_task) + "... score obtenu : " + str(manche_result_moy)
	else:
		if (tour == (nbr_joueur-1)):
			manche_result_med.sort_custom(func(a, b): return a.naturalnocasecmp_to(b) < 0)
			game_results[manche] = str(current_task) +"Score obtenu : " + str(manche_result_med[round((nbr_joueur-1)/2)])

func new_task():
	if(manche == 0):
		current_task = curr_GAMEDATA["tasks"][str(randi_range(0,14))]
	else:
		var truc = randi_range(0,14)
		var already_here = true
		while already_here:
			truc = randi_range(0,14)
			for i in range(14):
				if (already_here):
					if(curr_GAMEDATA["tasks"][str(truc)] == game_results[i]):
						already_here = true
					else:
						already_here = false
		current_task = curr_GAMEDATA["tasks"][str(truc)]
	
	pass

func next_turn():
	tour+=1
	if(tour>(nbr_joueur-1)):
		tour = 0
		next_round()
	pass

func next_round():
	if(manche>15):
		gameover()
	else:
		new_task()
		if gamemode == "Moyenne":
			manche_result_moy = 0
		else:
			for i in range(nbr_joueur):
				manche_result_med[i] = -1
	manche+=1
pass

func gameover():
	queue_free()
	pass

func save_game():
	var save = FileAccess.open(str("res://saves/")+str(game_name + ".json"),FileAccess.WRITE)
	var json_string = JSON.stringify(curr_GAMEDATA)
	save.lin
	save.store_line(json_string)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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


func _on_save_button_pressed():
	save_game()
	pass # Replace with function body.


func _on_quit_button_pressed():
	game_instance.main_menu()
	pass # Replace with function body.
