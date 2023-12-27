extends ColorRect

@export var list: OptionButton
@export var nom_partie: TextEdit
@export var Moy: Button
@export var Med: Button
@export var player_list: VBoxContainer


var gonna_export_nom_partie
var gonna_export_nbr_joueurs = 0
var gonna_export_noms_joueurs = ["","","","","","","",""]
var gonna_export_mode_de_jeu

@onready var main_menu = self.get_parent()
@onready var game_instance = main_menu.get_parent()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func unlock_mode_de_jeu(boolean):
	if boolean:
		Moy.disabled = false
		Med.disabled = false
	else:
		Moy.disabled = true
		Med.disabled = true
	pass


func export_data():
	for i in range(gonna_export_nbr_joueurs-1):
		if(gonna_export_noms_joueurs[i] == ""): 
			gonna_export_noms_joueurs[i] = "Joueur " + str(i+1) 
	var save_data = {
		"rules" : {
			"m" : 0,
			"s" : 0,
			"manche" : 0,
			"tour" : 0,
			"gamemode" : str(gonna_export_mode_de_jeu),
			"nbrjoueurs" : gonna_export_nbr_joueurs,
			"mancheresMOY" : 0,
			"mancheresMED" : []
		},
		
		"Joueurs" : {
			"1": gonna_export_noms_joueurs[0],
			"2": gonna_export_noms_joueurs[1],
			"3": gonna_export_noms_joueurs[2],
			"4": gonna_export_noms_joueurs[3],
			"5": gonna_export_noms_joueurs[4],
			"6": gonna_export_noms_joueurs[5],
			"7": gonna_export_noms_joueurs[6],
			"8": gonna_export_noms_joueurs[7]
		},
		
		"tasks" : {
			"1" : "Se faire un café",
			"2" : "Créer une interface",
			"3" : "Mettre en place une base de données",
			"4" : "Trouver un créneau pour une réunion",
			"5" : "Négocier un contrat avec une grande entreprise",
			"6" : "Licencier quelqu'un",
			"7" : "Deviner ce qu'un client veut",
			"8" : "Créer un OS en Assembly",
			"9" : "Communiquer avec plusieurs acteurs simultanément sur un même projet",
			"10" : "Organiser une pizza party au bureau",
			"11" : "Réaliser un projet avec 10 personnes",
			"12" : "Réaliser un projet avec 3 personnes",
			"13" : "Apprendre à utiliser un nouvel outil",
			"14" : "Trouver une place de parking",
			"15" : "Anticiper les accidents"
		},
		"resultats" : ["","","","","","","","","","",""]
	}
	
	return save_data

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ( ((gonna_export_nom_partie!= "") and (gonna_export_nom_partie!= null)) and (list.get_selected_id() > -1) ):
		unlock_mode_de_jeu(true)
	else:
		unlock_mode_de_jeu(false)
	pass


func _on_retour_pressed():
	main_menu.get_back_sound()
	
	queue_free()
	pass # Replace with function body.



func _on_option_button_item_selected(index):
	main_menu.get_selected_sound()
	gonna_export_nbr_joueurs = index+2
	for i in range(8):
		if((i+1) >(index + 2)):
			player_list.get_child(i).get_child(1).text = ""
			player_list.get_child(i).visible = false
		else:
			player_list.get_child(i).visible = true
		pass
	
	pass # Replace with function body.


func _on_mediane_pressed():
	main_menu.get_selected_sound()
	gonna_export_mode_de_jeu = "Mediane"
	game_instance.create_json_file(gonna_export_nom_partie, export_data())
	game_instance.load_game(gonna_export_nom_partie)
	pass # Replace with function body.


func _on_moyenne_pressed():
	main_menu.get_selected_sound()
	gonna_export_mode_de_jeu = "Moyenne"
	game_instance.create_json_file(gonna_export_nom_partie,export_data())
	game_instance.load_game(gonna_export_nom_partie)
	pass # Replace with function body.


func _on_nom_partie_text_changed():
	if(nom_partie.text != "" and nom_partie.text != null):
		gonna_export_nom_partie = nom_partie.text
	else:
		unlock_mode_de_jeu(false)
	pass # Replace with function body.


func _on_pseudo_joueur_1_text_changed():
	gonna_export_noms_joueurs[0] = player_list.get_child(0).get_child(1).text
	pass

func _on_pseudo_joueur_2_text_changed():
	gonna_export_noms_joueurs[1] = player_list.get_child(1).get_child(1).text
	pass # Replace with function body.

func _on_pseudo_joueur_3_text_changed():
	gonna_export_noms_joueurs[2] = player_list.get_child(2).get_child(1).text
	pass # Replace with function body.

func _on_pseudo_joueur_4_text_changed():
	gonna_export_noms_joueurs[3] = player_list.get_child(3).get_child(1).text
	pass # Replace with function body.

func _on_pseudo_joueur_5_text_changed():
	gonna_export_noms_joueurs[4] = player_list.get_child(4).get_child(1).text
	pass # Replace with function body.

func _on_pseudo_joueur_6_text_changed():
	gonna_export_noms_joueurs[5] = player_list.get_child(5).get_child(1).text
	pass # Replace with function body.

func _on_pseudo_joueur_7_text_changed():
	gonna_export_noms_joueurs[6] = player_list.get_child(6).get_child(1).text
	pass # Replace with function body.

func _on_pseudo_joueur_8_text_changed():
	gonna_export_noms_joueurs[7] = player_list.get_child(7).get_child(1).text
	pass # Replace with function body.
