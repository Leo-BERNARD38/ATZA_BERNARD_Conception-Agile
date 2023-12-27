extends Node

@export var title_screen: PackedScene
@export var partie: PackedScene

var music_volume


@onready var save_dir_path = "user://saves/"
@onready var main_dir = DirAccess.open("user://")

# Called when the node enters the scene tree for the first time.
func _ready():
	verify_save_directory(save_dir_path)
	
	main_menu()
	pass # Replace with function body.

func verify_save_directory(path : String):
	DirAccess.make_dir_absolute(path)
	pass


func create_json_file(nom_file,save_data):
	var save = FileAccess.open(save_dir_path+str(nom_file + ".json"),FileAccess.WRITE)
	var json_string = JSON.stringify(save_data, "\t")
	save.store_string(json_string)
	save.close()
	pass

func load_json_file(filename):
	if FileAccess.file_exists(save_dir_path+str(filename + ".json")):
		var datafile = FileAccess.open(save_dir_path+str(filename + ".json"), FileAccess.READ)
		
		var content = datafile.get_as_text()
		datafile.close()
		
		var parsedResult = JSON.parse_string(content)
		
		if parsedResult is Dictionary:
			return parsedResult
		else:
			print("Erreur : fichier corrompue...")
	else:
		print("Ce fichier n'existe pas" + filename + ".json")
	pass


func load_game(filename):
	var game = partie.instantiate()
	var gameData = load_json_file(filename)
	
	var parse_result
	var partie_data
	var game_scene = get_child(0)
	
	if not FileAccess.file_exists(save_dir_path + str(filename + ".json")):
		return
	
	var get_save_file = FileAccess.open(save_dir_path + str(filename + ".json"), FileAccess.READ)
	
	while get_save_file.get_position() < get_save_file.get_length():
		var json_string = get_save_file.get_line()
		var json = JSON.new()
		parse_result = json.parse(json_string)
		partie_data = json.get_data()
	
		#on initialise ici
	
	clear_scene()
	add_child(game)
	get_child(0).curr_GAMEDATA = gameData
	get_child(0).game_name = filename 
	get_child(0).init_vars(gameData)
#	get_child(0).game_name = filename 
#	get_child(0).init_vars(game_state.secondes, game_state.minutes, game_state.manche, game_state.tour, game_state.nbrjoueurs, game_state.mode, game_state.noms_joueurs)
	
	pass


func clear_scene():
	var child_node = get_child(0)
	remove_child(child_node)
	pass

func main_menu():
	clear_scene()
	var main_menu_instance = title_screen.instantiate()
	add_child(main_menu_instance)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
